//
//  HomeCell.swift
//  FoursquareClone
//
//  Created by Özcan on 20.05.2024.
//

import UIKit

class HomeCell: UITableViewCell {
    
    var label1 = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        setUpCellUIs()
    }
    
    func setUpCellUIs() {
        
        label1.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
//        label1.layer.borderWidth = 0.7
//        label1.text = "kamil"
        addSubview(label1)
        
    }

}
