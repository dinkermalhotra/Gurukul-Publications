
import UIKit



class PrimaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var primaryBookList = [PrimarySchoolData]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        tableView.allowsMultipleSelection  = true
        
        getPrimaryBookse()
        
    }
    //MARK:- <---------------- TABLE VIEW DELEGATE METHOD ---------------->
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.primaryBookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLINDENTIFIRES_ID.PRIMARY_VIEW_CEll, for: indexPath) as! PrimaryViewControllerCell
        let data = self.primaryBookList[indexPath.row]
        cell.bgView.layer.cornerRadius = 5
        cell.bgView.layer.borderWidth = 0.2
        cell.nameTxt.text = data.Book_Name + " - ₹" + data.RATE
        return cell
    }
    
    var array = [PrimarySchoolData]()


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        array.append(self.primaryBookList[indexPath.row])
        print("selectedarray",array)
        primarySelectedBook?.onSelectedBook(pBookList: array)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let index = array.firstIndex(where: {$0.book_id == self.primaryBookList[indexPath.row].book_id}){
            array.remove(at: index)
        }
        print("selectedarrayR",array)
        primarySelectedBook?.onSelectedBook(pBookList: array)
    }
    
    func getPrimaryBookse(){
        self.primaryBookList.removeAll()
        //let vc = SignInViewController.displaySpinner(onView: self.view)
        
        let params: [String: AnyObject] = ["" :"" as AnyObject,]
        
        WebServices.getPrimarySampleBooks(params) { isSuccess, message, bookData, userStatus in
            
            if isSuccess {
                self.primaryBookList = bookData ?? []
                print(self.primaryBookList)
                //SignInViewController.removeSpinner(spinner: vc)
                self.tableView.reloadData()

            }
            else{
                alertModule(onVC: self, title: Alert, msg: message)
                //SignInViewController.removeSpinner(spinner: vc)
            }
            
        }
        
    }
    
  
}
