
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
    var selectedButton = 0
    var selectedReturnButtons = 0
    
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
        
        let tag = sender.tag
        checkBoxArray[selectedButton].isSelected = false
        checkBoxArray[tag].isSelected = true
        selectedButton = tag
        
        if selectedButton == 0
        {

            checkAmountView.isHidden = true
            chequeNumberView.isHidden = true
            resonView.isHidden = true
            nameView.isHidden = false
            mobileNoView.isHidden = false
            emailView.isHidden = false
            amountView.isHidden = false
        }
        else if selectedButton == 1
        {
            chequeNumberView.isHidden = false
            nameView.isHidden = false
            mobileNoView.isHidden = false
            emailView.isHidden = false
            amountView.isHidden = false
            checkAmountView.isHidden = true
            resonView.isHidden = true

        }
        else if selectedButton == 2
        {

            chequeNumberView.isHidden = false
            checkAmountView.isHidden = false
            nameView.isHidden = false
            mobileNoView.isHidden = false
            emailView.isHidden = false
            amountView.isHidden = false
            resonView.isHidden = true

        }
        else if selectedButton == 3
        {
            chequeNumberView.isHidden = true
            checkAmountView.isHidden = true
            resonView.isHidden = true
            nameView.isHidden = false
            mobileNoView.isHidden = false
            emailView.isHidden = false
            amountView.isHidden = false
        }
        else if selectedButton == 4
        {

            chequeNumberView.isHidden = true
            checkAmountView.isHidden = true
            nameView.isHidden = true
            mobileNoView.isHidden = true
            emailView.isHidden = true
            amountView.isHidden = true
            resonView.isHidden = false

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
