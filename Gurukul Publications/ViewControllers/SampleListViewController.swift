
import UIKit

class SampleListViewController: UIViewController {
    @IBOutlet weak var primaryView: UIView!
    @IBOutlet weak var individualView: UIView!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
      
    }
    
    func setupUI(){
        primaryView.alpha = 1
        individualView.alpha = 0
        groupView.alpha = 0
        segmentControl.setupSegment()
    }
    
    @IBAction func backbtnClicked(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnClicked(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            primaryView.alpha = 1
            individualView.alpha = 0
            groupView.alpha = 0
            segmentControl.changeUnderlinePosition()
        }
        else if sender.selectedSegmentIndex == 1
        {
            primaryView.alpha = 0
            individualView.alpha = 1
            groupView.alpha = 0
            segmentControl.changeUnderlinePosition()
        }
        else
        {
            primaryView.alpha = 0
            individualView.alpha = 0
            groupView.alpha = 1
            segmentControl.changeUnderlinePosition()
        }
        
        
    }
    
}
