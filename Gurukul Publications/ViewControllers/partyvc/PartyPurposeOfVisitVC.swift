//
//  PartyPurposeOfVisitVC.swift
//  Gurukul Publications
//
//  Created by Ramakant on 01/10/23.
//

import UIKit
import ToastViewSwift

class PartyPurposeOfVisitVC: UIViewController {
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var remarksView: UIView!
    @IBOutlet weak var remarksTxt: UITextField!
    @IBOutlet weak var remarksLbl: UILabel!
    @IBOutlet weak var submitBtnTop: NSLayoutConstraint!
    @IBOutlet var checkBoxArray: [UIButton]!
    
    var noOfVisit = 0
    var saveDefaultValue = ""
    var selectedButton = 0
    var visit_purpose = ""
    
    var concernVistingCard : UIImage? = nil
    
    var params : [String:AnyObject] = [:]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //submitBtnTop.constant = 30
        
        if(AddPartyViewController.visit_purpose == "Sample"){
            visit_purpose = FormViewController.visit_purpose
            checkBoxArray[0].isSelected = true
            selectedButton = 0
            saveDefaultValue = "0"
            showRemarksView()
        }else if(AddPartyViewController.visit_purpose == "First Visit"){
            visit_purpose = FormViewController.visit_purpose
            checkBoxArray[1].isSelected = true
            selectedButton = 1
            saveDefaultValue = "1"
            showRemarksView()
        }else if(FormViewController.visit_purpose == "Order"){
            visit_purpose = FormViewController.visit_purpose
            checkBoxArray[2].isSelected = true
            selectedButton = 2
            saveDefaultValue = "2"
            showRemarksView()
        }else if(AddPartyViewController.visit_purpose == "Follow up"){
            visit_purpose = FormViewController.visit_purpose
            checkBoxArray[3].isSelected = true
            selectedButton = 3
            saveDefaultValue = "3"
            showRemarksView()
        }else if(AddPartyViewController.visit_purpose == "Collection"){
            visit_purpose = FormViewController.visit_purpose
            checkBoxArray[4].isSelected = true
            selectedButton = 4
            saveDefaultValue = "4"
            showRemarksView()
        }else if(AddPartyViewController.visit_purpose == "Gift"){
            visit_purpose = FormViewController.visit_purpose
            checkBoxArray[5].isSelected = true
            selectedButton = 5
            saveDefaultValue = "5"
            showRemarksView()
        }else if(AddPartyViewController.visit_purpose == "Sales Return"){
            visit_purpose = FormViewController.visit_purpose
            checkBoxArray[6].isSelected = true
            selectedButton = 6
            saveDefaultValue = "6"
            showRemarksView()
        }else{
            visit_purpose = ""
        }
        
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
                    self.visit_purpose = "Sample"
                    showRemarksView()
                    saveDefaultValue = "0"
                }
                else if btn?.tag == 1
                {
                    self.visit_purpose = "First Visit"
                    showRemarksView()
                    saveDefaultValue = "1"
                    ///showAlertMsg()
                }
                else if btn?.tag == 2
                {
                    self.visit_purpose = "Order"
                    showRemarksView()
                    saveDefaultValue = "2"
                    
                }
                else if btn?.tag == 3
                {
                    self.visit_purpose = "Follow up"
                    showRemarksView()
                    saveDefaultValue = "3"
                }
                else if btn?.tag == 4
                {
                    self.visit_purpose = "Collection"
                    showRemarksView()
                    saveDefaultValue = "4"
                    
                }
                else if btn?.tag == 5
                {
                    self.visit_purpose = "Gift"
                    showRemarksView()
                    saveDefaultValue = "5"
                }
                else if btn?.tag == 6
                {
                    self.visit_purpose = "Sales Return"
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
        if( self.visit_purpose.isEmpty == true){
            alertModule(onVC: self, title: Alert, msg: "Please select purpose of visit")
        }else{
           
            if saveDefaultValue == "0"
            {
                pushToSampleListVc()
            }
            
            else if saveDefaultValue == "1"
            {
                //showConfirmationMsg()
                self.callApiForParty()
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
                    //showConfirmationMsg()
                    self.callApiForParty()
                }
            }
            
            else if saveDefaultValue == "4"
            {
                
                pushToPaymentVC()
            }
            
            else if saveDefaultValue == "5"
            {
                
                //showConfirmationMsg()
                self.callApiForParty()
            }
            
            else if saveDefaultValue == "6"
            {
               
                //showConfirmationMsg()
                self.callApiForParty()
            }
            
            else
            {
                
                
            }
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
            
           
            if(self.noOfVisit > 1){
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.FORM_VC) as! FormViewController
//                FormViewController.noOfVisit = self.noOfVisit - 1
                
                guard let viewControllers = self.navigationController?.viewControllers else {
                    return
                }

                for firstViewController in viewControllers {
                    if firstViewController is AddPartyViewController {
                        AddPartyViewController.noOfVisit = self.noOfVisit - 1
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
    
    func pushToOrderVC()
    {
        params["p_visit_purpose"] = self.visit_purpose as AnyObject
        params["p_visit_purpose_remarks"] = self.remarksTxt.text as AnyObject
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.ORDER_PARTY_VC) as! PartyOrderViewController
        vc.params = self.params
        vc.concernVistingCard = self.concernVistingCard
        vc.noOfVisit = noOfVisit
        self.navigationController?.pushViewController(vc,animated: true)
    }
    func pushToSampleListVc()
    {
        params["p_visit_purpose"] = self.visit_purpose as AnyObject
        params["p_visit_purpose_remarks"] = self.remarksTxt.text as AnyObject
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.SAMPLE_LIST_PARTY_VC) as! PartySampleListVC
        vc.params = self.params
        vc.concernVistingCard = self.concernVistingCard
        vc.noOfVisit = noOfVisit
        self.navigationController?.pushViewController(vc,animated: true)
        
    }
    func pushToPaymentVC()
    {
        params["p_visit_purpose"] = self.visit_purpose as AnyObject
        params["p_visit_purpose_remarks"] = self.remarksTxt.text as AnyObject
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.PAYMENT_PARTY_VC) as! PartyPaymentViewController
        vc.params = self.params
        vc.concernVistingCard = self.concernVistingCard
        vc.noOfVisit = noOfVisit
        self.navigationController?.pushViewController(vc,animated: true)
    }
    
    func pushToHomeVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.HOME_VC) as! HomeViewController
        self.navigationController?.pushViewController(vc,animated: true)
    }
    
}
extension PartyPurposeOfVisitVC{
    func callApiForParty(){
        self.view.endEditing(true)
        displaySpinner()
        
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        params["seller_id"] = user_id as AnyObject
        params["p_visit_purpose"] = self.visit_purpose as AnyObject
        params["p_visit_purpose_remarks"] = self.remarksTxt.text as AnyObject
        //params["party_id"] = "" as AnyObject
        
        params["p_sampling_month"] = "" as AnyObject
        params["p_sampling"] = "" as AnyObject
        params["p_primary_sampling"] = "" as AnyObject
        params["p_group_sampling"] = "" as AnyObject
        
        params["p_payment_mode"] = "" as AnyObject
        params["p_cheque_no"] = "" as AnyObject
        params["p_payment_price"] = "" as AnyObject
        params["p_not_received_reason"] = "" as AnyObject
        params["p_cheque_price"] = "" as AnyObject
        params["p_otp_email"] = "" as AnyObject
        var imageParams : [String : UIImage?] = [:]
        if (self.concernVistingCard == nil){
            params["p_concern_visiting_card"] = "" as AnyObject
        }else{
            imageParams["p_concern_visiting_card"] = self.concernVistingCard
        }
        params["p_order_images"] = "" as AnyObject
      
        //params["order_images"] = "" as AnyObject
        print(params)
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
}

