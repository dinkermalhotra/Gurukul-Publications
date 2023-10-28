

import UIKit

class PrimaryViewControllerCell: UITableViewCell {
    
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var priceTxt: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var checkMarkImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //checked = selected
        if selected
        {
            checkMarkImg.isHidden = false
        }
        else
        {
            checkMarkImg.isHidden = true
        }
    }
    
    var checked: Bool! {
        didSet {
            if (self.checked == true) {
                self.checkMarkImg.isHidden = false
            }else{
                self.checkMarkImg.isHidden = true
            }
        }
    }
    
}
