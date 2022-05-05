

import UIKit

class PurposeOfVisitViewController: UIViewController {
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var remarksView: UIView!
    @IBOutlet weak var remarksTxt: UITextField!
    @IBOutlet weak var remarksLbl: UILabel!
    @IBOutlet weak var submitBtnTop: NSLayoutConstraint!
    @IBOutlet var checkBoxArray: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtnTop.constant = 30
        self.navigationItem.title = "Purpose of visit"
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        showOKCancelAlertWithCompletion(onVC: self, title: "Confirmation", message: "Are you sure you want to continue?", btnOkTitle: "YES", btnCancelTitle: "NO", onOk: {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddPartyViewController") as! AddPartyViewController
            self.navigationController?.pushViewController(vc,animated: true)
        })
    }
    
    
    @IBAction func checkBoxArrayAction(_ sender: Any) {
        remarksView.isHidden = false
        remarksLbl.isHidden = false
        remarksTxt.isHidden = false
        submitBtnTop.constant = 120
    }
    
}
