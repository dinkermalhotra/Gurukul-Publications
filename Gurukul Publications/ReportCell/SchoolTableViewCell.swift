//
//  SchoolTableViewCell.swift
//  Gurukul Publications
//
//  Created by Ramakant on 04/10/23.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {

    @IBOutlet weak var lblvisiNo: UILabel!
    @IBOutlet weak var lblschoolName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDistrict: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblSchM: UILabel!
    @IBOutlet weak var lblSchStg: UILabel!
    @IBOutlet weak var lblSchUpto: UILabel!
    @IBOutlet weak var lblBranches: UILabel!
    @IBOutlet weak var lblPurpose: UILabel!
    @IBOutlet weak var lblRemarks: UILabel!
    @IBOutlet weak var lblConcernPerson: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
