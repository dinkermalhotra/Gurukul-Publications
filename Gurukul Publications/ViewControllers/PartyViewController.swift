

import UIKit

class PartyViewController: UIViewController {
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        
    }
    @objc func tapDone()
    {
        if let datePicker = self.dateField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = Date_formatter
            self.dateField.text = dateformatter.string(from: datePicker.date)
        }
        self.dateField.resignFirstResponder()
    }
    
    @IBAction func nextBtnAction(_ sender: Any)
    {
        if (dateField.text?.isEmpty)!
        {
            alertModule(onVC: self, title: Alert, msg: Select_date)
        }
        else if (textField.text?.isEmpty)!
        {
            alertModule(onVC: self, title: Alert, msg: Number_of_party)
        }
        else
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.ADD_PARTY_VC) as! AddPartyViewController
            navigationController?.pushViewController(vc,animated: true)
        }
    }
    
}
