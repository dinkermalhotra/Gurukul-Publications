

import UIKit
import ToastViewSwift

class OTPViewController: UIViewController {
    @IBOutlet weak var otpText: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var resendBtn: UIButton!
    
    var count = 60
    var resendTimer = Timer()
    
    var params : [String:AnyObject] = [:]
    var noOfVisit = 0
    var concernVistingCard : UIImage? = nil
    
    var nameSchoolParty = ""
    var phone = ""
    var email = ""
    var otp = ""
    
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
        print(self.otp)
        if(otpText.text?.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please enter otp")
        }else{
            self.callApiForSchool()
        }
    }
    
    @IBAction func resendOtpAction(_ sender: UIButton)
    {
        if(resendBtn.currentTitle == Resend_otp){
            sendOTP()
        }else{
           print("timer")
        }
       
        
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
    
    func showConfirmationMsg()
    {
        
        showOKCancelAlertWithCompletion(onVC: self, title: Confirmation, message: Alert_msg, btnOkTitle: YES, btnCancelTitle: NO, onOk: {
            
           
            if(self.noOfVisit > 1){
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.FORM_VC) as! FormViewController
//                FormViewController.noOfVisit = self.noOfVisit - 1
                
                guard let viewControllers = self.navigationController?.viewControllers else {
                    return
                }

                for firstViewController in viewControllers {
                    if firstViewController is FormViewController {
                        FormViewController.noOfVisit = self.noOfVisit - 1
                        onRefreshDelegate?.onRefreshed()
                        self.navigationController?.popToViewController(firstViewController, animated: true)
                        break
                    }
                }
                
//                self.navigationController?.pushViewController(vc,animated: true)
            }else{
                self.pushToHomeVC()
            }
           
           
        }, onCancel: {
            FormViewController.noOfVisit = 0
            self.pushToHomeVC()
        })
    }
    
    func pushToHomeVC(){
        onRefreshDelegate?.onRefreshed()
        FormViewController.noOfVisit = 0
        let vc = self.storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.HOME_VC) as! HomeViewController
        self.navigationController?.pushViewController(vc,animated: true)
    }
    
}
extension OTPViewController{
    func sendOTP(){
        self.view.endEditing(true)
        let params : [String:AnyObject] = [:]
        displaySpinner()
        
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id) ?? ""
        WebServices.send_otp_toMerchant(params,sellerID: user_id,amount: params["payment_price"] as? String ?? "",name: self.nameSchoolParty) { isSuccess, message, otpResponse, userStatus in
            removeSpinner()
            showToast(message: message)
            if(userStatus){
                self.otp = otpResponse ?? ""
                self.startTimer()
                alertModule(onVC: self, title: Alert, msg: message)
            }else{
                alertModule(onVC: self, title: Alert, msg: message)
            }
        }
    }
    
    func callApiForSchool(){
        displaySpinner()
        
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        let schoolID = userdef.string(forKey: SCHOOL_ID)
        
        params["seller_id"] = user_id as AnyObject
        //params["visit_purpose"] = self.visit_purpose as AnyObject
        //params["visit_purpose_remarks"] = self.remarksTxt.text as AnyObject
        if(schoolID != nil){
            params["old_school_id"] = schoolID as AnyObject
        }else{
            params["old_school_id"] = "" as AnyObject
        }
        
        params["sampling"] = "" as AnyObject
        params["primary_sampling"] = "" as AnyObject
        params["group_sampling"] = "" as AnyObject
        
//        params["payment_mode"] = "" as AnyObject
//        params["cheque_no"] = "" as AnyObject
//        params["payment_price"] = "" as AnyObject
//        params["not_received_reason"] = "" as AnyObject
//        params["cheque_price"] = "" as AnyObject
        params["otp_email"] = self.otp as AnyObject
        var imageParams : [String : UIImage?] = [:]
        if (self.concernVistingCard == nil){
            params["concern_visiting_card"] = "" as AnyObject
        }else{
            imageParams["concern_visiting_card"] = self.concernVistingCard
        }
        
        params["order_images"] = "" as AnyObject
        
        WebServices.callsendDataImageAPI(URLName: API_NAME.shared.base_url + API_NAME.shared.addSchoolVisitInfo, param:params, arrImage: imageParams) { response,message  in
            removeSpinner()
            print(response)
            if(response != nil){
                let userStatus = response?[WebConstants.STATUS] as? Bool ?? true
                let error_message = response?[WebConstants.MESSAGE] as? String ?? ""
                showToast(message: error_message)
                if(userStatus){
                    let userdef = UserDefaults.standard
                    userdef.set("", forKey: SCHOOL_ID)
                    if(self.noOfVisit > 1){
                        self.showConfirmationMsg()
                    } else{
                        self.pushToHomeVC()
                    }
                }
            }
        }
        
    }
}
