
import UIKit
import CoreLocation

class SchoolViewController: UIViewController
{
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
        
    @IBOutlet weak var markButton: UIButton! //MARK MY ATTENDANCE
    var noOfVisit = 0
    var visitDate = ""
    
    let locationManager = CLLocationManager()
    var currentLoc: CLLocation? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.dateField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        checkLocationPermission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userdef = UserDefaults.standard
        let loggin_id = userdef.string(forKey: LOGGIN_ID)
        if(loggin_id != nil && loggin_id?.isEmpty == false){
            self.markButton.setTitle("END MY DAY", for: .normal)
        }else{
            self.markButton.setTitle("MARK MY ATTENDANCE", for: .normal)
        }
        if(FormViewController.noOfVisit != 0){
            self.textField.text = FormViewController.noOfVisit.string
        }else{
            self.textField.text = ""
        }
        self.check_tracking()
    }
    
    //Allow Gurukul to access current location for tracking
    
    
    @IBAction func handleMarkButton(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            
           
            if(self.markButton.currentTitle == "MARK MY ATTENDANCE"){
                if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == .authorizedAlways) {
                    currentLoc = locationManager.location ?? nil
                    print(currentLoc?.coordinate.latitude.string ?? "")
                    print(currentLoc?.coordinate.longitude.string ?? "")
                    self.startTracing(user_lat:currentLoc?.coordinate.latitude.string ?? "", user_lng: currentLoc?.coordinate.longitude.string ?? "")
                    
                }
                //trackingOn
                
            }else{
                //trackingOff
                self.stopUserLocation()
                endTrackingPop()
            }
            
        }else{
            checkLocationPermission()
        }
        
    }
    
    
