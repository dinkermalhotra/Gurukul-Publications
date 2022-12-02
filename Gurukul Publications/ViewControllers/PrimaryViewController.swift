
import UIKit

class PrimaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        tableView.allowsMultipleSelection  = true
        
    }
    //MARK:- <---------------- TABLE VIEW DELEGATE METHOD ---------------->
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLINDENTIFIRES_ID.PRIMARY_VIEW_CEll, for: indexPath) as! PrimaryViewControllerCell
        cell.bgView.layer.cornerRadius = 5
        cell.bgView.layer.borderWidth = 0.2
        return cell
    }
  
}
