//
//  HomeTableViewCell.swift
//  MedicinePurchaseRecordApp
//
//  Created by 松田珠美 on 2023/01/03.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    //登録年度の表示用
    @IBOutlet weak var yearTF: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
