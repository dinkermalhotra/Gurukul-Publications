//
//  PartyPaymentViewController.swift
//  Gurukul Publications
//
//  Created by Ramakant on 01/10/23.
//

import UIKit
import ToastViewSwift

class PartyPaymentViewController : UIViewController {
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet var checkBoxArray: [UIButton]!
    
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var amountTxt: UITextField!
    
    @IBOutlet weak var checkamountTxt: UITextField!
    
    @IBOutlet weak var reasonTxt: UITextField!
    
    @IBOutlet weak var chequenoText: UITextField!
    
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var chequeNumberView: UIView!
    @IBOutlet weak var checkAmountView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var mobileNoView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var resonView: UIView!
    
    @IBOutlet weak var etNameSchParty: UITextField!
    
    @IBOutlet weak var etMobile: UITextField!
    
    @IBOutlet weak var etEmail: UITextField!
    
    
    
    var selectedButton = 0
    var selectedReturnButtons = 0
    
    var params : [String:AnyObject] = [:]
    var noOfVisit = 0
    var concernVistingCard : UIImage? = nil
    
    var payment_mode = "By Cash"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI()
    {
        checkAmountView.isHidden = true
        chequeNumberView.isHidden = true
        resonView.isHidden = true
        //checkBoxArray[0].isSelected = false
        checkBoxArray[0].isSelected = true
        selectedButton = 0
        
        amountView.isHidden = false
        checkAmountView.isHidden = true
        chequeNumberView.isHidden = true
        resonView.isHidden = true
        nameView.isHidden = false
        mobileNoView.isHidden = false
        emailView.isHidden = false
        amountView.isHidden = false
        btnSubmit.setTitle("SEND OTP", for: .normal)
        
        self.etNameSchParty.text = params["party_name"] as? String ?? ""
        self.etEmail.text = params["party_email"] as? String ?? ""
        self.etMobile.text = params["party_m"] as? String ?? ""
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
            payment_mode = "By Cash"
            checkAmountView.isHidden = true
            chequeNumberView.isHidden = true
            resonView.isHidden = true
            nameView.isHidden = false
            mobileNoView.isHidden = false
            emailView.isHidden = false
            amountView.isHidden = false
            btnSubmit.setTitle("SEND OTP", for: .normal)
        }
        else if selectedButton == 1
        {
            payment_mode = "By cheque"
            chequeNumberView.isHidden = false
            nameView.isHidden = false
            mobileNoView.isHidden = false
            emailView.isHidden = false
            amountView.isHidden = false
            checkAmountView.isHidden = true
            resonView.isHidden = true
            btnSubmit.setTitle("SEND OTP", for: .normal)
        }
        else if selectedButton == 2
        {
            payment_mode = "Both (Cash & Cheque)"
            chequeNumberView.isHidden = false
            checkAmountView.isHidden = false
            nameView.isHidden = false
            mobileNoView.isHidden = false
            emailView.isHidden = false
            amountView.isHidden = false
            resonView.isHidden = true
            btnSubmit.setTitle("SEND OTP", for: .normal)
        }
        else if selectedButton == 3
        {
            payment_mode = "RTGS"
            chequeNumberView.isHidden = true
            checkAmountView.isHidden = true
            resonView.isHidden = true
            nameView.isHidden = false
            mobileNoView.isHidden = false
            emailView.isHidden = false
            amountView.isHidden = false
            btnSubmit.setTitle("SEND OTP", for: .normal)
        }
        else if selectedButton == 4
        {
            payment_mode = "No payment collected"
            chequeNumberView.isHidden = true
            checkAmountView.isHidden = true
            nameView.isHidden = true
            mobileNoView.isHidden = true
            emailView.isHidden = true
            amountView.isHidden = true
            resonView.isHidden = false
            btnSubmit.setTitle("SUBMIT", for: .normal)
        }

    }
    
    
    @IBAction func submitBtnAction(_ sender: Any)
    {
        pushToOtpVC()
    }
    
    func pushToOtpVC()
    {
        
        if(self.btnSubmit.currentTitle == "SUBMIT"){
            if(self.payment_mode == "No payment collected"){
                if(self.reasonTxt.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter reason")
                }else{
                    callApiForParty()
                }
            }
            
            
        }else{
            params["p_payment_mode"] = self.payment_mode as AnyObject
            params["p_cheque_no"] = self.chequenoText.text as AnyObject
            params["p_payment_price"] = self.amountTxt.text as AnyObject
            params["p_not_received_reason"] = self.reasonTxt.text as AnyObject
            params["p_cheque_price"] = self.checkamountTxt.text as AnyObject
            
            if(self.payment_mode == "By Cash"){
                if(self.amountTxt.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter amount")
                }else if(self.etNameSchParty.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter name of school/party")
                }else if(self.etMobile.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter mobile")
                }else if(self.etEmail.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter email")
                }else{
//                    let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.OTP_VC) as! OTPViewController
//                    vc.params = params
//                    vc.noOfVisit = self.noOfVisit
//                    vc.nameSchoolParty = self.etNameSchParty.text ?? ""
//                    vc.phone = self.etMobile.text ?? ""
//                    vc.email = self.etEmail.text ?? ""
//                    navigationController?.pushViewController(vc,animated: true)
                    self.sendOTP()
                }
            }
            else if(self.payment_mode == "By cheque"){
                if(self.amountTxt.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter amount")
                }else if(self.chequenoText.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter cheque number")
                }else if(self.etNameSchParty.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter name of school/party")
                }else if(self.etMobile.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter mobile")
                }else if(self.etEmail.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter email")
                }else{
//                    let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.OTP_VC) as! OTPViewController
//                    vc.params = params
//                    vc.noOfVisit = self.noOfVisit
//                    vc.nameSchoolParty = self.etNameSchParty.text ?? ""
//                    vc.phone = self.etMobile.text ?? ""
//                    vc.email = self.etEmail.text ?? ""
//                    navigationController?.pushViewController(vc,animated: true)
                    self.sendOTP()
                }
            }
            else if(self.payment_mode == "Both (Cash & Cheque)"){
                if(self.amountTxt.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter amount")
                }else if(self.chequenoText.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter cheque number")
                }else if(self.checkamountTxt.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter cheque amount")
                }else if(self.etNameSchParty.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter name of school/party")
                }else if(self.etMobile.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter mobile")
                }else if(self.etEmail.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter email")
                }else{
//                    let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.OTP_VC) as! OTPViewController
//                    vc.params = params
//                    vc.noOfVisit = self.noOfVisit
//                    vc.nameSchoolParty = self.etNameSchParty.text ?? ""
//                    vc.phone = self.etMobile.text ?? ""
//                    vc.email = self.etEmail.text ?? ""
//                    navigationController?.pushViewController(vc,animated: true)
                    self.sendOTP()
                }
            }
            else if(self.payment_mode == "RTGS"){
                if(self.amountTxt.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter amount")
                }else if(self.etNameSchParty.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter name of school/party")
                }else if(self.etMobile.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter mobile")
                }else if(self.etEmail.text?.isEmpty == true){
                    alertModule(onVC: self, title: Alert, msg: "Please enter email")
                }else{
//                    let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.OTP_VC) as! OTPViewController
//                    vc.params = params
//                    vc.noOfVisit = self.noOfVisit
//                    vc.nameSchoolParty = self.etNameSchParty.text ?? ""
//                    vc.phone = self.etMobile.text ?? ""
//                    vc.email = self.etEmail.text ?? ""
//                    navigationController?.pushViewController(vc,animated: true)
                    self.sendOTP()
                }
            }
            
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
                        self.navigationController?.popToViewController(firstViewController, animated: true)
                        break
                    }
                }
                
