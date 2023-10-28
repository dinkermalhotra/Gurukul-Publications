
import UIKit
import GrowingTextView
import DropDown
class AddPartyViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var remarksView: GrowingTextView!
    @IBOutlet var partyCategory: [UIButton]!
    @IBOutlet weak var stateTxt: UITextField!
    @IBOutlet weak var districtTxt: UITextField!
    @IBOutlet weak var areaTxt: UITextField!
    @IBOutlet weak var partyNameTxt: UITextField!
    @IBOutlet weak var partyAddressTxt: UITextField!
    @IBOutlet weak var pincodeTxt: UITextField!
    @IBOutlet weak var partyPhoneTxt: UITextField!
    @IBOutlet weak var partyMobileTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var discountTxt: UITextField!
    @IBOutlet weak var etdTxt: UITextField!
    @IBOutlet weak var viewArea : UIView!
    
    @IBOutlet weak var btnEdit: UIButton!
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
    static var visit_purpose = ""
    var visitDate = ""
    
    var partyId = ""
    var p_caterogy = ""
    
    var partyData = PartyData()
    
    var params : [String:AnyObject] = [:]
    

    
    var selectedButton = 0
    let dropDownMenu = DropDown()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.btnEdit.isHidden = true
        self.btnEdit.addTarget(self, action: #selector(onEdit(_:)), for: .touchUpInside)
        setupUI()
        //stateTxt.delegate = self
        
      
    }
    
    @IBAction func  onEdit( _ sender : UIButton){
        showYesNoAlertWithCompletion(onVC: self, title: "Confrimation", message: "Are you sure you want to edit party name", btnOkTitle: "Yes", btnCancelTitle: "No") {
            let userdef = UserDefaults.standard
            userdef.set(self.partyId, forKey: PARTY_ID)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getStateApi()
    }
    
    func setupUI()
    {
        remarksView.delegate = self
        remarksView.placeholder = Remarks
        remarksView.font = UIFont(name: "Arial", size: 17)
        remarksView.minHeight = 100
        remarksView.maxHeight = 100
        remarksView.tintColor = .black
        
        self.stateTxt.addTarget(self, action: #selector(onStateTextFeild(_:)), for: .editingChanged)
        self.districtTxt.addTarget(self, action: #selector(onDistrictTextFeild(_:)), for: .editingChanged)
        //self.etSchoolName.addTarget(self, action: #selector(onSchoolNameTextFeild(_:)), for: .editingChanged)
        
        self.partyNameTxt.addTarget(self, action: #selector(onPartyNameTextFeild(_:)), for: .editingChanged)
        
        self.stateDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.stateTxt.text = item
            let filtered = self.stateList.filter {
                return $0.name.range(of: item, options: .caseInsensitive) != nil
            }
            self.getDistrictApi(state_id: filtered.first?.id ?? "")
        }
        
        self.districtDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.districtTxt.text = item
            let filtered = self.districtList.filter {
                return $0.name.range(of: item, options: .caseInsensitive) != nil
            }
            self.getDistrictCity(district_id: filtered.first?.id ?? "")
        }
        
        self.cityDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.areaTxt.text = item
            let filtered = self.cityList.filter {
                return $0.name.range(of: item, options: .caseInsensitive) != nil
            }
        }
        
        
        self.partyDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.partyNameTxt.text = item
            let filtered = self.partyList.filter {
                return $0.partyName.range(of: item, options: .caseInsensitive) != nil
            }
            self.partyId = filtered.first?.id ?? ""
            self.setDataOfParty(data: filtered.first ?? PartyData())
            
        }
        
        self.viewArea.isUserInteractionEnabled = true
        self.viewArea.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCitySelect(_:))))
        
        //self.etSamplingMonth.showInputViewDatePicker(target: self, selector: #selector(tapDone))

    }
    
    func setDataOfParty(data:PartyData){
        self.partyData = data
        self.partyAddressTxt.text = data.address
        self.pincodeTxt.text = data.p_pincode
        self.partyPhoneTxt.text = data.partyPhone
        self.partyMobileTxt.text = data.partyM
        self.emailTxt.text = data.partyEmail
        self.discountTxt.text = data.pDiscount
        self.etdTxt.text = data.pEtt
        self.remarksView.text = data.pRemarks
        
        self.btnEdit.isHidden = false
        
        
        PartyViewController.partyID = data.id
        
        
        self.p_caterogy = data.pCategory
        
        if (data.pCategory == "A"){
            partyCategory[0].isSelected = true
            selectedButton = 0
        }else if (data.pCategory == "B"){
            partyCategory[1].isSelected = true
            selectedButton = 1
        }else if (data.pCategory == "C"){
            partyCategory[2].isSelected = true
            selectedButton = 2
        }
        
        
        AddPartyViewController.visit_purpose = data.pVisitPurpose
        
        
        
        
        
    }
    
    func reset(){
        self.btnEdit.isHidden = true
        var data = PartyData()
        self.partyAddressTxt.text = data.address
        self.pincodeTxt.text = data.p_pincode
        self.partyPhoneTxt.text = data.partyPhone
        self.partyMobileTxt.text = data.partyM
        self.emailTxt.text = data.partyEmail
        self.discountTxt.text = data.pDiscount
        self.etdTxt.text = data.pEtt
        self.remarksView.text = data.pRemarks
        
        
        PartyViewController.partyID = data.id
        
        
        self.p_caterogy = data.pCategory
        
        if (data.pCategory == "A"){
            partyCategory[0].isSelected = true
            selectedButton = 0
        }else if (data.pCategory == "B"){
            partyCategory[1].isSelected = true
            selectedButton = 1
        }else if (data.pCategory == "C"){
            partyCategory[2].isSelected = true
            selectedButton = 2
        }else{
            partyCategory[0].isSelected = false
            partyCategory[1].isSelected = false
            partyCategory[2].isSelected = false
        }
        
        
        AddPartyViewController.visit_purpose = data.pVisitPurpose
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
        
        self.stateDropdown.anchorView = self.stateTxt
        self.stateDropdown.dataSource = filtered
        self.stateDropdown.bottomOffset = CGPoint(x: 0, y:(self.stateDropdown.anchorView?.plainView.bounds.height) ?? 40)
        self.stateDropdown.show()
        
    }
    
    @objc func onDistrictTextFeild( _ textFeild : UITextField){
        let filtered = self.districtStrList.filter {
            return $0.range(of: textFeild.text ?? "", options: .caseInsensitive) != nil
        }
        
        self.districtDropdown.anchorView = self.districtTxt
        self.districtDropdown.dataSource = filtered
        self.districtDropdown.bottomOffset = CGPoint(x: 0, y:(self.districtDropdown.anchorView?.plainView.bounds.height) ?? 40)
        self.districtDropdown.show()
        
    }
    
    var partyTimer: Timer?

    @objc func onPartyNameTextFeild( _ textFeild : UITextField){
        if partyTimer != nil {
            partyTimer?.invalidate()
            partyTimer = nil
        }
        
        // reschedule the search: in 1.0 second, call the searchForKeyword method on the new textfield content
        partyTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchForKeywordParty(_:)), userInfo: textFeild.text ?? "", repeats: false)
        
    }
    
    
    @objc func searchForKeywordParty(_ timer: Timer) {
        
        // retrieve the keyword from user info
        let keyword = timer.userInfo as? String ?? ""
        
        print("Searching for keyword \(keyword)")
        if(keyword.isEmpty == true){
            self.reset()
        }else{
            getSearchedParty(party_name: keyword)
        }
    }
   
    @IBAction func partyCategoryClicked(_ sender: UIButton) {
        
        let tag = sender.tag
        partyCategory[selectedButton].isSelected = false
        partyCategory[tag].isSelected = true
        selectedButton = tag
        
        if (tag == 0){
            self.p_caterogy = "A"
        }else if (tag == 1){
            self.p_caterogy = "B"
        }else if (tag == 2){
            self.p_caterogy = "C"
        }
    }
    
    
    
    @IBAction func backBtnClicked(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnAction(_ sender: Any)
    {
        params["p_state"] = self.stateTxt.text as AnyObject
        params["p_district"] = self.districtTxt.text as AnyObject
        params["p_city"] = self.areaTxt.text as AnyObject
        params["party_name"] = self.partyNameTxt.text as AnyObject
        params["address"] = self.partyAddressTxt.text as AnyObject
        params["p_pincode"] = self.pincodeTxt.text as AnyObject
        params["party_phone"] = self.partyPhoneTxt.text as AnyObject
        params["party_m"] = self.partyMobileTxt.text as AnyObject
        params["party_email"] = self.emailTxt.text as AnyObject
        params["p_category"] = self.p_caterogy as AnyObject
        params["p_discount"] = self.discountTxt.text as AnyObject
        params["p_ett"] = self.etdTxt.text as AnyObject
        params["p_remarks"] = self.remarksView.text as AnyObject
        params["visit_date"] = self.visitDate as AnyObject
        
        
        if(self.stateTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter state")
        }else if(self.districtTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter district")
        }else if(self.areaTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please select city")
        }else if(self.partyNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter party name")
        }else if(self.partyAddressTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter party address")
        }else if(self.partyMobileTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter party mobile")
        }else if(self.emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter party email")
        }else if(self.p_caterogy.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter party category")
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.SELECTION_COMMITTEE_PARTY_VC) as! SelectionCommitteePartyViewController
            //vc.receivedString = "false"
            vc.params = params
            vc.concern_person = self.partyData.concernPerson
            vc.concern_name = self.partyData.concernName
            vc.concern_phone = self.partyData.concernM
            vc.noOfVisit = FormViewController.noOfVisit
            navigationController?.pushViewController(vc,animated: true)
        }
        
    }
    
}
extension AddPartyViewController{
    
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
            "state" : self.stateTxt.text as AnyObject,
            "district" : self.districtTxt.text as AnyObject,
            "city" : self.areaTxt.text as AnyObject,
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
                    self.partyDropdown.anchorView = self.partyNameTxt
                    self.partyDropdown.dataSource = self.partyStrList
                    self.partyDropdown.bottomOffset = CGPoint(x: 0, y:(self.partyDropdown.anchorView?.plainView.bounds.height) ?? 40)
                    self.partyDropdown.show()
                }

            }
            else{
                print("getSearchedParty",message)
                self.reset()
                //alertModule(onVC: self, title: Alert, msg: message)
                //SignInViewController.removeSpinner(spinner: vc)
            }
            
        }
        
    }
}

