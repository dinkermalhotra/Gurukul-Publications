
import UIKit
import ToastViewSwift

class OrderViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    
    var params : [String:AnyObject] = [:]
    var noOfVisit = 0
    var concernVistingCard : UIImage? = nil
    var orderImage : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func backBtnClicked(_ sender: UIBarButtonItem)
    {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnAction(_ sender: Any)
    {
        
        if(orderImage == nil){
            alertModule(onVC: self, title: Alert, msg: "Please upload order image")
        }else{
            self.callApiForSchool()
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
            FormViewController.noOfVisit = 0
            self.pushToHomeVC()
        })
    }
    
    func pushToHomeVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.HOME_VC) as! HomeViewController
        self.navigationController?.pushViewController(vc,animated: true)
    }
    
    @IBAction func cameraBtnAction(_ sender: Any)
    {
        let alert = UIAlertController(title: Choose_image, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Camera, style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: Gallery, style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: Cancel, style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: Warning, message: Camera_msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: OK, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: Warning, message: Premission_msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: OK, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //MARK:-- ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            // imageViewPic.contentMode = .scaleToFill
            self.orderImage = pickedImage
            self.cameraBtn.setImage(pickedImage, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
extension OrderViewController{
    
    func callApiForSchool(){
        self.view.endEditing(true)
        displaySpinner()
        
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        
       
        let schoolID = userdef.string(forKey: SCHOOL_ID)
        params["seller_id"] = user_id as AnyObject
//        params["visit_purpose"] = self.visit_purpose as AnyObject
//        params["visit_purpose_remarks"] = self.remarksTxt.text as AnyObject
        params["old_school_id"] = schoolID as AnyObject
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
        
        if (self.orderImage == nil){
            params["order_images"] = "" as AnyObject
        }else{
            imageParams["order_images"] = self.orderImage
        }
        //params["order_images"] = "" as AnyObject
        
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


