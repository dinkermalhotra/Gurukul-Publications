
import UIKit
import GrowingTextView
class AddPartyViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var remarksView: GrowingTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dispalyRemarksViewData()
        self.navigationItem.title = "Add Party"
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    //MARK: Display Text View Data
    func dispalyRemarksViewData(){
        remarksView.delegate = self
        remarksView.placeholder = "Remarks"
        remarksView.font = UIFont(name: "Arial", size: 17)
        remarksView.minHeight = 100
        remarksView.maxHeight = 100
        remarksView.tintColor = .black
    }
   
   
    @IBAction func submitBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectionCommitteeViewController") as! SelectionCommitteeViewController
        navigationController?.pushViewController(vc,animated: true)
        
    }
    
}
