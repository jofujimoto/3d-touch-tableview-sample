//
//  CustomTableCell.swift
//  ThreeDTouchSample
//
//  Created by 藤本譲 on 2017/05/07.
//  Copyright © 2017年 jofujimoto. All rights reserved.
//

import UIKit

class CustomTableCell: UITableViewCell
{
    @IBOutlet weak var lblTitle: UILabel!
    
    func setData(title: String)
    {
        lblTitle.text = title
    }
}
