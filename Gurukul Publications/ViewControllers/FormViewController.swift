
import UIKit
import GrowingTextView

class FormViewController: UIViewController,UITextViewDelegate {
    
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
    
    var selectedButton = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUi()
        samplingMonthTop.constant = 16
    }
    
    func setupUi()
    {
        remarksView.delegate = self
        remarksView.placeholder = Remarks
        remarksView.font = UIFont(name: "Arial", size: 17)
        remarksView.minHeight = 100
        remarksView.maxHeight = 100
        remarksView.tintColor = .black
    }
    
    @IBAction func boardBtnArrayClicked(_ sender: UIButton) {
        
        let tag = sender.tag
        boardBtnArray[selectedButton].isSelected = false
        boardBtnArray[tag].isSelected = true
        selectedButton = tag
    }
    
    @IBAction func categoryBtnCLicked(_ sender: UIButton) {
        
        let tag = sender.tag
        categoryArray[selectedButton].isSelected = false
        categoryArray[tag].isSelected = true
        selectedButton = tag
        
    }
   
    
    @IBAction func directBtnAction(_ sender: Any)
    {
        partyView.isHidden = true
        partyTxt.isHidden = true
        partyLbl.isHidden = true
        samplingMonthTop.constant = 16
        directBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
        throughPartyBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
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
        
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.SELECTION_COMMITTEE_VC) as! SelectionCommitteeViewController
        vc.receivedString = "true"
        navigationController?.pushViewController(vc,animated: true)
    }
}
