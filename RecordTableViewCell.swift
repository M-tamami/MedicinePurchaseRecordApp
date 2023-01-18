//
//  RecordTableViewCell.swift
//  MedicinePurchaseRecordApp
//
//  Created by 松田珠美 on 2022/12/20.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    //購入店舗名の表示用
    @IBOutlet weak var storeField: UITextField!
    //購入額の表示用
    @IBOutlet weak var priceField: UITextField!
    //入力日の表示用
    @IBOutlet weak var dateField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
