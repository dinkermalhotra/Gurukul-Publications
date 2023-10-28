

import UIKit

class PartyViewController: UIViewController {
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    var noOfVisit = 0
    var visitDate = ""
    static var partyID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if(AddPartyViewController.noOfVisit != 0){
            self.textField.text = AddPartyViewController.noOfVisit.string
        }else{
            self.textField.text = ""
        }
    }
    
    
    @objc func tapDone()
    {
        if let datePicker = self.dateField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = Date_formatter
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
           alertModule(onVC: self, title: Alert, msg: Number_of_party)
       }
        else if (Int(textField.text ?? "0") == 0){
            alertModule(onVC: self, title: Alert, msg: "no. of party must greater than 0")
        }
        else if (dateField.text?.isEmpty)!
        {
            alertModule(onVC: self, title: Alert, msg: Select_date)
        }
        
        else
        {
            self.noOfVisit = Int(textField.text ?? "0") ?? 0
            let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.ADD_PARTY_VC) as! AddPartyViewController
            vc.visitDate = self.visitDate
            AddPartyViewController.noOfVisit = self.noOfVisit
            navigationController?.pushViewController(vc,animated: true)
        }
    }
    
}
