//
//  PartyTableViewCell.swift
//  Gurukul Publications
//
//  Created by Ramakant on 04/10/23.
//

import UIKit

class PartyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblpartyName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDistrict: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblPMob: UILabel!
    @IBOutlet weak var lblPEmail: UILabel!
    @IBOutlet weak var lblPCategory: UILabel!
    @IBOutlet weak var lblPurpose: UILabel!
    @IBOutlet weak var lblRemarks: UILabel!
    @IBOutlet weak var lblConcernPerson: UILabel!
    @IBOutlet weak var lblConcernPersonName: UILabel!
    @IBOutlet weak var lblConcernPersonMobile: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
