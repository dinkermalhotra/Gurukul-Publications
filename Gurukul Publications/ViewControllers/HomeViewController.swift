
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var schoolView: UIView!
    @IBOutlet weak var partyView: UIView!
    @IBOutlet weak var expensesView: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userdef = UserDefaults.standard
        let name = userdef.string(forKey: full_Name)
        if name != nil{
            self.lblName.text = name
        }else{
            self.lblName.text = ""
        }
        setupUI()
    }
    
    
    func setupUI()
    {
        partyView.alpha = 0
        schoolView.alpha = 1
        expensesView.alpha = 0
        segmentControl.setupSegment()
        self.navigationItem.setHidesBackButton(true, animated: true)

        
    }
   
    @IBAction func reportBtnClicked(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.REPORT_VIEW_VC) as! ReportViewController
        navigationController?.pushViewController(vc,animated: true)
        
    }
    
    @IBAction func LogoutBtnClicked(_ sender: UIBarButtonItem) {
        showOKCancelAlertWithCompletion(onVC: self, title: Confirmation, message: Alert_msg, btnOkTitle: YES, btnCancelTitle: NO, onOk: {
            self.logOut()
        }, onCancel: {
            
        })
        
    }
    func logOut(){
       
        UserDefaults.standard.removeObject(forKey: user_Id)
        UserDefaults.standard.removeObject(forKey: LOGGIN_ID)
        UserDefaults.standard.removeObject(forKey: SCHOOL_ID)
        UserDefaults.standard.removeObject(forKey: PARTY_ID)
        UserDefaults.standard.removeObject(forKey: full_Name)
        resetDefaults()
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.SIGNIN_VC) as! SignInViewController
        let navigationController = UINavigationController(rootViewController: loginViewController)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
    
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
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

