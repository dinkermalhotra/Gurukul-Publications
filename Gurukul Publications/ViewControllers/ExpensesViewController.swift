
import UIKit

class ExpensesViewController: UIViewController {
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var localBtn: UIButton!
    @IBOutlet weak var outStationBtn: UIButton!
    @IBOutlet var checkBoxArray: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dateField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        
    }
    @objc func tapDone() {
        if let datePicker = self.dateField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "dd/MM/yyyy"
            self.dateField.text = dateformatter.string(from: datePicker.date)
        }
        self.dateField.resignFirstResponder()
    }
    
    @IBAction func outStationBtnAction(_ sender: UIButton) {
        //        self.outStationBtn.isSelected = !self.outStationBtn.isSelected
        if outStationBtn.currentImage == UIImage(named: "uncheckbox.png") {
            self.outStationBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            self.localBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
        }
        else {
            self.outStationBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            self.localBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
        }
    }
    
    @IBAction func localBtnAction(_ sender: UIButton) {
        if localBtn.currentImage == UIImage(named: "uncheckbox.png") {
            self.localBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            self.outStationBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
        }
        else {
            self.localBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
        }
    }
    
    @IBAction func checkBoxArrayAction(_ sender: UIButton) {
        
    }
}
