
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var schoolView: UIView!
    @IBOutlet weak var partyView: UIView!
    @IBOutlet weak var expensesView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partyView.alpha = 0
        schoolView.alpha = 1
        expensesView.alpha = 0
        segmentControl.setupSegment()
        //        self.navigationController?.setStatusBar(backgroundColor: UIColor(red: 136, green: 0, blue: 155, alpha: 1.0))
//        if #available(iOS 15, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = UIColor(red: 136, green: 0, blue: 155, alpha: 1.0)
//            navigationController?.navigationBar.standardAppearance = appearance
//            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
//        }
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = "Home"
        let reportButton   = UIBarButtonItem(title: "Report",  style: .plain, target: self, action: #selector(didTapReportButton(sender:)))
        let logoutButton = UIBarButtonItem(title: "Logout",  style: .plain, target: self, action: #selector(didTapLogoutButton(sender:)))
        
        navigationItem.rightBarButtonItems = [logoutButton, reportButton]
    }
    
    @objc func didTapReportButton(sender: AnyObject){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
        navigationController?.pushViewController(vc,animated: true)
    }
    
    @objc func didTapLogoutButton(sender: AnyObject){
        showOKCancelAlertWithCompletion(onVC: self, title: "Confirmation", message: "Are you sure you want to continue?", btnOkTitle: "YES", btnCancelTitle: "NO", onOk: {
            
        }, onCancel: {
            
        })
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

