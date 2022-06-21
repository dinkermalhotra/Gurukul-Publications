
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
    override func viewDidLoad() {
        super.viewDidLoad()
        dispalyRemarksViewData()
        self.navigationItem.title = "Form"
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        samplingMonthTop.constant = 16
    }
    //MARK: Display Text View Data
    func dispalyRemarksViewData(){
        remarksView.delegate = self
        remarksView.placeholder = "Remarks"
        remarksView.font = UIFont(name: "Arial", size: 17)
        remarksView.minHeight = 100
        remarksView.maxHeight = 100
        remarksView.tintColor = .black
    }

    @IBAction func directBtnAction(_ sender: Any) {
        partyView.isHidden = true
        partyTxt.isHidden = true
        partyLbl.isHidden = true
        samplingMonthTop.constant = 16
        directBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
        throughPartyBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
    }
    
    @IBAction func throughPartyBtnAction(_ sender: Any) {
        partyView.isHidden = false
        partyTxt.isHidden = false
        partyLbl.isHidden = false
        samplingMonthTop.constant = 84.5
        throughPartyBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
        directBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)

    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectionCommitteeViewController") as! SelectionCommitteeViewController
        vc.receivedString = "true"
        navigationController?.pushViewController(vc,animated: true)
    }
}