//                self.navigationController?.pushViewController(vc,animated: true)
            }else{
                self.pushToHomeVC()
            }
           
           
        }, onCancel: {
            AddPartyViewController.noOfVisit = 0
            self.pushToHomeVC()
        })
    }
    
    func pushToHomeVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.HOME_VC) as! HomeViewController
        self.navigationController?.pushViewController(vc,animated: true)
    }

    
}
extension PartyPaymentViewController{
    func callApiForParty(){
        self.view.endEditing(true)
        displaySpinner()
        
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        
        params["seller_id"] = user_id as AnyObject
//        params["visit_purpose"] = self.visit_purpose as AnyObject
//        params["visit_purpose_remarks"] = self.remarksTxt.text as AnyObject
        //params["party_id"] = "" as AnyObject
        
        params["p_sampling_month"] = "" as AnyObject
        params["p_sampling"] = "" as AnyObject
        params["p_primary_sampling"] = "" as AnyObject
        params["p_group_sampling"] = "" as AnyObject
        
        params["p_payment_mode"] = "" as AnyObject
        params["p_cheque_no"] = "" as AnyObject
        params["p_payment_price"] = "" as AnyObject
        params["p_not_received_reason"] = self.reasonTxt.text as AnyObject
        params["p_cheque_price"] = "" as AnyObject
        params["p_otp_email"] = "" as AnyObject
        
        var imageParams : [String : UIImage?] = [:]
        if (self.concernVistingCard == nil){
            params["p_concern_visiting_card"] = "" as AnyObject
        }else{
            imageParams["p_concern_visiting_card"] = self.concernVistingCard
        }
        
        params["p_order_images"] = "" as AnyObject
        
        WebServices.callsendDataImageAPI(URLName: API_NAME.shared.base_url + API_NAME.shared.addPartyInfo, param:params, arrImage: imageParams) { response,message  in
            removeSpinner()
            print(response)
            if(response != nil){
                let userStatus = response?[WebConstants.STATUS] as? Bool ?? true
                let error_message = response?[WebConstants.MESSAGE] as? String ?? ""
                showToast(message: error_message)
                if(userStatus){
                    if(self.noOfVisit > 1){
                        self.showConfirmationMsg()
                    } else{
                        self.pushToHomeVC()
                    }
                }
            }
        }
    }
    
