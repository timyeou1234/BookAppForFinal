//
//  BookDetailTableViewCell.swift
//  BookApp
//
//  Created by YeouTimothy on 2016/7/22.
//  Copyright © 2016年 YeouTimothy. All rights reserved.
//

import UIKit

class BookDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var corpmeLable: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