//    @FormUrlEncoded
//        @POST("tracking_loggin")
//        Call<String> trackingLoggin(@Field("user_id") String user_id,@Field("user_lat") String user_lat,@Field("user_lng") String user_lng);
//
//        @FormUrlEncoded
//        @POST("tracking_loggOut")
//        Call<String> trackingLoggOut(@Field("user_id") String user_id, @Field("logg_id") String logg_id,@Field("user_lat") String user_lat,@Field("user_lng") String user_lng,@Field("end_status") String end_status);

    
    func endTrackingPop(){
        
        showYesNoAlertWithCompletion(onVC: self, title: "Confirmation", message: "Are you sure you want end your day", btnOkTitle: "Yes", btnCancelTitle: "No") {
            //call Api
            self.callEnd()
        }

        
    }
    
    func callEnd(){
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
            self.currentLoc = self.locationManager.location ?? nil
            print(self.currentLoc?.coordinate.latitude.string ?? "")
            print(self.currentLoc?.coordinate.longitude.string ?? "")
            let logg_id = ""
            self.endTracing(user_lat: self.currentLoc?.coordinate.latitude.string ?? "", user_lng:  self.currentLoc?.coordinate.longitude.string ?? "", logg_id: logg_id)
        }
    }
    

    
    func endTracing(user_lat:String,user_lng:String,logg_id:String){
       displaySpinner()
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        let loggin_id = userdef.string(forKey: LOGGIN_ID)
        
        let params = ["user_id":user_id as AnyObject,
                      "logg_id":loggin_id as AnyObject,
                      "user_lat":user_lat as AnyObject,
                      "user_lng":user_lng as AnyObject,
                      "end_status":"1" as AnyObject
        ]
        WebServices.trackingLogout(params) { isSuccess, message, response, userStatus in
            removeSpinner()
            showToast(message: message)
            if(userStatus){
                self.markButton.setTitle("MARK MY ATTENDANCE", for: .normal)
                //print(response)
                let userdef = UserDefaults.standard
                userdef.set("", forKey: LOGGIN_ID)
                UserDefaults.standard.removeObject(forKey: LOGGIN_ID)
                self.stopUserLocation()
            } else {
                self.markButton.setTitle("MARK MY ATTENDANCE", for: .normal)
                //print(response)
                let userdef = UserDefaults.standard
                userdef.set("", forKey: LOGGIN_ID)
                UserDefaults.standard.removeObject(forKey: LOGGIN_ID)
                self.stopUserLocation()
            }
        }
    }
    
    func check_tracking(){
       //displaySpinner()
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        
        let params = ["user_id":user_id as AnyObject,]
        WebServices.checktracking(params) { isSuccess, message, response, userStatus in
            //removeSpinner()
            print(message)
            //showToast(message: message)
            if(userStatus){
                self.markButton.setTitle("END MY DAY", for: .normal)
                self.checkLocationPermission()
            } else {
                self.markButton.setTitle("MARK MY ATTENDANCE", for: .normal)
                let userdef = UserDefaults.standard
                userdef.set("", forKey: LOGGIN_ID)
                UserDefaults.standard.removeObject(forKey: LOGGIN_ID)
                self.stopUserLocation()
            }
        }
    }
    
    func startTracing(user_lat:String,user_lng:String){
        displaySpinner()
        
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        let params = ["user_id" : user_id as AnyObject,
                      "user_lat": user_lat as AnyObject,
                      "user_lng": user_lng as AnyObject
        ]
        print(params)
        WebServices.trackingLogin(params) { isSuccess, message, response, userStatus in
            removeSpinner()
            showToast(message: message)
            if(userStatus){
                print(response)
                if(response != nil && response?.count ?? 0 > 0){
                    if let data = response?[0]{
                        let loggin_id = data["loggin_id"] as? String ?? ""
                        //String loggin_id = jData.getString("loggin_id");
                        let userdef = UserDefaults.standard
                        userdef.set(loggin_id, forKey: LOGGIN_ID)
                        self.markButton.setTitle("END MY DAY", for: .normal)
                        self.getUserLocation()
                    }
                }
            }
        }
    }
    
    func checkLocationPermission(){
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 100
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
           
        }else{
            locationManager.startUpdatingLocation()
        }
    }
    
    func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
    }
    
    func stopUserLocation() {
        locationManager.stopUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = false
    }
    
    
    @objc func tapDone()
    {
        if let datePicker = self.dateField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "dd-MM-yyyy"
            self.dateField.text = dateformatter.string(from: datePicker.date)
            
            let safeDate = datePicker.date
            let strTime = safeDate.dateStringWith(strFormat: "yyyy-MM-dd HH:mm:ss")
            print(strTime)
            self.visitDate = strTime
        }
        self.dateField.resignFirstResponder()
    }
    
    @IBAction func nextBtnAction(_ sender: Any)
    {
        if (textField.text?.isEmpty)!
        {
            alertModule(onVC: self, title: Alert, msg: Number_of_school)
        }
        else if (Int(textField.text ?? "0") == 0){
            alertModule(onVC: self, title: Alert, msg: "no. of school must greater than 0")
        }
        else if (dateField.text?.isEmpty)!
        {
            alertModule(onVC: self, title: Alert, msg: Select_date)
        }
       
        else
        {
            noOfVisit = Int(textField.text ?? "0") ?? 0
            if let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.FORM_VC) as? FormViewController{
                FormViewController.noOfVisit = self.noOfVisit
                vc.visitDate = self.visitDate
                navigationController?.pushViewController(vc,animated: true)
            }
        }
        
    }
    
    func addTrackingInfo(track_lat:String,track_lng:String){
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        let loggin_id = userdef.string(forKey: LOGGIN_ID)
        
        let params = ["user_id":user_id as AnyObject,
                      "logg_id":loggin_id as AnyObject,
                      "track_lat":track_lat as AnyObject,
                      "track_lng":track_lng as AnyObject
        ]
        print(params)
        WebServices.trackingInfo(params) { isSuccess, message, response, userStatus in
            print(message)
        }
    }
    
}
extension Date {
         func dateStringWith(strFormat: String) -> String {
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = Calendar.current.timeZone
                dateFormatter.locale = Calendar.current.locale
                dateFormatter.dateFormat = strFormat
                return dateFormatter.string(from: self)
            }
}

extension SchoolViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("not determined - hence ask for Permission")
            self.locationManager.requestAlwaysAuthorization()
        case .restricted, .denied:
            print("permission denied")
            self.locationManager.requestAlwaysAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("Apple delegate gives the call back here once user taps Allow option, Make sure delegate is set to self")
            let userdef = UserDefaults.standard
            let loggin_id = userdef.string(forKey: LOGGIN_ID)
            if( loggin_id?.isEmpty == false){
                self.locationManager.startUpdatingLocation()
            }
        @unknown default:
            print("default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // marker moving code
        if let location = locations.last {
              print("Lat : \(location.coordinate.latitude) \nLng : \(location.coordinate.longitude)")
            let userdef = UserDefaults.standard
            let loggin_id = userdef.string(forKey: LOGGIN_ID)
            if(loggin_id != nil && loggin_id?.isEmpty == false){
                self.addTrackingInfo(track_lat: location.coordinate.latitude.string, track_lng: location.coordinate.longitude.string)
            }
        }

        
        // marker
        
//        for location in locations {
//
//        }
    }
    
    func calculateDistance(myLocation:CLLocation,myBuddysLocation:CLLocation) -> String{
        let distance = myLocation.distance(from: myBuddysLocation) / 1000

        //Display the result in km
        print(String(format: "The distance to my buddy is %.01fkm", distance))
        return String(format: "%.01f km", distance)
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error::: \(error)")
        locationManager.stopUpdatingLocation()
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
extension LosslessStringConvertible {
    var string: String { .init(self) }
}
