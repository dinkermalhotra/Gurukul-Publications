

import UIKit
import DropDown

class SelectionCommitteeViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
   
    
    @IBOutlet weak var dropDown: UIButton!
    @IBOutlet weak var submitBtnTop: NSLayoutConstraint!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var concernPersonView: UIView!
    @IBOutlet weak var concernPersonLbl: UILabel!
    @IBOutlet weak var remarksView: UIView!
    @IBOutlet weak var remarksTxt: UITextField!
    @IBOutlet weak var remarksLbl: UILabel!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var mobileNoLbl: UILabel!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint! //131
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var viewSubjectTeacher: UIView!
    
    var cameraBtn1: UIButton? = nil
    var remarksTxt1: UITextField? = nil
    var submitBtn1: UIButton? = nil
    
    @IBOutlet weak var STViewHeight: NSLayoutConstraint! //578
    
    var noOfVisit = 0
    
    var receivedString = ""
    let dropDownMenu = DropDown()
    var concern_person = ""
    var concern_name = ""
    var concern_phone = ""
    var concern_remark = ""
    var concernVistingCard : UIImage? = nil
    
    var params : [String:AnyObject] = [:]
    
    struct TextFieldModel {
        var firstTextFieldData: String?
        var secondTextFieldData: String?
        
        init(textData1: String, textData2: String) {
            firstTextFieldData  = textData1
            secondTextFieldData = textData2
        }
    }
    
    var dataModel = [TextFieldModel]()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        submitBtnTop.constant = 50
        self.tableView.isHidden = true
        self.viewSubjectTeacher.isHidden = true
        
        self.dataModel.append(TextFieldModel(textData1: "", textData2: ""))
        self.tableView.register(UINib(nibName: "TeacherTableViewCell", bundle: nil), forCellReuseIdentifier: "TeacherTableViewCell")
        self.tableView.register(UINib(nibName: "FooterTableViewCell", bundle: nil), forCellReuseIdentifier: "FooterTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = addFooterCell()
        
        if(self.concern_person.isEmpty == false){
            self.dropDown.setTitle(self.concern_person, for: .normal)
            self.dropDown.setTitleColor(.black, for: .normal)
            self.nameTxt.isHidden = false
            self.nameLbl.isHidden = false
            self.nameView.isHidden = false
            self.mobileTxt.isHidden = false
            self.mobileView.isHidden = false
            self.mobileNoLbl.isHidden = false
            self.remarksLbl.isHidden = false
            self.remarksTxt.isHidden = false
            self.remarksView.isHidden = false
            self.cameraBtn.isHidden = false
            self.submitBtnTop.constant = 360
        }
        self.nameTxt.text = self.concern_name
        self.mobileTxt.text = self.concern_phone
        self.remarksTxt.text = self.concern_remark
       
        //
        self.tableView.addObserver(self, forKeyPath:"contentSize", options: .new, context: nil)
        self.submitBtn1?.addTarget(self, action: #selector(submitBtnAction1), for: .touchUpInside)
        self.cameraBtn1?.addTarget(self, action: #selector(cameraBtnAction1), for: .touchUpInside)
        
    }
    
    
    func addFooterCell() -> UIView{
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FooterTableViewCell") as! FooterTableViewCell
        cell.cameraBtnF.isHidden = false
        self.cameraBtn1 = cell.cameraBtnF
        self.remarksTxt1 = cell.etRemarks
        self.submitBtn1 = cell.btnSubmit
        
        return cell.contentView
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //if let obj = object as? UITableView {
            if keyPath == "contentSize"  {
                if let newValue = change?[.newKey]{
                    let newSize = newValue as! CGSize
                    self.tableViewHeight.constant = newSize.height
                    self.STViewHeight.constant = newSize.height
                }
            }
        //}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherTableViewCell") as! TeacherTableViewCell
        cell.selectionStyle = .none
        
        if(indexPath.row == 0){
            cell.btnAdd.setTitle("ADD", for: .normal)
        }else{
            cell.btnAdd.setTitle("REMOVE", for: .normal)
        }
            
        cell.lblTchDetail.text = "Teacher Detail \(indexPath.row + 1)"
                   cell.etName.tag = indexPath.row
                   cell.etMobile.tag = indexPath.row
        
                   cell.etName.delegate = self
                   cell.etMobile.delegate = self
        
                   cell.etName.text = dataModel[indexPath.row].firstTextFieldData
                   cell.etMobile.text = dataModel[indexPath.row].secondTextFieldData
        
        cell.onClick = {
            if(cell.btnAdd.currentTitle == "ADD"){
                self.dataModel.append(TextFieldModel(textData1: "", textData2: ""))
                tableView.reloadData()
            }else{
                if(self.dataModel.count > 1){
                    self.dataModel.remove(at: indexPath.row)
                    tableView.reloadData()
                }
            }
        }
        
       
        
        return cell
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            let index = NSIndexPath(row: textField.tag, section: 0)
            if let cell = tableView.cellForRow(at: index as IndexPath)as? TeacherTableViewCell {
                if textField == cell.etName {
                    dataModel[textField.tag].firstTextFieldData = textField.text
                } else if textField == cell.etMobile {
                    dataModel[textField.tag].secondTextFieldData = textField.text
                }
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    @IBAction func backBtnClicked(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dropDownBtnAction(_ sender: Any)
    {
        if receivedString == "true"{
            dropDownMenu.dataSource = ["Coordinator", "Principle", "Director", "Librarian","Vice Principle","Subject Teacher","Others"]
        }else{
            dropDownMenu.dataSource =  ["Owner", "Proprietor", "Business Partner", "Manager"]
        }
        
        dropDownMenu.anchorView = sender as? AnchorView
        dropDownMenu.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height)
        dropDownMenu.show()
        dropDownMenu.backgroundColor = .white
        dropDownMenu.selectionAction = { [weak self] (index: Int, item: String) in
            
            guard let _ = self else { return}
            (sender as AnyObject).setTitle(item, for: .normal)
            self?.concern_person = item
            self?.dropDown.setTitleColor(.black, for: .normal)
            self?.nameTxt.isHidden = false
            self?.nameLbl.isHidden = false
            self?.nameView.isHidden = false
            self?.mobileTxt.isHidden = false
            self?.mobileView.isHidden = false
            self?.mobileNoLbl.isHidden = false
            self?.remarksLbl.isHidden = false
            self?.remarksTxt.isHidden = false
            self?.remarksView.isHidden = false
            self?.cameraBtn.isHidden = false
            self?.submitBtnTop.constant = 360
            if(item == "Subject Teacher"){
                self?.tableView.isHidden = false
                self?.viewSubjectTeacher.isHidden = false
                self?.cameraBtn.isHidden = true
            }else{
                self?.tableView.isHidden = true
                self?.viewSubjectTeacher.isHidden = true
                self?.cameraBtn.isHidden = false
            }
        }
    }
    
    @IBAction func submitBtnAction1(_ sender: UIButton) {
        print(self.dataModel)
        if dropDown.currentTitle == Select_concern{
            alertModule(onVC: self, title: Alert, msg: Select_concern_person)
        }
        else{
            self.concern_name = self.nameTxt.text ?? ""
            //self.concern_phone = self.mobileTxt.text ?? ""
            self.concern_remark = self.remarksTxt1?.text ?? ""
            
            var names = [String]()
            var phones = [String]()
            
            self.dataModel.forEach { data in
                names.append(data.firstTextFieldData ?? "")
                phones.append(data.secondTextFieldData ?? "")
            }
            
            params["concern_person"] = self.concern_person as AnyObject
            params["concern_name"] = "" as AnyObject
            params["concern_m"] = "" as AnyObject
            params["concern_remarks"] = self.concern_remark as AnyObject
            params["teacher_names"]  = toJSONArray(myArray: names) as AnyObject
            params["teacher_mobiles"] = toJSONArray(myArray: phones) as AnyObject
            
            print(params)
            let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.PURPOSE_VISIT_VC) as! PurposeOfVisitViewController
            vc.concernVistingCard = concernVistingCard
            vc.params = params
            vc.noOfVisit = noOfVisit
            navigationController?.pushViewController(vc,animated: true)
        }
        
    }
    
    func toJSONArray(myArray:[String]) -> String{
        do {
            // Convert array to JSON data
            let data = try JSONSerialization.data(
                withJSONObject: myArray,
                options: []
            )

            // Convert JSON data to JSON string
            let jsonString: String? = String(data: data, encoding: .utf8)

            // Print JSON string
            return jsonString ?? "[]"
            print(jsonString ?? "JSON string is nil")
        } catch {
            // Handle error
            return "[]"
            print(error.localizedDescription)
        }
    }
    
    
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        print(self.dataModel)
        if dropDown.currentTitle == Select_concern{
            alertModule(onVC: self, title: Alert, msg: Select_concern_person)
        }
        else if (nameTxt.text?.isEmpty ?? true)
        {
            
            alertModule(onVC: self, title: Alert, msg: Concern_person_name)
        }
        else if (mobileTxt.text?.isEmpty ?? true)
        {
            
            alertModule(onVC: self, title: Alert, msg: Concern_person_no)
        }
        else{
            self.concern_name = self.nameTxt.text ?? ""
            self.concern_phone = self.mobileTxt.text ?? ""
            self.concern_remark = self.remarksTxt.text ?? ""
            
            params["concern_person"] = self.concern_person as AnyObject
            params["concern_name"] = self.concern_name as AnyObject
            params["concern_m"] = self.concern_person as AnyObject
            params["concern_remarks"] = self.concern_remark as AnyObject
            params["teacher_names"]  = "" as AnyObject
            params["teacher_mobiles"] = "" as AnyObject
            
            print(params)
            let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.PURPOSE_VISIT_VC) as! PurposeOfVisitViewController
            vc.concernVistingCard = concernVistingCard
            vc.params = params
            vc.noOfVisit = noOfVisit
            navigationController?.pushViewController(vc,animated: true)
        }
        
    }
    
    @IBAction func cameraBtnAction(_ sender: Any) {
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
    
    @IBAction func cameraBtnAction1(_ sender: Any) {
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
            self.concernVistingCard = pickedImage
            self.cameraBtn.setImage(pickedImage, for: .normal)
            self.cameraBtn1?.setImage(pickedImage, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


