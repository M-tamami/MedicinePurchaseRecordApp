//
//  YearRegisterViewController.swift
//  MedicinePurchaseRecordApp
//
//  Created by 松田珠美 on 2022/11/24.
//

import Foundation
import UIKit
import RealmSwift

class YearRegisterViewController: UIViewController {
    
    //年度入力用
    @IBOutlet weak var addYearTextField: UITextField!
    
    //年度追加のボタン接続
    @IBOutlet weak var addYearButton: UIButton!
    //年度追加のボタン押した時のアクション
    @IBAction func addYearButton(_ sender: UIButton) {
        //byYearDataModelをインスタンス化
        let byYearDataModel = ByYearDataModel()
        //DataModelにユーザーが入力したTextを保存
        byYearDataModel.recordYear = addYearTextField.text!
        try! realm.write {
            realm.add(byYearDataModel)
        }
        
        //ボタンを押してデータを追加した後、テキストフィールドに空文字を代入してリセットする
        addYearTextField.text = ""
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    //realmの記載
    let realm = try! Realm()
    
    
    // ピッカーview
    var yearPickerView: UIPickerView = UIPickerView()
    
    var yearList: [String] = ["2020", "2021", "2022", "2023", "2024", "2025"] //考え中
//    var yearList: [String] = [""]
    //↑過去ー未来５年ずつ表示するように実装予定
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        // YearPickerViewの設定
        
        yearPickerView.delegate = self
        yearPickerView.dataSource = self
        

        //TextFieldタップした時PickerViewが表示される
        addYearTextField.inputView = yearPickerView
        //プレースホルダーを表示
        addYearTextField.placeholder = "ここをタップ！"
        //プレースホルダー別の方法？
        //TextFieldに文字を表示し、色をブルーにする
//        addYearTextField.attributedPlaceholder = NSAttributedString(string: "ここをタップ！", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
        
        

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        
        //buttonの文字変更
        addYearButton.titleLabel?.adjustsFontSizeToFitWidth = true

        // UIPickerViewの1列目の初期値を「2022」に設定
        yearPickerView.selectRow(2, inComponent: 0, animated: false)
        }
    
    @objc func dismissKeyboard() {
            self.view.endEditing(true)
    }
    

}


//「新年度を追加」するためのPickerViewの実装
extension YearRegisterViewController: UIPickerViewDataSource {
    //UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearList.count
    }
        
}
extension YearRegisterViewController: UIPickerViewDelegate {
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                titleForRow row: Int,
                forComponent component: Int) -> String? {
            
        return yearList[row]
    }
    // UIPickerViewのRowが選択された時の挙動(Pickerで選択した値がTextFieldに表示される)
    func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
        self.addYearTextField.text = yearList[row]
        
        //↑選択された「yearList」が「homeTableViewCell」にデータが渡される仕様を実装？？？
        
    }
}


