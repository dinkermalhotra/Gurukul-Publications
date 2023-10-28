//
//  SelectedBookVC.swift
//  Gurukul Publications
//
//  Created by Ramakant on 01/10/23.
//

import UIKit
import ToastViewSwift

class PartySelectedBookVC : UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
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
        self.callApiForParty()
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
                    if firstViewController is AddPartyViewController {
                        AddPartyViewController.noOfVisit = self.noOfVisit - 1
                        self.navigationController?.popToViewController(firstViewController, animated: true)
                        break
                    }
                }
                
//                self.navigationController?.pushViewController(vc,animated: true)
            }else{
                
                self.pushToHomeVC()
            }
           
           
        }, onCancel: {
            AddPartyViewController.noOfVisit = 0
            self.pushToHomeVC()
        })
    }
    
    func pushToHomeVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: STORYBOARDS_ID.HOME_VC) as! HomeViewController
        self.navigationController?.pushViewController(vc,animated: true)
    }

}
extension PartySelectedBookVC{
    
    func callApiForParty(){
        self.view.endEditing(true)
        displaySpinner()
        
        let userdef = UserDefaults.standard
        let user_id = userdef.string(forKey: user_Id)
        
        params["seller_id"] = user_id as AnyObject
//        params["visit_purpose"] = self.visit_purpose as AnyObject
//        params["visit_purpose_remarks"] = self.remarksTxt.text as AnyObject
        //params["party_id"] = "" as AnyObject
        
        params["p_sampling_month"] = "" as AnyObject
        
        params["p_sampling"] = toJSONArray(myArray: pIdsArray) as AnyObject
        params["p_primary_sampling"] = toJSONArray(myArray:iIdsArray) as AnyObject
        params["p_group_sampling"] = toJSONArray(myArray:gIdsArray) as AnyObject
        
        params["p_payment_mode"] = "" as AnyObject
        params["p_cheque_no"] = "" as AnyObject
        params["p_payment_price"] = "" as AnyObject
        params["p_not_received_reason"] = "" as AnyObject
        params["p_cheque_price"] = "" as AnyObject
        params["p_otp_email"] = "" as AnyObject
        
        var imageParams : [String : UIImage?] = [:]
        if (self.concernVistingCard == nil){
            params["p_concern_visiting_card"] = "" as AnyObject
        }else{
            imageParams["p_concern_visiting_card"] = self.concernVistingCard
        }
        
        params["p_order_images"] = "" as AnyObject
        
        print(params)
        WebServices.callsendDataImageAPI(URLName: API_NAME.shared.base_url + API_NAME.shared.addPartyInfo, param:params, arrImage: imageParams) { response,message  in
            removeSpinner()
            print(response)
            if(response != nil){
                let userStatus = response?[WebConstants.STATUS] as? Bool ?? true
                let error_message = response?[WebConstants.MESSAGE] as? String ?? ""
                if(userStatus){
                    showToast(message: error_message)
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
