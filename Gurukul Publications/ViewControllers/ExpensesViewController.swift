
import UIKit
import SDWebImage
import ToastViewSwift
class ExpensesViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var localBtn: UIButton!
    @IBOutlet weak var outStationBtn: UIButton!
    @IBOutlet var checkBoxArray: [UIButton]!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet var travledView: UIView!
    @IBOutlet var localTAView: UIView!
    @IBOutlet var LocalDAView: UIView!
    @IBOutlet var originView: UIView!
    @IBOutlet var otherDestinationView: UIView!
    @IBOutlet var workingView: UIView!
    @IBOutlet var returnView: UIView!
    @IBOutlet var modeTravelView: UIView!
    @IBOutlet var categoriesView: UIView!
    @IBOutlet var kmTravled: UIView!
    @IBOutlet var outStationTA: UIView!
    @IBOutlet var outStationDA: UIView!
    @IBOutlet var startKms: UIView!
    @IBOutlet var endKms: UIView!
    @IBOutlet var expense1: UIView!
    @IBOutlet var expense2: UIView!
    @IBOutlet var expense3: UIView!
    @IBOutlet var totalExpense: UIView!
    @IBOutlet var remarksView: UIView!
    @IBOutlet var returnBtns: [UIButton]!
    @IBOutlet var taImageView: UIView!
    @IBOutlet var daImageView: UIView!
    @IBOutlet var startKmsImageView: UIView!
    @IBOutlet var endKmsImageView: UIView!
    @IBOutlet var missExpImageView1: UIView!
    @IBOutlet var missExpImageView2: UIView!
    @IBOutlet var missExpImageView3: UIView!
    @IBOutlet var taImageBtn: UIButton!
    @IBOutlet var daImageBtn: UIButton!
    @IBOutlet var outStationTAImageBtn: UIButton!
    @IBOutlet var outStationDAImageBtn: UIButton!
    @IBOutlet var startKmsImageBtn: UIButton!
    @IBOutlet var endKmsImageBtn: UIButton!
    @IBOutlet var missExpImageBtn1: UIButton!
    @IBOutlet var missExpImageBtn2: UIButton!
    @IBOutlet var missExpImageBtn3: UIButton!
    @IBOutlet var addSupportingBtn: UIButton!
    @IBOutlet var taImage: UIImageView!
    @IBOutlet var daImage: UIImageView!
    @IBOutlet var startKmsImage: UIImageView!
    @IBOutlet var endKmsImage: UIImageView!
    @IBOutlet var missExpImage1: UIImageView!
    @IBOutlet var missExpImage2: UIImageView!
    @IBOutlet var missExpImage3: UIImageView!
    @IBOutlet var scrollViewBottom: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageStackView: UIStackView!
    
    
    @IBOutlet weak var localKMET: UITextField!
    
    @IBOutlet weak var localTAET: UITextField!
    
    @IBOutlet weak var localDAET: UITextField!
    
    @IBOutlet weak var outOriginDestinationET: UITextField!
    
    @IBOutlet weak var outWorkingDestinationET: UITextField!
    
    @IBOutlet weak var outOtherDestinationET: UITextField!
    
    @IBOutlet weak var localModeTravel: UITextField!
    
    @IBOutlet weak var localModeTravelHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var outLmstravelET: UITextField!
    
    
    @IBOutlet weak var outTAET: UITextField!
    
    @IBOutlet weak var outDAET: UITextField!
    
    @IBOutlet weak var outStartKmsET: UITextField!
    
    @IBOutlet weak var outEndKmsET: UITextField!
    
    @IBOutlet weak var missExpET1: UITextField!
    
    @IBOutlet weak var missExpET2: UITextField!
    
    @IBOutlet weak var missExpET3: UITextField!
    
  
    @IBOutlet weak var remarks: UITextField!
    
    @IBOutlet weak var totalExpEt: UITextField!
    
    var expenseType = "Local"
    var modeOfTravel = ""
    var returnStr = ""
    
    
    var selectedButton = 0
    var selectedReturnButtons = 0
    var ImageBtnTitle = ""
    
    var params : [String:AnyObject] = [:]
    
    var taImageFile : UIImage? = nil
    var daImageFile : UIImage? = nil
    var supportImageFile : UIImage? = nil
    var startKmsImageFile : UIImage? = nil
    var endKmsImageFile : UIImage? = nil
    var exp1ImageFile : UIImage? = nil
    var exp2ImageFile : UIImage? = nil
    var exp3ImageFile : UIImage? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.submitBtn.isEnabled = false
        self.submitBtn.isUserInteractionEnabled = false
        self.submitBtn.alpha = 0.4
        
        self.dateField.showInputViewDatePicker(target: self, selector: #selector(tapDone))
        setupUI()
        self.missExpET1.delegate = self
        self.missExpET2.delegate = self
        self.missExpET3.delegate = self
        
        self.missExpET1.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
        self.missExpET2.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
        self.missExpET3.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
        
        self.localDAET.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
        
        self.localTAET.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
        
        self.outDAET.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
        
        self.outTAET.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let mis1 = ((self.missExpET1.text?.isEmpty == false ? self.missExpET1.text ?? "0" : "0") as NSString).doubleValue
        let mis2 = ((self.missExpET2.text?.isEmpty == false ? self.missExpET2.text ?? "0" : "0") as NSString).doubleValue
        let mis3 = ((self.missExpET3.text?.isEmpty == false ? self.missExpET3.text ?? "0" : "0") as NSString).doubleValue
        if(expenseType == "Local"){
            let ta = ((self.localTAET.text?.isEmpty == false ? self.localTAET.text ?? "0" : "0") as NSString).doubleValue
            let da = ((self.localDAET.text?.isEmpty == false ? self.localDAET.text ?? "0" : "0") as NSString).doubleValue
            
            if((mis1+mis2+mis3+ta+da) > 0){
                self.totalExpEt.text = "\(mis1+mis2+mis3+ta+da)"
            }else{
                self.totalExpEt.text = ""
            }
            
        }else{
            let ta = ((self.outTAET.text?.isEmpty == false ? self.outTAET.text ?? "0" : "0") as NSString).doubleValue
            let da = ((self.outDAET.text?.isEmpty == false ? self.outDAET.text ?? "0" : "0") as NSString).doubleValue
            
            if((mis1+mis2+mis3+ta+da) > 0){
                self.totalExpEt.text = "\(mis1+mis2+mis3+ta+da)"
            }else{
                self.totalExpEt.text = ""
            }
            
        }
        
        if(textField == self.localDAET){
            if(textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
               
                self.daImageView.isHidden = true
                self.daImage.image = nil
                self.daImageFile = nil
                
            }
        }else if(textField == self.missExpET1){
            if(textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                self.missExpImageView1.isHidden = true
                self.missExpImage1.image = nil
                self.exp1ImageFile = nil
            }
        }else if(textField == self.missExpET2){
            if(textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                self.missExpImageView2.isHidden = true
                self.missExpImage2.image = nil
                self.exp2ImageFile = nil
            }
        }else if(textField == self.missExpET3){
            if(textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                self.missExpImageView3.isHidden = true
                self.missExpImage3.image = nil
                self.exp3ImageFile = nil
            }
        }
        
        
    }
    
    @objc func tapDone() {
        if let datePicker = self.dateField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = Date_formatterSlash
            self.dateField.text = dateformatter.string(from: datePicker.date)
            self.checkTADAFundsByDate(date: self.dateField.text ?? "")
        }
        self.dateField.resignFirstResponder()
    }
    
    func setupUI(){
        originView.isHidden = true
        workingView.isHidden = true
        otherDestinationView.isHidden = true
        returnView.isHidden = true
        kmTravled.isHidden = false
        outStationDA.isHidden = true
        outStationTA.isHidden = true
    }
    
    @IBAction func outStationBtnAction(_ sender: UIButton)
    {
        expenseType = "OutStatation"
        if outStationBtn.currentImage == UIImage(named: "uncheckbox.png") {
            self.outStationBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            self.localBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
            setupOutStationUi()
        }
        else
        {
            self.outStationBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            self.localBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
            setupOutStationUi()
        }
    }
    func setupOutStationUi(){
        originView.isHidden = false
        workingView.isHidden = false
        otherDestinationView.isHidden = false
        returnView.isHidden = false
        kmTravled.isHidden = false
        outStationDA.isHidden = false
        outStationTA.isHidden = false
        travledView.isHidden = true
        localTAView.isHidden = true
        LocalDAView.isHidden = true
        
    }
    @IBAction func addSupportingBtnAction(_ sender: UIButton)
    {
        ImageBtnTitle = "Add Supporting Document"
        chooseImage()
    }
    @IBAction func localBtnAction(_ sender: UIButton) {
        self.expenseType = "Local"
        if localBtn.currentImage == UIImage(named: "uncheckbox.png") {
            self.localBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            self.outStationBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
            steupLocalBtnUI()
            setupUI()
        }
        else {
            self.localBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            steupLocalBtnUI()
        }
    }
    func steupLocalBtnUI() {
        travledView.isHidden = true
        localTAView.isHidden = false
        LocalDAView.isHidden = false
    }
    
    @IBAction func returnBtnsClicked(_ sender: UIButton) {
        let tag = sender.tag
        returnBtns[selectedReturnButtons].isSelected = false
        returnBtns[tag].isSelected = true
        selectedReturnButtons = tag
        if(tag == 0){
            self.returnStr = "Same day return"
        }else if(tag == 1){
            self.returnStr = "Night stay"
        }else if(tag == 2){
            self.returnStr = "Return Home Destination"
        }
    }
    
    
    @IBAction func checkBoxArrayAction(_ sender: UIButton) {
        
        let tag = sender.tag
        checkBoxArray[selectedButton].isSelected = false
        checkBoxArray[tag].isSelected = true
        selectedButton = tag
        if(tag == 0){
            self.modeOfTravel = "Car"
        }else if(tag == 1){
            self.modeOfTravel = "Bike"
        }else if(tag == 2){
            self.modeOfTravel = "Scooter"
        }else if(tag == 3){
            self.modeOfTravel = "Auto"
        }else if(tag == 4){
            self.modeOfTravel = "Plane"
        }else if(tag == 5){
            self.modeOfTravel = "Train"
        }else if(tag == 6){
            self.modeOfTravel = "Taxi"
        }else if(tag == 7){
            self.modeOfTravel = "Bus"
        }else if(tag == 8){
            self.modeOfTravel = "Other"
        }
    }
    
    @IBAction func taBtnClicked(_ sender: UIButton) {
        ImageBtnTitle = "Local TA"
        chooseImage()
        
        
    }
    
    @IBAction func daBtnClicked(_ sender: UIButton) {
        ImageBtnTitle = "Local DA"
        chooseImage()
        
    }
    @IBAction func outStationTABtnClicked(_ sender: UIButton) {
        ImageBtnTitle = "Out Station TA"
        chooseImage()
        
    }
    
    @IBAction func outStationDABtnClicked(_ sender: UIButton)
    {
        
        ImageBtnTitle = "Out Station DA"
        chooseImage()
    }
    
    @IBAction func startKmsBtnClicked(_ sender: UIButton)
    {
        
        ImageBtnTitle = "Start Kms"
        chooseImage()
    }
    
    @IBAction func endKmsBtnClicked(_ sender: UIButton)
    {
        ImageBtnTitle = "End Kms"
        chooseImage()
    }
    
    @IBAction func missExpBtnClicked1(_ sender: UIButton)
    {
        ImageBtnTitle = "Miss. Expense1"
        chooseImage()
    }
    
    @IBAction func missExpBtnClicked2(_ sender: UIButton)
    {
        ImageBtnTitle = "Miss. Expense2"
        chooseImage()
    }
    
    @IBAction func missExpBtnClicked3(_ sender: UIButton)
    {
        ImageBtnTitle = "Miss. Expense3"
        chooseImage()
    }
    
    
    
    
    @IBAction func submitBtnAction(_ sender: UIButton)
    
    {
        //let toast = Toast.text("hello")
        //toast.show()
        if(self.dateField.text?.isEmpty == false){
            if(expenseType == "Local"){
                
                let localTA =  self.localTAET.text ?? ""
                let localDA =  self.localDAET.text ?? ""
                let localModeOfTravel = self.modeOfTravel
                let localStartkms =  self.outStartKmsET.text ?? ""
                let localEndkms =  self.outEndKmsET.text ?? ""
                let localkmstraveled =  self.outLmstravelET.text ?? ""
                let localMissExp1 =  self.missExpET1.text ?? ""
                let localMissExp2 =  self.missExpET2.text ?? ""
                let localMissExp3 =  self.missExpET3.text ?? ""
                let localRemarks =  self.remarks.text ?? ""
                let localTotalExp =  self.totalExpEt.text ?? ""
                
                self.params = [:]
                
                let userdef = UserDefaults.standard
                let user_id = userdef.string(forKey: user_Id)
                
                
                params["fund_type"] =  self.expenseType as AnyObject
                params["seller_id"] =  user_id as AnyObject
                params["traveled_km"] =  localkmstraveled as AnyObject
                params["travel_mode"] =  localModeOfTravel as AnyObject
                params["ta_expenses"] =  localTA as AnyObject
                params["da_expenses"] =  localDA as AnyObject
                params["other_expenses"] =  "" as AnyObject
                params["school_visited"] =  "" as AnyObject
                params["parties_visited"] =  "" as AnyObject
                params["origin_destn"] =  "" as AnyObject
                params["work_destn"] =  "" as AnyObject
                params["stay_info"] =  "" as AnyObject
                params["total_expenses"] =  localTotalExp as AnyObject
                params["other_destn"] =  "" as AnyObject
                params["miss_exp1st"] =  localMissExp1 as AnyObject
                params["miss_exp2nd"] =  localMissExp2 as AnyObject
                params["miss_exp3rd"] =  localMissExp3 as AnyObject
                params["remarks"] =  localRemarks as AnyObject
                params["payment"] =  "" as AnyObject
                params["cities"] =  "" as AnyObject
                params["added_date"] =  self.dateField.text as AnyObject
                params["start_km"] =  localStartkms as AnyObject
                params["end_km"] =  localEndkms as AnyObject
                
                if(localTA.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter TA")
                }else if(localModeOfTravel.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please select mode of travel")
                }else if(localStartkms.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter start kms")
                }else if(localEndkms.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter end kms")
                }else if(localkmstraveled.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter kms traveled")
                }else{
                    if((localTA as NSString).doubleValue > 0 && self.taImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload ta")
                    }else if(localDA.isEmpty == false && (localDA as NSString).doubleValue > 0 && self.daImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload da")
                    }else if(self.startKmsImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload start kms")
                    }else if(self.endKmsImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload end kms")
                    }else if(localMissExp1.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false && (localMissExp1 as NSString).doubleValue > 0 && self.exp1ImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload miss exp. 1")
                    }else if(localMissExp2.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false && (localMissExp2 as NSString).doubleValue > 0 && self.exp2ImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload miss exp. 2")
                    }else if(localMissExp3.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false && (localMissExp3 as NSString).doubleValue > 0 && self.exp3ImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload miss exp. 3")
                    }else{
                        self.addLocalExpenss()
                    }
                }
                
                
                
                
                
            }else{
                let outOriginDestination = self.outOriginDestinationET.text ?? ""
                let outWorkingDestination = self.outWorkingDestinationET.text ?? ""
                let outotherDestination = self.outOtherDestinationET.text ?? ""
                let outReturn = self.returnStr
                let outModeOfTravel = self.modeOfTravel
                
                let outTA =  self.outTAET.text ?? ""
                let outDA =  self.outDAET.text ?? ""
                
                let outStartkms =  self.outStartKmsET.text ?? ""
                let outEndkms =  self.outEndKmsET.text ?? ""
                let outkmstraveled =  self.outLmstravelET.text ?? ""
                let outMissExp1 =  self.missExpET1.text ?? ""
                let outMissExp2 =  self.missExpET2.text ?? ""
                let outMissExp3 =  self.missExpET3.text ?? ""
                let outRemarks =  self.remarks.text ?? ""
                let outTotalExp =  self.totalExpEt.text ?? ""
                
                self.params = [:]
                
                let userdef = UserDefaults.standard
                let user_id = userdef.string(forKey: user_Id)
                
                
                params["fund_type"] =  self.expenseType as AnyObject
                params["seller_id"] =  user_id as AnyObject
                params["traveled_km"] =  outkmstraveled as AnyObject
                params["travel_mode"] =  outModeOfTravel as AnyObject
                params["ta_expenses"] =  outTA as AnyObject
                params["da_expenses"] =  outDA as AnyObject
                params["other_expenses"] =  "" as AnyObject
                params["school_visited"] =  "" as AnyObject
                params["parties_visited"] =  "" as AnyObject
                params["origin_destn"] =  outOriginDestination as AnyObject
                params["work_destn"] =  outWorkingDestination as AnyObject
                params["stay_info"] =  outReturn as AnyObject
                params["total_expenses"] =  outTotalExp as AnyObject
                params["other_destn"] =  outotherDestination as AnyObject
                params["miss_exp1st"] =  outMissExp1 as AnyObject
                params["miss_exp2nd"] =  outMissExp2 as AnyObject
                params["miss_exp3rd"] =  outMissExp3 as AnyObject
                params["remarks"] =  outRemarks as AnyObject
                params["payment"] =  "" as AnyObject
                params["cities"] =  "" as AnyObject
                params["added_date"] =  self.dateField.text as AnyObject
                params["start_km"] =  outStartkms as AnyObject
                params["end_km"] =  outEndkms as AnyObject
                
                
                if(outOriginDestination.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter origin destination")
                }else if(outWorkingDestination.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter working destination")
                }else if(outReturn.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please select stay info")
                }else if(outModeOfTravel.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please select mode of travel")
                }else if(outTA.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter TA")
                }else if(outStartkms.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter start kms")
                }else if(outEndkms.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter end kms")
                }else if(outkmstraveled.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter kilometer traveled")
                }else{
                    if((outTA as NSString).doubleValue > 0 && self.taImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload ta")
                    }else if(outDA.isEmpty == false && (outDA as NSString).doubleValue > 0  && self.daImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload da")
                    }else if(self.startKmsImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload start kms")
                    }else if(self.endKmsImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload end kms")
                    }else if(outMissExp1.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false && (outMissExp1 as NSString).doubleValue > 0  && self.exp1ImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload miss exp. 1")
                    }else if(outMissExp2.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false && (outMissExp2 as NSString).doubleValue > 0 && self.exp2ImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload miss exp. 2")
                    }else if(outMissExp3.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false && (outMissExp3 as NSString).doubleValue > 0 && self.exp3ImageFile == nil){
                        alertModule(onVC: self, title: Alert, msg: "Please upload miss exp. 3")
                    }else{
                        self.addOutExpenss()
                    }
                    
                }
                
                
                
            }
        }else{
            alertModule(onVC: self, title: Alert, msg: "Please select date")
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        // Allow to remove character (Backspace)
        if string == "" {
            return true
        }

       // Block multiple dot
        if (textField.text?.contains("."))! && string == "." {
            return false
        }

        // Check here decimal places
        if (textField.text?.contains("."))! {
            let limitDecimalPlace = 2
            let decimalPlace = textField.text?.components(separatedBy: ".").last
            if (decimalPlace?.count)! < limitDecimalPlace {
                return true
            }
            else {
                return false
            }
        }
        return true
    }
    
    func chooseImage()
    {
        let alert = UIAlertController(title: Choose_image, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Camera, style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: Gallery, style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: Cancel, style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: Warning, message: Camera_msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: OK, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: Warning, message: Gallery_premission, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: OK, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:-- ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            // imageViewPic.contentMode = .scaleToFill
            if ImageBtnTitle == "Add Supporting Document"
            {
                self.addSupportingBtn.setImage(pickedImage, for: .normal)
                self.supportImageFile = pickedImage
            }
            else if ImageBtnTitle == "Local TA" || ImageBtnTitle == "Out Station TA"
            {
                taImageView.isHidden = false
                self.taImage.image = pickedImage
                self.taImageFile = pickedImage
            }
            else if ImageBtnTitle == "Local DA" || ImageBtnTitle == "Out Station DA"
            {
                daImageView.isHidden = false
                self.daImage.image = pickedImage
                self.daImageFile = pickedImage
            }
            else if ImageBtnTitle == "Start Kms"
            {
                startKmsImageView.isHidden = false
                self.startKmsImage.image = pickedImage
                self.startKmsImageFile = pickedImage
            }
            else if ImageBtnTitle == "End Kms"
            {
                endKmsImageView.isHidden = false
                self.endKmsImage.image = pickedImage
                self.endKmsImageFile = pickedImage
            }
            
            else if ImageBtnTitle == "Miss. Expense1"
            {
                missExpImageView1.isHidden = false
                self.missExpImage1.image = pickedImage
                self.exp1ImageFile = pickedImage
            }
            else if ImageBtnTitle == "Miss. Expense2"
            {
                missExpImageView2.isHidden = false
                self.missExpImage2.image = pickedImage
                self.exp2ImageFile = pickedImage
            }
            else
            {
                missExpImageView3.isHidden = false
                self.missExpImage3.image = pickedImage
                self.exp3ImageFile = pickedImage
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func reset(){
        self.localTAET.text =  ""
        self.localDAET.text =  ""
        self.modeOfTravel = ""
        self.outStartKmsET.text =  ""
        self.outEndKmsET.text =  ""
        self.outLmstravelET.text =  ""
        self.missExpET1.text =  ""
        self.missExpET2.text =  ""
        self.missExpET3.text =  ""
        self.remarks.text =  ""
        self.totalExpEt.text =  ""
        
        self.outOriginDestinationET.text =  ""
        self.outWorkingDestinationET.text =  ""
        self.outOtherDestinationET.text =  ""
        self.returnStr = ""
        self.modeOfTravel = ""
        
        self.outTAET.text =  ""
        self.outDAET.text =  ""
        
        self.outStartKmsET.text =  ""
        self.outEndKmsET.text =  ""
        self.outLmstravelET.text =  ""
        self.missExpET1.text =  ""
        self.missExpET2.text =  ""
        self.missExpET3.text =  ""
        self.remarks.text =  ""
        self.totalExpEt.text =  ""
        
        self.taImageFile = nil
        self.daImageFile  = nil
        self.supportImageFile  = nil
        self.startKmsImageFile  = nil
        self.endKmsImageFile  = nil
        self.exp1ImageFile  = nil
        self.exp2ImageFile  = nil
        self.exp3ImageFile  = nil
        
        self.checkBoxArray.forEach { button in
            button.isSelected = false
        }
        
        self.returnBtns.forEach { button in
            button.isSelected = false
        }
        
        self.selectedButton = 0
        self.selectedReturnButtons = 0
        
        
        self.taImageView.isHidden = true
        self.taImage.image = nil
        self.taImageFile = nil
        
        
        self.daImageView.isHidden = true
        self.daImage.image = nil
        self.daImageFile = nil
        
        self.startKmsImageView.isHidden = true
        self.startKmsImage.image = nil
        self.startKmsImageFile = nil
        
        self.endKmsImageView.isHidden = true
        self.endKmsImage.image = nil
        self.endKmsImageFile = nil
        
        self.missExpImageView1.isHidden = true
        self.missExpImage1.image = nil
        self.exp1ImageFile = nil
        
        self.missExpImageView2.isHidden = true
        self.missExpImage2.image = nil
        self.exp2ImageFile = nil
        
        self.missExpImageView3.isHidden = true
        self.missExpImage3.image = nil
        self.exp3ImageFile = nil
        
    }
    
}
extension ExpensesViewController{
    
    func addLocalExpenss(){
        displaySpinner()
        
        var imageparams : [String:UIImage?] = [:]
        
        if(self.supportImageFile == nil){
            self.params["doc"] = "" as AnyObject
        }else{
            imageparams["doc"] = self.supportImageFile
        }
        
        if(self.taImageFile == nil || self.localDAET.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            self.params["ta_doc"] = "" as AnyObject
        }else{
            imageparams["ta_doc"] = self.taImageFile
        }
        
        if(self.daImageFile == nil || self.localDAET.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            self.params["da_doc"] = "" as AnyObject
        }else{
            imageparams["da_doc"] = self.daImageFile
        }
        
        if(self.startKmsImageFile == nil){
            self.params["start_km_doc"] = "" as AnyObject
        }else{
            imageparams["start_km_doc"] = self.startKmsImageFile
        }
        
        if(self.endKmsImageFile == nil){
            self.params["end_km_doc"] = "" as AnyObject
        }else{
            imageparams["end_km_doc"] = self.endKmsImageFile
        }
        
        
        if(self.exp1ImageFile == nil || self.missExpET1.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            self.params["miss_exp1st_doc"] = "" as AnyObject
        }else{
            imageparams["miss_exp1st_doc"] = self.exp1ImageFile
        }
        
        if(self.exp2ImageFile == nil || self.missExpET2.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            self.params["miss_exp2nd_doc"] = "" as AnyObject
        }else{
            imageparams["miss_exp2nd_doc"] = self.exp2ImageFile
        }
        
        if(self.exp3ImageFile == nil || self.missExpET3.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            self.params["miss_exp3rd_doc"] = "" as AnyObject
        }else{
            imageparams["miss_exp3rd_doc"] = self.exp3ImageFile
        }
        
        print(params)
        WebServices.callsendDataImageAPI(URLName: API_NAME.shared.base_url + API_NAME.shared.addTADAFunds, param:params, arrImage: imageparams) { response,message  in
           removeSpinner()
            print(response)
            
            if(response != nil){
                _ = response?[WebConstants.STATUS] as? Bool ?? true
                let error_message = response?[WebConstants.MESSAGE] as? String ?? ""
                showToast(message: error_message)
                self.reset()
            }else{
                showToast(message: message != nil ? message : "")
            }
        }
        
        
    }
    
    func addOutExpenss(){
        displaySpinner()
        
        var imageparams : [String:UIImage?] = [:]
        
        if(self.supportImageFile == nil){
            self.params["doc"] = "" as AnyObject
        }else{
            imageparams["doc"] = self.supportImageFile
        }
        
        if(self.taImageFile == nil || self.outTAET.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            self.params["ta_doc"] = "" as AnyObject
        }else{
            imageparams["ta_doc"] = self.taImageFile
        }
        
        if(self.daImageFile == nil || self.outDAET.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            self.params["da_doc"] = "" as AnyObject
        }else{
            imageparams["da_doc"] = self.daImageFile
        }
        
        if(self.startKmsImageFile == nil){
            self.params["start_km_doc"] = "" as AnyObject
        }else{
            imageparams["start_km_doc"] = self.startKmsImageFile
        }
        
        if(self.endKmsImageFile == nil){
            self.params["end_km_doc"] = "" as AnyObject
        }else{
            imageparams["end_km_doc"] = self.endKmsImageFile
        }
        
        
        if(self.exp1ImageFile == nil || self.missExpET1.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            self.params["miss_exp1st_doc"] = "" as AnyObject
        }else{
            imageparams["miss_exp1st_doc"] = self.exp1ImageFile
        }
        
        if(self.exp2ImageFile == nil || self.missExpET2.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            self.params["miss_exp2nd_doc"] = "" as AnyObject
        }else{
            imageparams["miss_exp2nd_doc"] = self.exp2ImageFile
        }
        
        if(self.exp3ImageFile == nil || self.missExpET3.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            self.params["miss_exp3rd_doc"] = "" as AnyObject
        }else{
            imageparams["miss_exp3rd_doc"] = self.exp3ImageFile
        }
        
        print(params)
        WebServices.callsendDataImageAPI(URLName: API_NAME.shared.base_url + API_NAME.shared.addTADAFunds, param:params, arrImage: imageparams) { response,message  in
            removeSpinner()
            print(response)
           
            if(response != nil){
                _ = response?[WebConstants.STATUS] as? Bool ?? true
                let error_message = response?[WebConstants.MESSAGE] as? String ?? ""
                showToast(message: error_message)
                self.reset()
                
            }else{
                showToast(message: message != nil ? message : "")
            }
        }
        
    }
    
    func checkTADAFundsByDate(date:String){
        self.view.endEditing(true)
        displaySpinner()
        
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id) ?? ""
        
        let params : [String:AnyObject] = ["added_date":date as AnyObject,"seller_id":user_id as AnyObject]
        WebServices.checkTADAFundsByDate(params) { isSuccess, message, status in
            removeSpinner()
            if(status){
               showToast(message: message)
                self.submitBtn.isEnabled = true
                self.submitBtn.isUserInteractionEnabled = true
                self.submitBtn.alpha = 1
            }else{
                showToast(message: message)
                self.submitBtn.isEnabled = false
                self.submitBtn.isUserInteractionEnabled = false
                self.submitBtn.alpha = 0.4
            }
        }
    }
    
}
