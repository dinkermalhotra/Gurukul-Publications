

import UIKit

class OTPViewController: UIViewController {
    @IBOutlet weak var otpText: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var resendBtn: UIButton!
    
    var count = 60
    var resendTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Purpose of visit"
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            startTimer()
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func resendOtpAction(_ sender: UIButton) {

        startTimer()
        
    }
    
    func startTimer() {
        resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    @objc func update() {
        if(count > 0) {
            count = count - 1
            print(count)
            
            resendBtn.setTitle("Resend OTP in \(count)", for: .normal)
        }
        else {
            resendTimer.invalidate()
            print("call your api")
            resendBtn.setTitle("Resend OTP", for: .normal)
            
        }
    }
}
