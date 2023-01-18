//
//  MedicinePaymentTableViewCell.swift
//  MedicinePurchaseRecordApp
//
//  Created by 松田珠美 on 2022/12/23.
//

import UIKit

class MedicinePaymentTableViewCell: UITableViewCell {

    //購入医薬品名の表示用
    @IBOutlet weak var medicineField: UITextField!
    //購入医薬品名の購入額の表示用
    @IBOutlet weak var mediPriceField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
