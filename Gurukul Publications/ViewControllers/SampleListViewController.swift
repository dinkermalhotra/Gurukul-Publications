
import UIKit

class SampleListViewController: UIViewController {
    @IBOutlet weak var primaryView: UIView!
    @IBOutlet weak var individualView: UIView!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Sample List"
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let submitButton = UIBarButtonItem(title: "Submit",  style: .plain, target: self, action: #selector(didTapsubmitButton(sender:)))
        navigationItem.rightBarButtonItems = [submitButton]
        primaryView.alpha = 1
        individualView.alpha = 0
        groupView.alpha = 0
        segmentControl.setupSegment()
    }
    
    @objc func didTapsubmitButton(sender: AnyObject){
        
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
