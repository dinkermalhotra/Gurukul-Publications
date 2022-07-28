
import UIKit

class ExpensesViewController: UIViewController {
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var localBtn: UIButton!
    @IBOutlet weak var outStationBtn: UIButton!
    @IBOutlet var checkBoxArray: [UIButton]!
    @IBOutlet weak var submitBtn: UIButton!
    
    var selectedButton = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dateField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }
    
    @objc func tapDone() {
        if let datePicker = self.dateField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = Date_formatterSlash
            self.dateField.text = dateformatter.string(from: datePicker.date)
        }
        self.dateField.resignFirstResponder()
    }
    
    @IBAction func outStationBtnAction(_ sender: UIButton)
    {
        if outStationBtn.currentImage == UIImage(named: "uncheckbox.png") {
            self.outStationBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            self.localBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
            
        }
        else
        {
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
        
        let tag = sender.tag
        checkBoxArray[selectedButton].isSelected = false
        checkBoxArray[tag].isSelected = true
        selectedButton = tag
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton)
    
    {
    
        
    }
}
