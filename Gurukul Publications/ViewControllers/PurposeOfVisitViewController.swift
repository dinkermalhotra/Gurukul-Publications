

import UIKit
import ToastViewSwift

class PurposeOfVisitViewController: UIViewController {
    
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
        
        if(FormViewController.visit_purpose == "Sample"){
            visit_purpose = FormViewController.visit_purpose
            checkBoxArray[0].isSelected = true
            selectedButton = 0
            saveDefaultValue = "0"
            showRemarksView()
        }else if(FormViewController.visit_purpose == "First Visit"){
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
        }else if(FormViewController.visit_purpose == "Follow up"){
            visit_purpose = FormViewController.visit_purpose
            checkBoxArray[3].isSelected = true
            selectedButton = 3
            saveDefaultValue = "3"
            showRemarksView()
        }else if(FormViewController.visit_purpose == "Collection"){
            visit_purpose = FormViewController.visit_purpose
            checkBoxArray[4].isSelected = true
            selectedButton = 4
            saveDefaultValue = "4"
            showRemarksView()
        }else if(FormViewController.visit_purpose == "Gift"){
            visit_purpose = FormViewController.visit_purpose
            checkBoxArray[5].isSelected = true
            selectedButton = 5
            saveDefaultValue = "5"
            showRemarksView()
        }else if(FormViewController.visit_purpose == "Sales Return"){
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
                self.callApiForSchool()
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
                    self.callApiForSchool()
                }
            }
            
            else if saveDefaultValue == "4"
            {
                
                pushToPaymentVC()
            }
            
            else if saveDefaultValue == "5"
            {
                
                //showConfirmationMsg()
                self.callApiForSchool()
            }
            
            else if saveDefaultValue == "6"
            {
               
                //showConfirmationMsg()
                self.callApiForSchool()
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
    
    func pushToOrderVC()
    {
        params["visit_purpose"] = self.visit_purpose as AnyObject
        params["visit_purpose_remarks"] = self.remarksTxt.text as AnyObject
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.ORDER_VC) as! OrderViewController
        vc.params = self.params
        vc.concernVistingCard = self.concernVistingCard
        vc.noOfVisit = noOfVisit
        self.navigationController?.pushViewController(vc,animated: true)
    }
    func pushToSampleListVc()
    {
        params["visit_purpose"] = self.visit_purpose as AnyObject
        params["visit_purpose_remarks"] = self.remarksTxt.text as AnyObject
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.SAMPLE_LIST_VC) as! SampleListViewController
        vc.params = self.params
        vc.concernVistingCard = self.concernVistingCard
        vc.noOfVisit = noOfVisit
        self.navigationController?.pushViewController(vc,animated: true)
        
    }
    func pushToPaymentVC()
    {
        params["visit_purpose"] = self.visit_purpose as AnyObject
        params["visit_purpose_remarks"] = self.remarksTxt.text as AnyObject
        let vc = storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.PAYMENT_VC) as! PaymentViewController
        vc.params = self.params
        vc.concernVistingCard = self.concernVistingCard
        vc.noOfVisit = noOfVisit
        self.navigationController?.pushViewController(vc,animated: true)
    }
    
}
extension PurposeOfVisitViewController{
    
    func callApiForSchool(){
        self.view.endEditing(true)
        displaySpinner()
        
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        let schoolID = userdef.string(forKey: SCHOOL_ID)
        params["seller_id"] = user_id as AnyObject
        params["visit_purpose"] = self.visit_purpose as AnyObject
        params["visit_purpose_remarks"] = self.remarksTxt.text as AnyObject
        if(schoolID != nil){
            params["old_school_id"] = schoolID as AnyObject
        }else{
            params["old_school_id"] = "" as AnyObject
        }
        params["sampling"] = "" as AnyObject
       
        params["primary_sampling"] = "" as AnyObject
        params["group_sampling"] = "" as AnyObject
        params["payment_mode"] = "" as AnyObject
        params["cheque_no"] = "" as AnyObject
        params["payment_price"] = "" as AnyObject
        params["not_received_reason"] = "" as AnyObject
        params["cheque_price"] = "" as AnyObject
        params["otp_email"] = "" as AnyObject
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
                FormViewController.visit_purpose = ""
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
        
        
        
        
        
//        let params: [String: AnyObject] = [
//            "seller_id": user_id as AnyObject,
//            "visited_area":"" as AnyObject,
//            "sch_category":"" as AnyObject,
//            "school_name":"" as AnyObject,
//            "address":"" as AnyObject,
//            "sch_phone":"" as AnyObject,
//            "sch_email":"" as AnyObject,
//            "sch_mobile":"" as AnyObject,
//            "district":"" as AnyObject,
//            "city":"" as AnyObject,
//            "state":"" as AnyObject,
//            "sch_stg":"" as AnyObject,
//            "sch_upto":"" as AnyObject,
//            "purchase":"" as AnyObject,
//            "concern_person":"" as AnyObject,
//            "concern_name":"" as AnyObject,
//            "concern_m":"" as AnyObject,
//            "visit_purpose":"" as AnyObject,
//            "sampling_month":"" as AnyObject,
//            "bose":"" as AnyObject,
//            "party_id":"" as AnyObject,
//            "party_name":"" as AnyObject,
//            "remarks":"" as AnyObject,
//            "sampling":"" as AnyObject,
//            "old_school_id":"" as AnyObject,
//            "visit_date":"" as AnyObject,
//            "teacher_names":"" as AnyObject,
//            "teacher_mobiles":"" as AnyObject,
//            "sch_branches":"" as AnyObject,
//            "pincode":"" as AnyObject,
//
//            "concern_remarks":"" as AnyObject,
//            "primary_sampling":"" as AnyObject,
//            "group_sampling":"" as AnyObject,
//            "visit_purpose_remarks":"" as AnyObject,
//
//            "payment_mode":"" as AnyObject,
//            "cheque_no":"" as AnyObject,
//            "payment_price":"" as AnyObject,
//            "not_received_reason":"" as AnyObject,
//            "cheque_price":"" as AnyObject,
//            "otp_email":"" as AnyObject
//        ]
        
    }
}
