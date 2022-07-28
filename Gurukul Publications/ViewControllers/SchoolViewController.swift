
import UIKit

class SchoolViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        
    }
    @objc func tapDone() {
        if let datePicker = self.dateField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "dd-MM-yyyy"
            self.dateField.text = dateformatter.string(from: datePicker.date)
        }
        self.dateField.resignFirstResponder()
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        if (dateField.text?.isEmpty)!
        {
            alertModule(onVC: self, title: Alert, msg: Select_date)
        }
        else if (textField.text?.isEmpty)!
        {
            alertModule(onVC: self, title: Alert, msg: Number_of_school)
        }
        else
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.FORM_VC) as! FormViewController
            navigationController?.pushViewController(vc,animated: true)
        }
        
    }
}