//params.put("seller_id", Constants.createPartFromString(Prefs.getId(PartyOTPActivity.this)));
//        params.put("p_district",Constants.createPartFromString(AddPartyDataActivity.district));
//        params.put("p_city",Constants.createPartFromString(AddPartyDataActivity.city));
//        params.put("p_state",Constants.createPartFromString(AddPartyDataActivity.state));
//        params.put("party_name",Constants.createPartFromString(AddPartyDataActivity.partyName));
//        params.put("address",Constants.createPartFromString(AddPartyDataActivity.addreee));
//        params.put("party_m",Constants.createPartFromString(AddPartyDataActivity.mobile));
//        params.put("party_phone",Constants.createPartFromString(AddPartyDataActivity.phone));
//        params.put("party_email",Constants.createPartFromString(AddPartyDataActivity.email));
//        params.put("p_category",Constants.createPartFromString(AddPartyDataActivity.partyCate));
//        params.put("p_remarks",Constants.createPartFromString(AddPartyDataActivity.remarks));
//        params.put("visit_date",Constants.createPartFromString( PartyFragment.visitDate));
//        params.put("concern_person",Constants.createPartFromString(PartyConsenSelectionActivity.concernPerson));
//        params.put("concern_name",Constants.createPartFromString(PartyConsenSelectionActivity.concernPersonName));
//        params.put("concern_m",Constants.createPartFromString(PartyConsenSelectionActivity.concernPersonMobile));
//        params.put("p_visit_purpose",Constants.createPartFromString(PartyPurposeActivity.purpose));
//        params.put("p_sampling",Constants.createPartFromString(""));
//        params.put("p_sampling_month",Constants.createPartFromString(""));
//        params.put("p_ett",Constants.createPartFromString(AddPartyDataActivity.ETT));
//        params.put("p_discount",Constants.createPartFromString(AddPartyDataActivity.discoint));
//        params.put("p_pincode",Constants.createPartFromString(AddPartyDataActivity.pincode));
//        params.put("p_concern_remarks",Constants.createPartFromString(PartyConsenSelectionActivity.concernRemarks!=null?PartyConsenSelectionActivity.concernRemarks:""));
//        params.put("p_primary_sampling",Constants.createPartFromString(""));
//        params.put("p_group_sampling",Constants.createPartFromString(""));
//        params.put("p_visit_purpose_remarks",Constants.createPartFromString(PartyPurposeActivity.p_visit_purpose_remarks));
//
//
//        params.put("p_payment_mode",Constants.createPartFromString(mode));
//        params.put("p_cheque_no",Constants.createPartFromString(ch_number));
//        params.put("p_payment_price",Constants.createPartFromString(price));
//        params.put("p_not_received_reason",Constants.createPartFromString(""));
//
//        params.put("p_cheque_price",Constants.createPartFromString(cheque_price));
//        params.put("p_otp_email",Constants.createPartFromString(u_email));
//
//        MultipartBody.Part visitToUpload;
//        if (TextUtils.isEmpty(PartyConsenSelectionActivity.concernVistingCard)){
//            RequestBody attachmentEmpty = RequestBody.create("", MediaType.parse("text/plain"));
//            visitToUpload = MultipartBody.Part.createFormData("p_concern_visiting_card", "", attachmentEmpty);
//        } else {
//            File file = new File(PartyConsenSelectionActivity.concernVistingCard);
//            visitToUpload = MultipartBody.Part.createFormData("p_concern_visiting_card", file.getName(), RequestBody.create(file,MediaType.parse("image/*")));
//        }
//        showProgress();
//        //order_images
//        //File file = new File(imguri);
//        RequestBody attachmentEmpty = RequestBody.create("",MediaType.parse("text/plain"));
//        MultipartBody.Part fileToUpload = MultipartBody.Part.createFormData("order_images", "", attachmentEmpty);
//
