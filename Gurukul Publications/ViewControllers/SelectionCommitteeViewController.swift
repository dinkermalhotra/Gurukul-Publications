

import UIKit
import DropDown

class SelectionCommitteeViewController: UIViewController{
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
    
    let dropDownMenu = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtnTop.constant = 50
        
        self.navigationItem.title = "Selection Committee"
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    @IBAction func dropDownBtnAction(_ sender: Any) {
        dropDownMenu.dataSource = ["Owner", "Proprietor", "Business Partner", "Manager"]
        dropDownMenu.anchorView = sender as? AnchorView
        dropDownMenu.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height)
        dropDownMenu.show()
        dropDownMenu.selectionAction = { [weak self] (index: Int, item: String) in
            
            guard let _ = self else { return}
            (sender as AnyObject).setTitle(item, for: .normal)
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
            self?.submitBtnTop.constant = 355
        }
    }
    
    
    @IBAction func submitBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PurposeOfVisitViewController") as! PurposeOfVisitViewController
        navigationController?.pushViewController(vc,animated: true)
    }
    
}
