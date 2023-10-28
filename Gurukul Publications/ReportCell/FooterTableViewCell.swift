//
//  FooterTableViewCell.swift
//  Gurukul Publications
//
//  Created by Ramakant on 09/10/23.
//

import UIKit

class FooterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var etRemarks: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var cameraBtnF: UIButton!
    
    var onSubmit : (()->()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func handleSubmit(_ sender: Any) {
        onSubmit()
    }
    
    
}
