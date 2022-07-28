
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var schoolView: UIView!
    @IBOutlet weak var partyView: UIView!
    @IBOutlet weak var expensesView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    func setupUI(){
        partyView.alpha = 0
        schoolView.alpha = 1
        expensesView.alpha = 0
        segmentControl.setupSegment()
      
    }
   
    @IBAction func reportBtnClicked(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.REPORT_VIEW_VC) as! ReportViewController
        navigationController?.pushViewController(vc,animated: true)
        
    }
    
    @IBAction func LogoutBtnClicked(_ sender: UIBarButtonItem) {
        showOKCancelAlertWithCompletion(onVC: self, title: Confirmation, message: Alert_msg, btnOkTitle: YES, btnCancelTitle: NO, onOk: {
            
        }, onCancel: {
            
        })
        
    }
    
    @IBAction func backBtnClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            partyView.alpha = 0
            schoolView.alpha = 1
            expensesView.alpha = 0
            segmentControl.changeUnderlinePosition()
        }
        else if sender.selectedSegmentIndex == 1
        {
            partyView.alpha = 1
            schoolView.alpha = 0
            expensesView.alpha = 0
            segmentControl.changeUnderlinePosition()
        }
        else
        {
            partyView.alpha = 0
            schoolView.alpha = 0
            expensesView.alpha = 1
            segmentControl.changeUnderlinePosition()
        }
    }
    
}

