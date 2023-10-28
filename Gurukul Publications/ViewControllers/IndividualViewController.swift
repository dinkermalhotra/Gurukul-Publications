
import UIKit

class IndividualViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var indiBookList = [PrimarySchoolData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection  = true
        getIndiidaulBooks()
        
    }
    
    //MARK:- <---------------- TABLE VIEW DELEGATE METHOD ---------------->
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indiBookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLINDENTIFIRES_ID.INDIVIDUAL_VIEW_CELL, for: indexPath) as! IndividualViewControllerCell
        let data = self.indiBookList[indexPath.row]
        cell.bgView.layer.cornerRadius = 5
        cell.bgView.layer.borderWidth = 0.2
        cell.nameTxt.text = data.Book_Name + " - ₹" + data.RATE
        
        return cell
        
    }
    
    var array = [PrimarySchoolData]()


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        array.append(self.indiBookList[indexPath.row])
        print("selectedarrayInd",array)
        individaulSelectedBook?.onIndSelectedBook(iBookList: array)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let index = array.firstIndex(where: {$0.book_id == self.indiBookList[indexPath.row].book_id}){
            array.remove(at: index)
        }
        print("selectedarrayIndR",array)
        individaulSelectedBook?.onIndSelectedBook(iBookList: array)
    }
    
    func getIndiidaulBooks(){
        self.indiBookList.removeAll()
        //let vc = SignInViewController.displaySpinner(onView: self.view)
        
        let params: [String: AnyObject] = ["" :"" as AnyObject,]
        
        WebServices.getAllSampleBooks(params) { isSuccess, message, bookData, userStatus in
            
            if isSuccess {
                self.indiBookList = bookData ?? []
                print(self.indiBookList)
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
