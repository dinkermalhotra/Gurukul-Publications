//
//  SelectedBookViewController.swift
//  Gurukul Publications
//
//  Created by Ramakant on 13/09/23.
//

import UIKit
import ToastViewSwift

class SelectedBookViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    var params : [String:AnyObject] = [:]
    
    var pBookList = [PrimarySchoolData]()
    var iBookList = [PrimarySchoolData]()
    var gBookList = [SelectedBooks]()
    
    var pIdsArray = [String]()
    var iIdsArray = [String]()
    var gIdsArray = [String]()
    
    var dataList = [String]()
    
    var totalPrice = 0.0
    
    var concernVistingCard : UIImage? = nil
    var noOfVisit = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }
    
    func setData(){
        if(pBookList.count > 0){
            for bookList in pBookList {
                self.dataList.append(bookList.Book_Name + " - ₹" + bookList.RATE)
                totalPrice = totalPrice + (bookList.RATE as NSString).doubleValue
                pIdsArray.append(bookList.book_id)
            }
        }
        
        if(iBookList.count > 0){
            for bookList in iBookList {
                self.dataList.append(bookList.Book_Name + " - ₹" + bookList.RATE)
                totalPrice = totalPrice + (bookList.RATE as NSString).doubleValue
                iIdsArray.append(bookList.book_id)
            }
        }
        
        if(gBookList.count > 0){
            for bookList in gBookList {
                self.dataList.append(bookList.groupName + " - (\(bookList.name))")
                for price in bookList.price{
                    totalPrice = totalPrice + (price as NSString).doubleValue
                }
                
                for value in bookList.value{
                    gIdsArray.append(value)
                }
            }
        }
        
        self.tableView.reloadData()
        
    }
    
    
    
    @IBAction func btnSubmit(_ sender: Any) {
        self.callApiForSchool()
    }
    
    
    @IBAction func backBtnClicked(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLINDENTIFIRES_ID.PRIMARY_VIEW_CEll, for: indexPath) as! PrimaryViewControllerCell
        //let data = self.primaryBookList[indexPath.row]
        cell.bgView.layer.cornerRadius = 5
        cell.bgView.layer.borderWidth = 0.2
        cell.nameTxt.text = self.dataList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.clear
        let titleLabel = UILabel(frame: CGRect(x:10,y: 5 ,width:350,height:50))
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.text  = "Total Price:- ₹\(self.totalPrice)"
        titleLabel.textAlignment = .right
        vw.addSubview(titleLabel)
        return vw
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
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
                        onRefreshDelegate?.onRefreshed()
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
        onRefreshDelegate?.onRefreshed()
        FormViewController.noOfVisit = 0
        let vc = self.storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.HOME_VC) as! HomeViewController
        self.navigationController?.pushViewController(vc,animated: true)
    }

}
extension SelectedBookViewController{
    
    func callApiForSchool(){
        self.view.endEditing(true)
        displaySpinner()
        
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        let schoolID = userdef.string(forKey: SCHOOL_ID)
        params["seller_id"] = user_id as AnyObject
        //params["visit_purpose"] = self.visit_purpose as AnyObject
        //params["visit_purpose_remarks"] = self.remarksTxt.text as AnyObject
        if(schoolID != nil){
            params["old_school_id"] = schoolID as AnyObject
        }else{
            params["old_school_id"] = "" as AnyObject
        }
        
        params["sampling"] = toJSONArray(myArray: pIdsArray) as AnyObject
        params["primary_sampling"] = toJSONArray(myArray:iIdsArray) as AnyObject
        params["group_sampling"] = toJSONArray(myArray:gIdsArray) as AnyObject
        
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
        
        params["order_images"] = "" as AnyObject
        
        print(params)
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
    
    func toJSONArray(myArray:[String]) -> String{
        do {
            // Convert array to JSON data
            let data = try JSONSerialization.data(
                withJSONObject: myArray,
                options: []
            )

            // Convert JSON data to JSON string
            let jsonString: String? = String(data: data, encoding: .utf8)

            // Print JSON string
            return jsonString ?? "[]"
            print(jsonString ?? "JSON string is nil")
        } catch {
            // Handle error
            return "[]"
            print(error.localizedDescription)
        }
    }
}

extension Collection where Iterator.Element == [String] {
  func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
    if let arr = self as? [String],
       let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
       let str = String(data: dat, encoding: String.Encoding.utf8) {
      return str
    }
    return "[]"
  }
}

