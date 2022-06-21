

import UIKit
import DropDown

class SelectionCommitteeViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    @IBOutlet weak var dropDown: UIButton!
    @IBOutlet weak var submitBtnTop: NSLayoutConstraint!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var concernPersonView: UIView!
    @IBOutlet weak var concernPersonLbl: UILabel!
    @IBOutlet weak var remarksView: UIView!
    @IBOutlet weak var remarksTxt: UITextField!
    @IBOutlet weak var remarksLbl: UILabel!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var mobileNoLbl: UILabel!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    var receivedString = ""
    
    let dropDownMenu = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtnTop.constant = 50
        
        self.navigationItem.title = "Selection Committee"
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    @IBAction func dropDownBtnAction(_ sender: Any) {
        if receivedString == "true"{
            dropDownMenu.dataSource = ["Coordinator", "Principle", "Director", "Librarian","Vice Principle","Subject Teacher","Others"]
        }else{
            dropDownMenu.dataSource =  ["Owner", "Proprietor", "Business Partner", "Manager"]
        }
        
        dropDownMenu.anchorView = sender as? AnchorView
        dropDownMenu.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height)
        dropDownMenu.show()
        dropDownMenu.backgroundColor = .white
        dropDownMenu.selectionAction = { [weak self] (index: Int, item: String) in
            
            guard let _ = self else { return}
            (sender as AnyObject).setTitle(item, for: .normal)
            self?.dropDown.setTitleColor(.black, for: .normal)
            self?.nameTxt.isHidden = false
            self?.nameLbl.isHidden = false
            self?.nameView.isHidden = false
            self?.mobileTxt.isHidden = false
            self?.mobileView.isHidden = false
            self?.mobileNoLbl.isHidden = false
            self?.remarksLbl.isHidden = false
            self?.remarksTxt.isHidden = false
            self?.remarksView.isHidden = false
            self?.cameraBtn.isHidden = false
            self?.submitBtnTop.constant = 355
        }
    }
    
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        if dropDown.currentTitle == "Select concern"{
            alertModule(onVC: self, title: "Alert", msg: "Please select concern person")
        }
        else if (nameTxt.text?.isEmpty ?? true)
        {
            
            alertModule(onVC: self, title: "Alert", msg: "Please enter concern person name")
        }
        else if (mobileTxt.text?.isEmpty ?? true)
        {
            
            alertModule(onVC: self, title: "Alert", msg: "Please enter concern person mobile no.")
        }
        else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PurposeOfVisitViewController") as! PurposeOfVisitViewController
            navigationController?.pushViewController(vc,animated: true)
        }
        
    }
    
    @IBAction func cameraBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
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
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
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
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //MARK:-- ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            // imageViewPic.contentMode = .scaleToFill
            self.cameraBtn.setImage(pickedImage, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


