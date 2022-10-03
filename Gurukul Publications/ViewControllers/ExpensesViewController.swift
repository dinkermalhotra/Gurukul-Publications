
import UIKit
import SDWebImage
class ExpensesViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var localBtn: UIButton!
    @IBOutlet weak var outStationBtn: UIButton!
    @IBOutlet var checkBoxArray: [UIButton]!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet var travledView: UIView!
    @IBOutlet var localTAView: UIView!
    @IBOutlet var LocalDAView: UIView!
    @IBOutlet var originView: UIView!
    @IBOutlet var otherDestinationView: UIView!
    @IBOutlet var workingView: UIView!
    @IBOutlet var returnView: UIView!
    @IBOutlet var modeTravelView: UIView!
    @IBOutlet var categoriesView: UIView!
    @IBOutlet var kmTravled: UIView!
    @IBOutlet var outStationTA: UIView!
    @IBOutlet var outStationDA: UIView!
    @IBOutlet var startKms: UIView!
    @IBOutlet var endKms: UIView!
    @IBOutlet var expense1: UIView!
    @IBOutlet var expense2: UIView!
    @IBOutlet var expense3: UIView!
    @IBOutlet var totalExpense: UIView!
    @IBOutlet var remarksView: UIView!
    @IBOutlet var returnBtns: [UIButton]!
    @IBOutlet var taImageView: UIView!
    @IBOutlet var daImageView: UIView!
    @IBOutlet var startKmsImageView: UIView!
    @IBOutlet var endKmsImageView: UIView!
    @IBOutlet var missExpImageView1: UIView!
    @IBOutlet var missExpImageView2: UIView!
    @IBOutlet var missExpImageView3: UIView!
    @IBOutlet var taImageBtn: UIButton!
    @IBOutlet var daImageBtn: UIButton!
    @IBOutlet var outStationTAImageBtn: UIButton!
    @IBOutlet var outStationDAImageBtn: UIButton!
    @IBOutlet var startKmsImageBtn: UIButton!
    @IBOutlet var endKmsImageBtn: UIButton!
    @IBOutlet var missExpImageBtn1: UIButton!
    @IBOutlet var missExpImageBtn2: UIButton!
    @IBOutlet var missExpImageBtn3: UIButton!
    @IBOutlet var addSupportingBtn: UIButton!
    @IBOutlet var taImage: UIImageView!
    @IBOutlet var daImage: UIImageView!
    @IBOutlet var startKmsImage: UIImageView!
    @IBOutlet var endKmsImage: UIImageView!
    @IBOutlet var missExpImage1: UIImageView!
    @IBOutlet var missExpImage2: UIImageView!
    @IBOutlet var missExpImage3: UIImageView!
    @IBOutlet var scrollViewBottom: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageStackView: UIStackView!
    var selectedButton = 0
    var selectedReturnButtons = 0
    var ImageBtnTitle = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dateField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        setupUI()
    }
    
    @objc func tapDone() {
        if let datePicker = self.dateField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = Date_formatterSlash
            self.dateField.text = dateformatter.string(from: datePicker.date)
        }
        self.dateField.resignFirstResponder()
    }
    
    func setupUI(){
        originView.isHidden = true
        workingView.isHidden = true
        otherDestinationView.isHidden = true
        returnView.isHidden = true
        kmTravled.isHidden = true
        outStationDA.isHidden = true
        outStationTA.isHidden = true
    }
    
    @IBAction func outStationBtnAction(_ sender: UIButton)
    {
        if outStationBtn.currentImage == UIImage(named: "uncheckbox.png") {
            self.outStationBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            self.localBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
            setupOutStationUi()
        }
        else
        {
            self.outStationBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            self.localBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
            setupOutStationUi()
        }
    }
    func setupOutStationUi(){
        originView.isHidden = false
        workingView.isHidden = false
        otherDestinationView.isHidden = false
        returnView.isHidden = false
        kmTravled.isHidden = false
        outStationDA.isHidden = false
        outStationTA.isHidden = false
        travledView.isHidden = true
        localTAView.isHidden = true
        LocalDAView.isHidden = true
        
    }
    @IBAction func addSupportingBtnAction(_ sender: UIButton)
    {
        ImageBtnTitle = "Add Supporting Document"
        chooseImage()
    }
    @IBAction func localBtnAction(_ sender: UIButton) {
        if localBtn.currentImage == UIImage(named: "uncheckbox.png") {
            self.localBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            self.outStationBtn.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
            steupLocalBtnUI()
            setupUI()
        }
        else {
            self.localBtn.setImage(UIImage(named: "checkbox.png"), for: .normal)
            steupLocalBtnUI()
        }
    }
    func steupLocalBtnUI() {
        travledView.isHidden = false
        localTAView.isHidden = false
        LocalDAView.isHidden = false
    }
    
    @IBAction func returnBtnsClicked(_ sender: UIButton) {
        let tag = sender.tag
        returnBtns[selectedReturnButtons].isSelected = false
        returnBtns[tag].isSelected = true
        selectedReturnButtons = tag
    }
    
    
    @IBAction func checkBoxArrayAction(_ sender: UIButton) {
        
        let tag = sender.tag
        checkBoxArray[selectedButton].isSelected = false
        checkBoxArray[tag].isSelected = true
        selectedButton = tag
    }
    
    @IBAction func taBtnClicked(_ sender: UIButton) {
        ImageBtnTitle = "Local TA"
        chooseImage()
        
        
    }
    
    @IBAction func daBtnClicked(_ sender: UIButton) {
        ImageBtnTitle = "Local DA"
        chooseImage()
        
    }
    @IBAction func outStationTABtnClicked(_ sender: UIButton) {
        ImageBtnTitle = "Out Station TA"
        chooseImage()
        
    }
    
    @IBAction func outStationDABtnClicked(_ sender: UIButton)
    {
        
        ImageBtnTitle = "Out Station DA"
        chooseImage()
    }
    
    @IBAction func startKmsBtnClicked(_ sender: UIButton)
    {
        
        ImageBtnTitle = "Start Kms"
        chooseImage()
    }
    
    @IBAction func endKmsBtnClicked(_ sender: UIButton)
    {
        ImageBtnTitle = "End Kms"
        chooseImage()
    }
    
    @IBAction func missExpBtnClicked1(_ sender: UIButton)
    {
        ImageBtnTitle = "Miss. Expense1"
        chooseImage()
    }
    
    @IBAction func missExpBtnClicked2(_ sender: UIButton)
    {
        ImageBtnTitle = "Miss. Expense2"
        chooseImage()
    }
    
    @IBAction func missExpBtnClicked3(_ sender: UIButton)
    {
        ImageBtnTitle = "Miss. Expense3"
        chooseImage()
    }
    
    
    
    
    @IBAction func submitBtnAction(_ sender: UIButton)
    
    {
        
        
    }
    
    func chooseImage()
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
            let alert  = UIAlertController(title: Warning, message: Gallery_premission, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: OK, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:-- ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            // imageViewPic.contentMode = .scaleToFill
            if ImageBtnTitle == "Add Supporting Document"
            {
                self.addSupportingBtn.setImage(pickedImage, for: .normal)
            }
            else if ImageBtnTitle == "Local TA" || ImageBtnTitle == "Out Station TA"
            {
                taImageView.isHidden = false
                self.taImage.image = pickedImage
            }
            else if ImageBtnTitle == "Local DA" || ImageBtnTitle == "Out Station DA"
            {
                daImageView.isHidden = false
                self.daImage.image = pickedImage
            }
            else if ImageBtnTitle == "Start Kms"
            {
                startKmsImageView.isHidden = false
                self.startKmsImage.image = pickedImage
            }
            else if ImageBtnTitle == "End Kms"
            {
                endKmsImageView.isHidden = false
                self.endKmsImage.image = pickedImage
            }
            
            else if ImageBtnTitle == "Miss. Expense1"
            {
                missExpImageView1.isHidden = false
                self.missExpImage1.image = pickedImage
            }
            else if ImageBtnTitle == "Miss. Expense2"
            {
                missExpImageView2.isHidden = false
                self.missExpImage2.image = pickedImage
            }
            else
            {
                missExpImageView3.isHidden = false
                self.missExpImage3.image = pickedImage
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}
