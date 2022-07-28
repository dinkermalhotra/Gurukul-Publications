

import UIKit

class PurposeOfVisitViewController: UIViewController {
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var remarksView: UIView!
    @IBOutlet weak var remarksTxt: UITextField!
    @IBOutlet weak var remarksLbl: UILabel!
    @IBOutlet weak var submitBtnTop: NSLayoutConstraint!
    @IBOutlet var checkBoxArray: [UIButton]!
    
    var saveDefaultValue = ""
    var selectedButton = 0
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //submitBtnTop.constant = 30
        
    }
    
    @IBAction func backBtnClicked(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- <------------- Button Action --------------->
    @IBAction func checkBoxArrayAction(_ sender: UIButton) {

        for i in 0...6
        {
            let button  = sender as UIButton
           
            let btn = button.viewWithTag(i) as? UIButton
            
            if btn?.tag == i
            {
                btn?.isSelected = true
                checkBoxArray[selectedButton].isSelected = false
                checkBoxArray[i].isSelected = true
                selectedButton = i
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
    
    @IBAction func submitBtnAction(_ sender: UIButton)
    {
        
        if saveDefaultValue == "0"
        {
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
                alertModule(onVC: self, title: Alert, msg: Enter_remarks)
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
    
    func showRemarksView()
    {
        
        remarksView.isHidden = false
        remarksLbl.isHidden = false
        remarksTxt.isHidden = false
        submitBtnTop.constant = 120
    }
    
    func showConfirmationMsg()
    {
        
        showOKCancelAlertWithCompletion(onVC: self, title: Confirmation, message: Alert_msg, btnOkTitle: YES, btnCancelTitle: NO, onOk: {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.ADD_PARTY_VC) as! AddPartyViewController
            self.navigationController?.pushViewController(vc,animated: true)
        }, onCancel: {
            
            self.navigationController?.popToViewController(ofClass: HomeViewController.self)
        })
    }
    
    func pushToOrderVC()
    {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.ORDER_VC) as! OrderViewController
        self.navigationController?.pushViewController(vc,animated: true)
    }
    func pushToSampleListVc()
    {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.SAMPLE_LIST_VC) as! SampleListViewController
        self.navigationController?.pushViewController(vc,animated: true)
        
    }
    func pushToPaymentVC()
    {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.PAYMENT_VC) as! PaymentViewController
        self.navigationController?.pushViewController(vc,animated: true)
    }
    
}
