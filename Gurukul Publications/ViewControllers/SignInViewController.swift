import UIKit
import Alamofire

class SignInViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInBTn: UIButton!
    
    var loginData = [Login]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK:- <-------------SIGN IN BUTTON ACTION --------------------->
    @IBAction func signInBtnAction(_ sender: UIButton)
    {
        if (userName.text?.isEmpty)!
        {
            alertModule(onVC: self, title: Alert, msg: user_name)
        }
        else if (password.text?.isEmpty)!
        {
            alertModule(onVC: self, title: Alert, msg: user_pswd)
        }
        else
        {
            loginApi()
            
        }
    }
    
    func loginApi(){
        let vc = SignInViewController.displaySpinner(onView: self.view)
        
        let params: [String: AnyObject] = ["email" : userName.text as AnyObject,
                                       "password" : password.text as AnyObject]
        
        WebServices.wsCallLoginApi(params) { isSuccess, message, login, userStatus in
            
            if isSuccess {
                self.loginData = login ?? []
                print(self.loginData)
                let userId = self.loginData[0].id
                let userdef = UserDefaults.standard
                userdef.set(userId, forKey: user_Id)
               
                self.pushToHomeVC()
                SignInViewController.removeSpinner(spinner: vc)
                
            }
            else{
                alertModule(onVC: self, title: Alert, msg: message)
                SignInViewController.removeSpinner(spinner: vc)
            }
            
        }
        
    }
    
    func pushToHomeVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.HOME_VC) as! HomeViewController
        self.navigationController?.pushViewController(vc,animated: true)
    }
}
