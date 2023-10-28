//
//  TeacherTableViewCell.swift
//  Gurukul Publications
//
//  Created by Ramakant on 08/10/23.
//

import UIKit

class TeacherTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTchDetail: UILabel!
    
    
    @IBOutlet weak var etName: UITextField!
    
    
    @IBOutlet weak var etMobile: UITextField!
    
    
    @IBOutlet weak var btnAdd: UIButton!
    
    var onClick : (()->()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func handleAdd(_ sender: UIButton) {
        onClick()
    }
    
    
}
