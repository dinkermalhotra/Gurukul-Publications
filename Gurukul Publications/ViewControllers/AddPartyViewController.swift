
import UIKit
import GrowingTextView
import DropDown
class AddPartyViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate {

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
    
    var selectedButton = 0
    let dropDownMenu = DropDown()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        stateTxt.delegate = self
        
      
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

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        dropDownMenu.dataSource = ["Coordinator", "Principle", "Director", "Librarian","Vice Principle","Subject Teacher","Others"]
        dropDownMenu.anchorView = stateTxt
        dropDownMenu.bottomOffset = CGPoint(x: 0, y: (stateTxt as AnyObject).frame.size.height)
        dropDownMenu.show()
        dropDownMenu.backgroundColor = .white
        dropDownMenu.selectionAction = { [weak self] (index: Int, item: String) in
            
            guard let _ = self else { return}
            self!.stateTxt.text = item
        
    }
        return true
    }
    
}
