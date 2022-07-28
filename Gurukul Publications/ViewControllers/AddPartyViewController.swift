
import UIKit
import GrowingTextView
class AddPartyViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var remarksView: GrowingTextView!
    @IBOutlet var partyCategory: [UIButton]!
    
    var selectedButton = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
      
    }
    
    func setupUI()
    {
        remarksView.delegate = self
        remarksView.placeholder = Remarks
        remarksView.font = UIFont(name: "Arial", size: 17)
        remarksView.minHeight = 100
        remarksView.maxHeight = 100
        remarksView.tintColor = .black
    }
   
    @IBAction func partyCategoryClicked(_ sender: UIButton) {
        
        let tag = sender.tag
        partyCategory[selectedButton].isSelected = false
        partyCategory[tag].isSelected = true
        selectedButton = tag
    }
    
    
    
    @IBAction func backBtnClicked(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnAction(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.SELECTION_COMMITTEE_VC) as! SelectionCommitteeViewController
        vc.receivedString = "false"
        navigationController?.pushViewController(vc,animated: true)
        
    }
    
}
