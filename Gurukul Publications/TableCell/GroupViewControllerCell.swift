
import UIKit

class ChildCell : UITableViewCell{
    
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var checkMarkImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //self.accessoryType = selected ? .checkmark : .none
        //self.checkBox.isChecked = selected
        
        if selected
        {
            checkMarkImg.isHidden = false
        }
        else
        {
            checkMarkImg.isHidden = true
        }
    }

   
}

class GroupViewControllerCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
