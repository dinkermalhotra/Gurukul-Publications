

import UIKit

class OTPViewController: UIViewController {
    @IBOutlet weak var otpText: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var resendBtn: UIButton!
    
    var count = 60
    var resendTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
    }
    
    @IBAction func backBtnClicked(_ sender: UIBarButtonItem)
    {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnAction(_ sender: Any)
    {
        
    }
    
    @IBAction func resendOtpAction(_ sender: UIButton)
    {
        
        startTimer()
        
    }
    
    func startTimer()
    {
        resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update()
    {
        if(count > 0)
        {
            count = count - 1
            print(count)
            
            resendBtn.setTitle("Resend OTP in \(count)", for: .normal)
        }
        else
        {
            resendTimer.invalidate()
            print("call your api")
            resendBtn.setTitle(Resend_otp, for: .normal)
            
        }
    }
}
