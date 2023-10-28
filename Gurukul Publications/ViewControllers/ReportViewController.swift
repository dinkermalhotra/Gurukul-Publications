

import UIKit

class ReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var datePicker :UIDatePicker!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblNoData: UILabel!
    
    
    
    var schoolList = [SearchSchoolData]()
    var partyList = [PartyData]()
    var dataType = "school"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblNoData.isHidden = true
        self.tableView.isHidden = true
        segmentControl.setupSegment()
        self.dateField.showInputViewDatePicker(target: self, selector: #selector(tapDone))
        self.tableView.register(UINib(nibName: "SchoolTableViewCell", bundle: nil), forCellReuseIdentifier: "SchoolTableViewCell")
        self.tableView.register(UINib(nibName: "PartyTableViewCell", bundle: nil), forCellReuseIdentifier: "PartyTableViewCell")
        //self.tableView.estimatedRowHeight = 394
        //self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataType == "school" ? self.schoolList.count : self.partyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (self.dataType == "school"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolTableViewCell") as! SchoolTableViewCell
            cell.selectionStyle = .none
            let data = self.schoolList[indexPath.row]
            
            cell.lblvisiNo.text = "\(indexPath.row+1)"
            cell.lblschoolName.text = data.schoolName
            cell.lblAddress.text = data.address
            cell.lblDistrict.text = data.district
            cell.lblCity.text = data.city
            cell.lblSchM.text = data.schMobile
            cell.lblSchStg.text = data.schStg
            cell.lblSchUpto.text = data.schUpto
            cell.lblBranches.text = data.sch_branches
            cell.lblPurpose.text = data.visitPurpose
            cell.lblRemarks.text = data.remarks
            cell.lblConcernPerson.text = data.concernPerson
            
            return cell
        }else if (self.dataType == "party"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "PartyTableViewCell") as! PartyTableViewCell
            cell.selectionStyle = .none
            let data = self.partyList[indexPath.row]
            
            cell.lblpartyName.text = data.partyName
            cell.lblAddress.text = data.address
            cell.lblDistrict.text = data.pDistrict
            cell.lblCity.text = data.pCity
            cell.lblPMob.text = data.partyM
            cell.lblPEmail.text = data.partyEmail
            cell.lblPCategory.text = data.pCategory
            cell.lblPurpose.text = data.pVisitPurpose
            cell.lblRemarks.text = data.pRemarks
            cell.lblConcernPerson.text = data.concernPerson
            cell.lblConcernPersonName.text = data.concernName
            cell.lblConcernPersonMobile.text = data.concernM
            
            return cell
        }else{
            return UITableViewCell()
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.dataType == "school"){
            return 388
        }else{
            return 419
        }
    }
    
    
    @objc func tapDone() {
        if let datePicker = self.dateField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "dd-MM-yyyy"
            self.dateField.text = dateformatter.string(from: datePicker.date)
        }
        self.dateField.resignFirstResponder()
        if self.dataType == "school"{
            self.partyList.removeAll()
            self.schoolList.removeAll()
            self.tableView.reloadData()
            self.reportingSellerByDate(date: self.dateField.text ?? "")
        }else if self.dataType == "party" {
            self.dataType = "party"
            self.partyList.removeAll()
            self.schoolList.removeAll()
            self.tableView.reloadData()
            self.getPartyreportingSellerByDate(date: self.dateField.text ?? "")
        }else{
            self.partyList.removeAll()
            self.schoolList.removeAll()
            self.tableView.reloadData()
        }
    }
    
    @IBAction func backBtnClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        segmentControl.changeUnderlinePosition()
        if sender.selectedSegmentIndex == 0 {
            self.dataType = "school"
            self.partyList.removeAll()
            self.schoolList.removeAll()
            self.tableView.reloadData()
            self.reportingSellerByDate(date: self.dateField.text ?? "")
        }else if sender.selectedSegmentIndex == 1 {
            self.dataType = "party"
            self.partyList.removeAll()
            self.schoolList.removeAll()
            self.tableView.reloadData()
            self.getPartyreportingSellerByDate(date: self.dateField.text ?? "")
        }else{
            self.partyList.removeAll()
            self.schoolList.removeAll()
            self.tableView.reloadData()
        }
        
    }
    
}

extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        datePicker.maximumDate =  Date()
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: Cancel, style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: Done, style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    func showInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        //datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        //datePicker.maximumDate =  Date()
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: Cancel, style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: Done, style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}
extension ReportViewController{
    
    func reportingSellerByDate(date:String){
        displaySpinner()
        
        self.schoolList.removeAll()
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        let params = ["visit_date":date as AnyObject,
                      "seller_id":user_id as AnyObject]
        WebServices.getReportingSellerByDate(params) { isSuccess, message, schoolData, userStatus in
            removeSpinner()
            if(userStatus){
                self.lblNoData.isHidden = true
                self.tableView.isHidden = false
                
                self.schoolList = schoolData ?? []
                self.tableView.reloadData()
            }else{
                self.lblNoData.isHidden = false
                self.tableView.isHidden = true
            }
        }
    }
    
    func getPartyreportingSellerByDate(date:String){
        displaySpinner()
        
        self.partyList.removeAll()
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        let params = ["visit_date":date as AnyObject,
                      "seller_id":user_id as AnyObject]
        WebServices.getPartyReportingSellerByDate(params) { isSuccess, message, partyData, userStatus in
            removeSpinner()
            if(userStatus){
                self.lblNoData.isHidden = true
                self.tableView.isHidden = false
                
                self.partyList = partyData ?? []
                self.tableView.reloadData()
            }else{
                self.lblNoData.isHidden = false
                self.tableView.isHidden = true
            }
        }
    }
}
extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}
