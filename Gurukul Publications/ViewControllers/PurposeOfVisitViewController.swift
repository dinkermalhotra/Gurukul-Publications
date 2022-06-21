

import UIKit

class PurposeOfVisitViewController: UIViewController {
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var remarksView: UIView!
    @IBOutlet weak var remarksTxt: UITextField!
    @IBOutlet weak var remarksLbl: UILabel!
    @IBOutlet weak var submitBtnTop: NSLayoutConstraint!
    @IBOutlet var checkBoxArray: [UIButton]!
    
    var saveDefaultValue = ""
    //MARK:- <------------- viewDidLoad --------------->
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtnTop.constant = 30
        self.navigationItem.title = "Purpose of visit"
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
       
    }
    
    //MARK:- <------------- Button Action --------------->
    @IBAction func checkBoxArrayAction(_ sender: UIButton) {
        
        let button  = sender as UIButton
        
        for i in 0...6
        {
            let btn = button.viewWithTag(i) as? UIButton
            
            if btn?.tag == i
            {
                btn?.isSelected = true
                if btn?.tag == 0
                {
                    showRemarksView()
                    saveDefaultValue = "0"
                }
                else if btn?.tag == 1
                {
                    showRemarksView()
                    saveDefaultValue = "1"
                    ///showAlertMsg()
                }
                else if btn?.tag == 2
                {
                    showRemarksView()
                    saveDefaultValue = "2"
                    
                }
                else if btn?.tag == 3
                {
                    showRemarksView()
                    saveDefaultValue = "3"
                }
                else if btn?.tag == 4
                {
                    showRemarksView()
                    saveDefaultValue = "4"
                    
                }
                else if btn?.tag == 5
                {
                    showRemarksView()
                    saveDefaultValue = "5"
                }
                else if btn?.tag == 6
                {
                    showRemarksView()
                    saveDefaultValue = "6"
                }
                
            }
            else
            {
                btn?.isSelected = false
            }
            
        }
        
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        if saveDefaultValue == "0"{
            pushToSampleListVc()
        }
        else if saveDefaultValue == "1"
        {
            showConfirmationMsg()
        }
        else if saveDefaultValue == "2"
        {
            pushToOrderVC()
        }
        else if saveDefaultValue == "3"
        {
            if remarksTxt.text == ""{
                alertModule(onVC: self, title: "Alert", msg: "Please enter remarks")
            }else{
                showConfirmationMsg()
            }
        }
        else if saveDefaultValue == "4"
        {
            pushToPaymentVC()
        }
        else if saveDefaultValue == "5"
        {
            showConfirmationMsg()
        }
        else if saveDefaultValue == "6"
        {
            showConfirmationMsg()
        }
        else
        {
            
            
        }
        
    }
    
    func showRemarksView(){
        remarksView.isHidden = false
        remarksLbl.isHidden = false
        remarksTxt.isHidden = false
        submitBtnTop.constant = 120
    }
    
    func showConfirmationMsg(){
        showOKCancelAlertWithCompletion(onVC: self, title: "Confirmation", message: "Are you sure you want to continue?", btnOkTitle: "YES", btnCancelTitle: "NO", onOk: {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddPartyViewController") as! AddPartyViewController
            self.navigationController?.pushViewController(vc,animated: true)
        }, onCancel: {
            
            self.navigationController?.popToViewController(ofClass: HomeViewController.self)
        })
    }
    
    func pushToOrderVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        self.navigationController?.pushViewController(vc,animated: true)
    }
    func pushToSampleListVc(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SampleListViewController") as! SampleListViewController
        self.navigationController?.pushViewController(vc,animated: true)
        
    }
    func pushToPaymentVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        self.navigationController?.pushViewController(vc,animated: true)
    }
    
}
