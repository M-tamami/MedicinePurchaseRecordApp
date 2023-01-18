//
//  ByYearDataModel.swift
//  MedicinePurchaseRecordApp
//
//  Created by 松田珠美 on 2022/12/02.
//

import Foundation
import RealmSwift

class ByYearDataModel: Object {
        
    //ID
    @objc dynamic var id: String = UUID().uuidString
    //登録年
    @objc dynamic var recordYear: String = ""
    //登録日時
    @objc dynamic var recordDate: Date = Date()
    //店の名前
    @objc dynamic var storeName: String = ""
    //医薬品名
    @objc dynamic var medicineName: String = ""
    //支払金額
    @objc dynamic var payMentAmount: Int = 0
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //dataモデルの再考必要？
}
