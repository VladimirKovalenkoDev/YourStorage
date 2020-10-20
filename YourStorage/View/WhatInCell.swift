//
//  WhatInCell.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 19.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit

class WhatInCell: UITableViewCell {

    @IBOutlet weak var thingsName: UILabel!
    @IBOutlet weak var thingsImge: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // thingsImge.layer.cornerRadius = thingsImge.frame.height / 50
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
