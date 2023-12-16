
import UIKit
import GrowingTextView
import DropDown

protocol OnRefreshDelegate{
    func onRefreshed()
}
var onRefreshDelegate : OnRefreshDelegate?
class FormViewController: UIViewController,UITextViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var etState: UITextField!
    
    @IBOutlet weak var etDistrict: UITextField!
    
    @IBOutlet weak var etArea: UITextField!
    
    @IBOutlet weak var viewArea: UIView!
    
    @IBOutlet weak var remarksView: GrowingTextView!
    @IBOutlet weak var throughPartyBtn: UIButton!
    @IBOutlet weak var directBtn: UIButton!
    @IBOutlet weak var partyTxt: UITextField!
    @IBOutlet weak var partyView: UIView!
    @IBOutlet weak var partyLbl: UILabel!
    @IBOutlet weak var samplingMonthTop: NSLayoutConstraint!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet var boardBtnArray: [UIButton]!
    @IBOutlet var categoryArray: [UIButton]!
    
    @IBOutlet weak var etSchoolName: UITextField!
    
    
    @IBOutlet weak var etSchoolAddress: UITextField!
    
    @IBOutlet weak var etPincode: UITextField!
    
    @IBOutlet weak var etSchoolPhone: UITextField!
    
    
    @IBOutlet weak var etMobileNumber: UITextField!
    
    @IBOutlet weak var etEmail: UITextField!
    
    
    @IBOutlet weak var etSchoolStg: UITextField!
    
    
    @IBOutlet weak var etSchoolUpto: UITextField!
    
    
    @IBOutlet weak var etNoOfBranch: UITextField!
    
    @IBOutlet weak var etSamplingMonth: UITextField!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var etRemark: GrowingTextView!
    
    var stateList = [StateData]()
    var stateStrList = [String]()
    
    var districtList = [StateData]()
    var districtStrList = [String]()
    
    var cityList = [StateData]()
    var cityStrList = [String]()
    
    var schoolList = [SearchSchoolData]()
    var schoolStrList = [String]()
    
    var partyList = [PartyData]()
    var partyStrList = [String]()

    var stateDropdown = DropDown()
    var districtDropdown = DropDown()
    var cityDropdown = DropDown()
    var schoolDropdown = DropDown()
    var partyDropdown = DropDown()
    
    static var noOfVisit = 0
    var visitDate = ""
    var sch_caterogy = ""
    var boardStr = ""
    var purchaseStr = ""
    var partyId = ""
    static var schoolID = ""
    static var visit_purpose = ""
    
    var selectedButton = 0
    
    var params : [String:AnyObject] = [:]
    
    var schoolData = SearchSchoolData()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.btnEdit.isHidden = true
        self.btnEdit.addTarget(self, action: #selector(onEdit(_:)), for: .touchUpInside)
        setupUi()
        samplingMonthTop.constant = 16
        
        onRefreshDelegate = self
    }
    
    @IBAction func  onEdit( _ sender : UIButton){
        showYesNoAlertWithCompletion(onVC: self, title: "Confrimation", message: "Are you sure you want to edit schoolName name", btnOkTitle: "Yes", btnCancelTitle: "No") {
            let userdef = UserDefaults.standard
            userdef.set(FormViewController.schoolID, forKey: SCHOOL_ID)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStateApi()
    }
    
    func setupUi()
    {
        remarksView.delegate = self
        remarksView.placeholder = Remarks
        remarksView.font = UIFont(name: "Arial", size: 17)
        remarksView.minHeight = 100
        remarksView.maxHeight = 100
        remarksView.tintColor = .black
        self.etState.addTarget(self, action: #selector(onStateTextFeild(_:)), for: .editingChanged)
        self.etDistrict.addTarget(self, action: #selector(onDistrictTextFeild(_:)), for: .editingChanged)
        self.etSchoolName.addTarget(self, action: #selector(onSchoolNameTextFeild(_:)), for: .editingChanged)
        
        self.partyTxt.addTarget(self, action: #selector(onPartyNameTextFeild(_:)), for: .editingChanged)
        
        self.stateDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.etState.text = item
            let filtered = self.stateList.filter {
                return $0.name.range(of: item, options: .caseInsensitive) != nil
            }
            self.getDistrictApi(state_id: filtered.first?.id ?? "")
        }
        
        self.districtDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.etDistrict.text = item
            let filtered = self.districtList.filter {
                return $0.name.range(of: item, options: .caseInsensitive) != nil
            }
            self.getDistrictCity(district_id: filtered.first?.id ?? "")
        }
        
        self.cityDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.etArea.text = item
            let filtered = self.cityList.filter {
                return $0.name.range(of: item, options: .caseInsensitive) != nil
            }
            //self.getDistrictCity(district_id: filtered.first?.id ?? "")
        }
        
        self.schoolDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.etSchoolName.text = item
            let filtered = self.schoolList.filter {
                return $0.schoolName.range(of: item, options: .caseInsensitive) != nil
            }
            
            setDataOfSchool(data: filtered.first ?? SearchSchoolData())
        }
        
        self.partyDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.partyTxt.text = item
            let filtered = self.partyList.filter {
                return $0.partyName.range(of: item, options: .caseInsensitive) != nil
            }
            self.partyId = filtered.first?.id ?? ""
            
        }
        
        self.viewArea.isUserInteractionEnabled = true
        self.viewArea.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCitySelect(_:))))
        
        self.etSamplingMonth.showInputViewDatePicker(target: self, selector: #selector(tapDone))
        
    }
    
    func setDataOfSchool(data:SearchSchoolData){
        self.schoolData = data
        self.etSchoolAddress.text = data.address
        self.etPincode.text = data.pincode
        self.etSchoolPhone.text = data.schPhone
        self.etMobileNumber.text = data.schMobile
        self.etEmail.text = data.schEmail
        self.etSchoolStg.text = data.schStg
        self.etSchoolUpto.text = data.schUpto
        self.etNoOfBranch.text = data.sch_branches
        self.etSamplingMonth.text = data.samplingMonth
        self.partyTxt.text = data.partyName
        self.partyId = data.partyId
        self.etRemark.text = data.remarks
        
        self.btnEdit.isHidden = false
        
        FormViewController.schoolID = data.formId
        
        self.boardStr = data.bose
        
        if (data.bose == "CBSE"){
            boardBtnArray[0].isSelected = true
            selectedButton = 0
        }else if (data.bose == "State Board"){
            boardBtnArray[1].isSelected = true
            selectedButton = 1
        }else if (data.bose == "ICSE"){
            boardBtnArray[2].isSelected = true
            selectedButton = 2
        }
        
        self.sch_caterogy = data.schCategory
        
        if (data.schCategory == "A"){
            categoryArray[0].isSelected = true
            selectedButton = 0
        }else if (data.schCategory == "B"){
            categoryArray[1].isSelected = true
            selectedButton = 1
        }else if (data.schCategory == "C"){
            categoryArray[2].isSelected = true
            selectedButton = 2
        }
        
        self.purchaseStr = data.purchase
        
        if(data.purchase == "Direct"){
            
            partyView.isHidden = true
            partyTxt.isHidden = true
            partyLbl.isHidden = true
            samplingMonthTop.constant = 16
            directBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            throughPartyBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
            
        }else{
            
            partyView.isHidden = false
            partyTxt.isHidden = false
            partyLbl.isHidden = false
            samplingMonthTop.constant = 84.5
            throughPartyBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            directBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
            
        }
        
        FormViewController.visit_purpose = data.visitPurpose
        
        
        
        
        
    }
    
    func reset(){
        self.btnEdit.isHidden = true
        self.schoolData = SearchSchoolData()
        let data = SearchSchoolData()
        self.etSchoolAddress.text = data.address
        self.etPincode.text = data.pincode
        self.etSchoolPhone.text = data.schPhone
        self.etMobileNumber.text = data.schMobile
        self.etEmail.text = data.schEmail
        self.etSchoolStg.text = data.schStg
        self.etSchoolUpto.text = data.schUpto
        self.etNoOfBranch.text = data.sch_branches
        self.etSamplingMonth.text = data.samplingMonth
        self.partyTxt.text = data.partyName
        self.partyId = data.partyId
        self.etRemark.text = data.remarks
        
        self.boardStr = data.bose
        
        if (data.bose == "CBSE"){
            boardBtnArray[0].isSelected = true
            selectedButton = 0
        }else if (data.bose == "State Board"){
            boardBtnArray[1].isSelected = true
            selectedButton = 1
        }else if (data.bose == "ICSE"){
            boardBtnArray[2].isSelected = true
            selectedButton = 2
        }else{
            boardBtnArray[0].isSelected = false
            boardBtnArray[1].isSelected = false
            boardBtnArray[2].isSelected = false
        }
        
        self.sch_caterogy = data.schCategory
        
        if (data.schCategory == "A"){
            categoryArray[0].isSelected = true
            selectedButton = 0
        }else if (data.schCategory == "B"){
            categoryArray[1].isSelected = true
            selectedButton = 1
        }else if (data.schCategory == "C"){
            categoryArray[2].isSelected = true
            selectedButton = 2
        }else{
            categoryArray[0].isSelected = false
            categoryArray[1].isSelected = false
            categoryArray[2].isSelected = false
        }
        
        self.purchaseStr = data.purchase
        
        if(data.purchase == "Direct"){
            
            partyView.isHidden = true
            partyTxt.isHidden = true
            partyLbl.isHidden = true
            samplingMonthTop.constant = 16
            directBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            throughPartyBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
            
        }else if(data.purchase == "through party"){
            
            partyView.isHidden = false
            partyTxt.isHidden = false
            partyLbl.isHidden = false
            samplingMonthTop.constant = 84.5
            throughPartyBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            directBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
            
        }else{
            samplingMonthTop.constant = 16
            throughPartyBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
            directBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
        }
        
        FormViewController.visit_purpose = ""
        
        
        
        
        
    }
    
    
    @objc func tapDone()
    {
        if let datePicker = self.etSamplingMonth.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "yyyy-MM-dd"
            self.etSamplingMonth.text = dateformatter.string(from: datePicker.date)
        }
        self.etSamplingMonth.resignFirstResponder()
    }
    
    @objc func onCitySelect( _ textFeild : Any){
        self.cityDropdown.anchorView = self.viewArea
        self.cityDropdown.dataSource = self.cityStrList
        self.cityDropdown.bottomOffset = CGPoint(x: 0, y:(self.cityDropdown.anchorView?.plainView.bounds.height) ?? 40)
        self.cityDropdown.show()
    }
    
    
    
    @objc func onStateTextFeild( _ textFeild : UITextField){
        let filtered = self.stateStrList.filter {
            return $0.range(of: textFeild.text ?? "", options: .caseInsensitive) != nil
        }
        
        self.stateDropdown.anchorView = self.etState
        self.stateDropdown.dataSource = filtered
        self.stateDropdown.bottomOffset = CGPoint(x: 0, y:(self.stateDropdown.anchorView?.plainView.bounds.height) ?? 40)
        self.stateDropdown.show()
        
    }
    
    @objc func onDistrictTextFeild( _ textFeild : UITextField){
        let filtered = self.districtStrList.filter {
            return $0.range(of: textFeild.text ?? "", options: .caseInsensitive) != nil
        }
        
        self.districtDropdown.anchorView = self.etDistrict
        self.districtDropdown.dataSource = filtered
        self.districtDropdown.bottomOffset = CGPoint(x: 0, y:(self.districtDropdown.anchorView?.plainView.bounds.height) ?? 40)
        self.districtDropdown.show()
        
    }
    
    var searchTimer: Timer?
    var partyTimer: Timer?
    
    @objc func onSchoolNameTextFeild( _ textFeild : UITextField){
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        
        // reschedule the search: in 1.0 second, call the searchForKeyword method on the new textfield content
        searchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchForKeyword(_:)), userInfo: textFeild.text ?? "", repeats: false)
        
    }
    
    @objc func onPartyNameTextFeild( _ textFeild : UITextField){
        if partyTimer != nil {
            partyTimer?.invalidate()
            partyTimer = nil
        }
        
        // reschedule the search: in 1.0 second, call the searchForKeyword method on the new textfield content
        partyTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchForKeywordParty(_:)), userInfo: textFeild.text ?? "", repeats: false)
        
    }
    
    @objc func searchForKeyword(_ timer: Timer) {
        
        // retrieve the keyword from user info
        let keyword = timer.userInfo as? String ?? ""
        
        if(keyword.isEmpty == true){
            self.reset()
        }else{
            self.getAllSearchedSchools(school_name: keyword)
        }
        
        print("Searching for keyword \(keyword)")
       
    }
    
    @objc func searchForKeywordParty(_ timer: Timer) {
        
        // retrieve the keyword from user info
        let keyword = timer.userInfo as? String ?? ""
        
        print("Searching for keyword \(keyword)")
        getSearchedParty(party_name: keyword)
    }
    
    @IBAction func boardBtnArrayClicked(_ sender: UIButton) {
        
        let tag = sender.tag
        boardBtnArray[selectedButton].isSelected = false
        boardBtnArray[tag].isSelected = true
        selectedButton = tag
        if (tag == 0){
            self.boardStr = "CBSE"
        }else if (tag == 1){
            self.boardStr = "State Board"
        }else if (tag == 2){
            self.boardStr = "ICSE"
        }
    }
    
    @IBAction func categoryBtnCLicked(_ sender: UIButton) {
        
        let tag = sender.tag
        categoryArray[selectedButton].isSelected = false
        categoryArray[tag].isSelected = true
        selectedButton = tag
        if (tag == 0){
            self.sch_caterogy = "A"
        }else if (tag == 1){
            self.sch_caterogy = "B"
        }else if (tag == 2){
            self.sch_caterogy = "C"
        }
        
    }
   
    
    @IBAction func directBtnAction(_ sender: Any)
    {
        partyView.isHidden = true
        partyTxt.isHidden = true
        partyLbl.isHidden = true
        samplingMonthTop.constant = 16
        directBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
        throughPartyBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
        self.purchaseStr = "Direct"

    }
    
    @IBAction func backBtnClicked(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func throughPartyBtnAction(_ sender: UIButton)
    {
        partyView.isHidden = false
        partyTxt.isHidden = false
        partyLbl.isHidden = false
        samplingMonthTop.constant = 84.5
        throughPartyBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
        directBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
        self.purchaseStr =  "through party"
        print(throughPartyBtn.titleLabel?.text ?? "")
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton)
    {
        params["visited_area"] = self.etArea.text as AnyObject
        params["sch_category"] = sch_caterogy as AnyObject
        params["school_name"] = self.etSchoolName.text as AnyObject
        params["address"] = self.etSchoolAddress.text as AnyObject
        params["sch_phone"] = self.etSchoolPhone.text as AnyObject
        params["sch_email"] = self.etEmail.text as AnyObject
        params["sch_mobile"] = self.etMobileNumber.text as AnyObject
        params["district"] = self.etDistrict.text as AnyObject
        params["city"] = self.etArea.text as AnyObject
        params["state"] = self.etState.text as AnyObject
        params["sch_stg"] = self.etSchoolStg.text as AnyObject
        params["sch_upto"] = self.etSchoolUpto.text as AnyObject
        params["sch_branches"] = self.etNoOfBranch.text as AnyObject
        params["pincode"] = self.etPincode.text as AnyObject
        params["bose"] = self.boardStr as AnyObject
        params["purchase"] = self.purchaseStr as AnyObject
        params["sampling_month"] = self.etSamplingMonth.text as AnyObject
        params["remarks"] = self.etRemark.text as AnyObject
        params["party_id"] = self.partyId as AnyObject
        params["party_name"] = self.partyTxt.text as AnyObject
        params["visit_date"] = self.visitDate as AnyObject
        //params["visit_purpose"] = self.visit_purpose as AnyObject
        
        print(params)
        
        if(self.etState.text?.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter state")
        }else if(self.etDistrict.text?.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter district")
        }else if(self.etArea.text?.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter city")
        }else if(self.etSchoolName.text?.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter school name")
        }else if(self.etSchoolAddress.text?.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter school address")
        }else if(self.etMobileNumber.text?.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter mobile number")
        }else if(self.etSchoolStg.text?.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter school stg.")
        }else if(self.etSchoolUpto.text?.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter school upto")
        }else if(self.etNoOfBranch.text?.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter no. of branch")
        }else if(self.boardStr.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please select board")
        }else if(self.sch_caterogy.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please select school category")
        }else if(self.purchaseStr.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please select purchase")
        }else if(self.etSamplingMonth.text?.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter sampling month")
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.SELECTION_COMMITTEE_VC) as! SelectionCommitteeViewController
            vc.receivedString = "true"
            vc.params = params
            vc.concern_person = self.schoolData.concernPerson
            vc.concern_name = self.schoolData.concernName
            vc.concern_phone = self.schoolData.concernM
            vc.noOfVisit = FormViewController.noOfVisit
            
            navigationController?.pushViewController(vc,animated: true)
        }
    }
    
    func getStateApi(){
        self.stateList.removeAll()
        self.stateStrList.removeAll()
        //let vc = SignInViewController.displaySpinner(onView: self.view)
        
        let params: [String: AnyObject] = ["" :"" as AnyObject,]
        
        WebServices.getAllINDStates(params) { isSuccess, message, stateData, userStatus in
            
            if isSuccess {
                self.stateList = stateData ?? []
                print(self.stateList)
                //SignInViewController.removeSpinner(spinner: vc)
                if self.stateList.count > 0{
                    self.stateList.forEach { data in
                        self.stateStrList.append(data.name)
                    }
                }
                print(self.stateStrList)

            }
            else{
                alertModule(onVC: self, title: Alert, msg: message)
                //SignInViewController.removeSpinner(spinner: vc)
            }
            
        }
        
    }
    
    
    func getDistrictApi(state_id:String){
        self.districtList.removeAll()
        self.districtStrList.removeAll()
        //let vc = SignInViewController.displaySpinner(onView: self.view)
        
        let params: [String: AnyObject] = ["state_id" : state_id as AnyObject,]
        
        WebServices.getDistrictState(params) { isSuccess, message, stateData, userStatus in
            
            if isSuccess {
                self.districtList = stateData ?? []
                print(self.districtList)
                //SignInViewController.removeSpinner(spinner: vc)
                if self.districtList.count > 0{
                    self.districtList.forEach { data in
                        self.districtStrList.append(data.name)
                    }
                }
                print(self.districtStrList)

            }
            else{
                alertModule(onVC: self, title: Alert, msg: message)
                //SignInViewController.removeSpinner(spinner: vc)
            }
            
        }
        
    }
    
    func getDistrictCity(district_id:String){
        self.cityList.removeAll()
        self.cityStrList.removeAll()
        //let vc = SignInViewController.displaySpinner(onView: self.view)
        
        let params: [String: AnyObject] = ["district_id" : district_id as AnyObject,]
        
        WebServices.getDistrictCity(params) { isSuccess, message, stateData, userStatus in
            
            if isSuccess {
                self.cityList = stateData ?? []
                print(self.cityList)
                //SignInViewController.removeSpinner(spinner: vc)
                if self.cityList.count > 0{
                    self.cityList.forEach { data in
                        self.cityStrList.append(data.name)
                    }
                }
                print(self.cityList)

            }
            else{
                alertModule(onVC: self, title: Alert, msg: message)
                //SignInViewController.removeSpinner(spinner: vc)
            }
            
        }
        
    }
    
    
    func getAllSearchedSchools(school_name:String){
        self.schoolList.removeAll()
        self.schoolStrList.removeAll()
        //let vc = SignInViewController.displaySpinner(onView: self.view)
        
//        params.put("school_name", schName);
//               params.put("state",state);
//               params.put("district",district);
//               params.put("city",city);
//               params.put("seller_id",Prefs.getId(AddFormActivity.this));
        
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        
        let params: [String: AnyObject] = [
            "school_name" : school_name as AnyObject,
            "state" : self.etState.text as AnyObject,
            "district" : self.etDistrict.text as AnyObject,
            "city" : self.etArea.text as AnyObject,
            "seller_id" : user_id as AnyObject,
        ]
        
        print(params)
        
        WebServices.getAllSearchedSchools(params) { isSuccess, message, schoolData, userStatus in
            
            if isSuccess {
                self.schoolList = schoolData ?? []
                print(self.schoolList)
                //SignInViewController.removeSpinner(spinner: vc)
                if self.schoolList.count > 0{
                    self.schoolList.forEach { data in
                        self.schoolStrList.append(data.schoolName)
                    }
                }
                print(self.schoolStrList)
                if(self.schoolStrList.count > 0){
                    self.schoolDropdown.anchorView = self.etSchoolName
                    self.schoolDropdown.dataSource = self.schoolStrList
                    self.schoolDropdown.bottomOffset = CGPoint(x: 0, y:(self.schoolDropdown.anchorView?.plainView.bounds.height) ?? 40)
                    self.schoolDropdown.show()
                }

            }
            else{
                print("getAllSearchedSchools",message)
                self.reset()
                //alertModule(onVC: self, title: Alert, msg: message)
                //SignInViewController.removeSpinner(spinner: vc)
            }
            
        }
        
    }
    
    func getSearchedParty(party_name:String){
        self.partyList.removeAll()
        self.partyStrList.removeAll()
        //let vc = SignInViewController.displaySpinner(onView: self.view)
        
//        params.put("party_name", party_name);
//               params.put("state",state);
//               params.put("district",district);
//               params.put("city",city);
//               params.put("seller_id",Prefs.getId(AddFormActivity.this));
        
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        
        let params: [String: AnyObject] = [
            "party_name" : party_name as AnyObject,
            "state" : self.etState.text as AnyObject,
            "district" : self.etDistrict.text as AnyObject,
            "city" : self.etArea.text as AnyObject,
            "seller_id" : user_id as AnyObject,
        ]
        
        print(params)
        
        WebServices.getSearchedParty(params) { isSuccess, message, partyData, userStatus in
            
            if isSuccess {
                self.partyList = partyData ?? []
                print(self.partyList)
                //SignInViewController.removeSpinner(spinner: vc)
                if self.partyList.count > 0{
                    self.partyList.forEach { data in
                        self.partyStrList.append(data.partyName)
                    }
                }
                print(self.partyStrList)
                if(self.partyStrList.count > 0){
                    self.partyDropdown.anchorView = self.partyTxt
                    self.partyDropdown.dataSource = self.partyStrList
                    self.partyDropdown.bottomOffset = CGPoint(x: 0, y:(self.partyDropdown.anchorView?.plainView.bounds.height) ?? 40)
                    self.partyDropdown.show()
                }

            }
            else{
                print("getSearchedParty",message)
                //alertModule(onVC: self, title: Alert, msg: message)
                //SignInViewController.removeSpinner(spinner: vc)
            }
            
        }
        
    }
}
extension FormViewController : OnRefreshDelegate{
    func onRefreshed() {
        
        self.stateList.removeAll()
        self.stateStrList.removeAll()
        
        self.districtList.removeAll()
        self.districtStrList.removeAll()
        
        self.cityList.removeAll()
        self.cityStrList.removeAll()
        
        self.schoolList.removeAll()
        self.schoolStrList.removeAll()
        
        self.partyList.removeAll()
        self.partyStrList.removeAll()
        
        self.schoolList.removeAll()
        self.schoolStrList.removeAll()
        
        self.partyList.removeAll()
        self.partyStrList.removeAll()
        
        
        self.etSchoolName.text = ""
        self.partyTxt.text = ""
        self.etState.text = ""
        self.etArea.text = ""
        self.etDistrict.text = ""
        
        self.reset()
        self.scrollView.setContentOffset(.zero, animated: true)
    }
    
    
}
