
import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet var checkBoxArray: [UIButton]!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var amountTxt: UITextField!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var chequeNumberView: UIView!
    @IBOutlet weak var checkAmountView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var mobileNoView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var resonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI()
    {
        checkAmountView.isHidden = true
        chequeNumberView.isHidden = true
        resonView.isHidden = true
    }
    
    @IBAction func backBtnClicked(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkBoxesAction(_ sender: UIButton)
    {
        let button  = sender as UIButton
        
        for i in 0...4
        {
            let btn = button.viewWithTag(i) as? UIButton
            
            if btn?.tag == i
            {
                btn?.isSelected = true
                if btn?.tag == 0{
                    
                    checkAmountView.isHidden = true
                    chequeNumberView.isHidden = true
                    resonView.isHidden = true
                    nameView.isHidden = false
                    mobileNoView.isHidden = false
                    emailView.isHidden = false
                    amountView.isHidden = false
                }
                else  if btn?.tag == 1{
                    
                    chequeNumberView.isHidden = false
                    nameView.isHidden = false
                    mobileNoView.isHidden = false
                    emailView.isHidden = false
                    amountView.isHidden = false
                    checkAmountView.isHidden = true
                    resonView.isHidden = true
                    
                }
                else  if btn?.tag == 2{
                    
                    chequeNumberView.isHidden = false
                    checkAmountView.isHidden = false
                    nameView.isHidden = false
                    mobileNoView.isHidden = false
                    emailView.isHidden = false
                    amountView.isHidden = false
                    resonView.isHidden = true
                    
                }
                else  if btn?.tag == 3{
                    chequeNumberView.isHidden = true
                    checkAmountView.isHidden = true
                    resonView.isHidden = true
                    nameView.isHidden = false
                    mobileNoView.isHidden = false
                    emailView.isHidden = false
                    amountView.isHidden = false
                }
                else  if btn?.tag == 4{
                    
                    chequeNumberView.isHidden = true
                    checkAmountView.isHidden = true
                    nameView.isHidden = true
                    mobileNoView.isHidden = true
                    emailView.isHidden = true
                    amountView.isHidden = true
                    resonView.isHidden = false
                    
                }
            }
            else
            {
                btn?.isSelected = false
            }
        }
    }
    
    
    @IBAction func submitBtnAction(_ sender: Any)
    {
        pushToOtpVC()
    }
    
    func pushToOtpVC()
    {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.OTP_VC) as! OTPViewController
        navigationController?.pushViewController(vc,animated: true)
    }
}