    func sendOTP(){
        self.view.endEditing(true)
        let amountt = self.amountTxt.text ?? "0"
        let chqamountt = self.checkamountTxt.text ?? "0"
        var totalPrice = self.amountTxt.text ?? "0";
        if (self.checkamountTxt.text?.isEmpty == false){
            let total = ((amountt.isEmpty == false ? amountt : "0") as NSString).doubleValue + ((chqamountt.isEmpty == false ? chqamountt : "0") as NSString).doubleValue //Double.parseDouble(amount)+Double.parseDouble(checkamount);
            totalPrice = "\(total)"
        }
        
        let params : [String:AnyObject] = [:]
        displaySpinner()
        
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id) ?? ""
        WebServices.send_otp_toMerchant(params,sellerID: user_id,amount: totalPrice,name: self.etNameSchParty.text ?? "") { isSuccess, message, otpResponse, userStatus in
            removeSpinner()
            showToast(message: message)
            if(userStatus){
                //self.otp = otpResponse?.otp ?? ""
                //alertModule(onVC: self, title: Alert, msg: message)
                print(otpResponse)
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: STORYBOARDS_ID.OTP_PARTY_VC) as! PartyOTPViewController
                vc.params = self.params
                vc.noOfVisit = self.noOfVisit
                vc.nameSchoolParty = self.etNameSchParty.text ?? ""
                vc.phone = self.etMobile.text ?? ""
                vc.email = self.etEmail.text ?? ""
                vc.otp = otpResponse ?? ""
                self.navigationController?.pushViewController(vc,animated: true)
            }else{
                alertModule(onVC: self, title: Alert, msg: message)
            }
        }
    }
    
}
