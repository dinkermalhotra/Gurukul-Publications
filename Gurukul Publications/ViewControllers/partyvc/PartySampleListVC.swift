//
//  PartySampleListVC.swift
//  Gurukul Publications
//
//  Created by Ramakant on 01/10/23.
//

import UIKit

class PartySampleListVC: UIViewController{
    
    @IBOutlet weak var primaryView: UIView!
    @IBOutlet weak var individualView: UIView!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchTxt: UITextField!
    
    var pBookList = [PrimarySchoolData]()
    var iBookList = [PrimarySchoolData]()
    var gBookList = [SelectedBooks]()
    
    var params : [String:AnyObject] = [:]
    var concernVistingCard : UIImage? = nil
    var noOfVisit = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
      
    }
    
    func setupUI(){
        primarySelectedBook = self
        individaulSelectedBook = self
        groupSelectedBook = self
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
        
        if(pBookList.count > 0 || iBookList.count > 0 || gBookList.count > 0){
            if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PartySelectedBookVC") as? PartySelectedBookVC{
                nextVC.pBookList = self.pBookList
                nextVC.iBookList = self.iBookList
                nextVC.gBookList = self.gBookList
                nextVC.params = self.params
                nextVC.concernVistingCard = self.concernVistingCard
                nextVC.noOfVisit = self.noOfVisit
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }else{
            alertModule(onVC: self, title: Alert, msg: "Please select atleast one book")
        }
       
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
extension PartySampleListVC: PrimarySelectedBook,IndividaulSelectedBook,GroupSelectedBook {
    func onGrpSelectedBook(gBookList: [SelectedBooks]) {
        print("delegateGrp",iBookList)
        self.gBookList = gBookList
    }
    
    func onIndSelectedBook(iBookList: [PrimarySchoolData]) {
        print("delegateInd",iBookList)
        self.iBookList = iBookList
    }
    
    func onSelectedBook(pBookList: [PrimarySchoolData]) {
        print("delegatepr",pBookList)
        self.pBookList = pBookList
    }
}
    
