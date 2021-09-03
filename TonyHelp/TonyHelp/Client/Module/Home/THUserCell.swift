/*
 @Desc: 用户信息
 @Date: 2021/9/2
 */

import UIKit

class THUserCell: UITableViewCell {

    static let reuse = "user_cell"
    
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        nickname.layer.borderWidth = 0.5
        nickname.layer.borderColor = UIColor.cyan.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
