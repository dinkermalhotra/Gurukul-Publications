
import UIKit

class GroupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var groupBookList = [GroupBookData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection  = true
        getGroupBooks()
       
    }
    //MARK:- <---------------- TABLE VIEW DELEGATE METHOD ---------------->
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return groupBookList.count
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return groupBookList[section].data.count
        }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.groupBookList.count
//    }
    
    var selectedIndexes = [[IndexPath.init(row: 0, section: 0)], [IndexPath.init(row: 0, section: 0)]]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildCell") as! ChildCell
        cell.selectionStyle = .none
        let data = self.groupBookList[indexPath.section].data[indexPath.row]
        cell.nameTxt.text = data.name
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLINDENTIFIRES_ID.GROUP_VIEW_CELL) as! GroupViewControllerCell
                let data = self.groupBookList[section]
                cell.bgView.layer.cornerRadius = 5
                cell.bgView.layer.borderWidth = 0.2
                cell.nameTxt.text = data.book_name
            return cell
        }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedIndexPathsInSection = tableView.indexPathsForSelectedRows?.filter({ $0.section == indexPath.section }), !selectedIndexPathsInSection.isEmpty {
            selectedIndexPathsInSection.forEach({
                tableView.deselectRow(at: $0, animated: false)
            })
        }
       
        return indexPath
    }
    
    
    var selectedElement = [Int : DataItem]()
    
    var array = [SelectedBooks]()
    var array2 = [DataItem]()
    var selectedGroup = [String]()

    var values : [String] = []
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = array.firstIndex{$0.groupName ==  self.groupBookList[indexPath.section].book_name} ?? -1
        if index >= 0{
            array.remove(at: index)
            array.append(SelectedBooks(groupName:self.groupBookList[indexPath.section].book_name,
                                       price:self.groupBookList[indexPath.section].data[indexPath.row].price,
                                       name:self.groupBookList[indexPath.section].data[indexPath.row].name,
                                       value:self.groupBookList[indexPath.section].data[indexPath.row].value))
        } else {
            array.append(SelectedBooks(groupName:self.groupBookList[indexPath.section].book_name,
                                       price:self.groupBookList[indexPath.section].data[indexPath.row].price,
                                       name:self.groupBookList[indexPath.section].data[indexPath.row].name,
                                       value:self.groupBookList[indexPath.section].data[indexPath.row].value))
        }
        
//        if array.count > 0{
//
//            for intem in array {
//                if (intem.groupName == self.groupBookList[indexPath.section].book_name){
//                    array.append(SelectedBooks(groupName:self.groupBookList[indexPath.section].book_name,
//                                               price:self.groupBookList[indexPath.section].data[indexPath.row].price,
//                                               name:self.groupBookList[indexPath.section].data[indexPath.row].name,
//                                               value:self.groupBookList[indexPath.section].data[indexPath.row].value))
//                    break
//                }
//            }
//
//        }else{
//
//        }
        
       
      
        
        print("selectedarrayG",array)
      
        groupSelectedBook?.onGrpSelectedBook(gBookList: array)

    }
//
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let index = array.firstIndex{$0.groupName ==  self.groupBookList[indexPath.section].book_name && $0.name ==  self.groupBookList[indexPath.section].data[indexPath.row].name} ?? -1
        if index >= 0{
            array.remove(at: index)
        }
        
        groupSelectedBook?.onGrpSelectedBook(gBookList: array)
        
        print("selectedarrayG",array)
        
//        if let index = array.firstIndex(where: {$0.name == self.groupBookList[indexPath.section].data[indexPath.row].name}){
//            array.remove(at: index)
//        }
//        print("selectedarrayG",array)
//        groupSelectedBook?.onGrpSelectedBook(gBookList: array)
    }
    
    func updateHeight() {
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
    func getGroupBooks(){
        self.groupBookList.removeAll()
        //let vc = SignInViewController.displaySpinner(onView: self.view)
        
        let params: [String: AnyObject] = ["" :"" as AnyObject,]
        
        WebServices.getGroupSampleBooks(params) { isSuccess, message, groupBookData, userStatus in
            
            if isSuccess {
                self.groupBookList = groupBookData ?? []
                print(self.groupBookList)
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
