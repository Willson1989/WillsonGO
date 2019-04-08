//
//  TitleCell.swift
//  Learning
//
//  Created by WillHelen on 2019/3/22.
//  Copyright © 2019年 ZhengYi. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var ageLb: UILabel!
    @IBOutlet weak var genderLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
