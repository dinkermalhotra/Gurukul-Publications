

import UIKit

class PrimaryViewControllerCell: UITableViewCell {
    
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var checkMarkImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//
//        if selected {
//            accessoryType = .checkmark
//        } else {
//            accessoryType = .none
//        }
    }
    
}
