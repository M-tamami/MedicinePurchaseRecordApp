//
//  RecordViewController.swift
//  MedicinePurchaseRecordApp
//
//  Created by 松田珠美 on 2022/12/10.
//

import Foundation
import UIKit
import RealmSwift


class RecordViewController: UIViewController, UITextFieldDelegate {
    //お店の名前を入力用
    @IBOutlet weak var storeNameField: UITextField!
    //薬品名と値段を追加入力するためのボタン
    @IBOutlet weak var medicineAddButton: UIButton!
    //[]
   //「＋医薬品追加」ボタンを押した時の挙動（入力用popover出る予定）
    @IBAction func medicineAddButton(_ sender: UIButton) {
        alertTF()
    }
    //薬品名と値段表示用
    @IBOutlet weak var medicineNameTableView: UITableView!
    
    //入力内容を追加するボタン
    @IBOutlet weak var recordAddButton: UIButton!
    //入力内容を追加するボタンを押した時の挙動
    @IBAction func recordAddButton(_ sender: UIButton) {
        
    }
    //入力内容を削除するボタン
    @IBOutlet weak var recordDeleteButton: UIButton!
    //入力内容を削除するボタンを押した時の挙動
    @IBAction func recordDeleteButton(_ sender: UIButton) {
        
    }
    
    
    
    let realm = try! Realm()
    
    let alert = UIAlertController()
    
    let byYearDataModel = ByYearDataModel()
    //dataをRecordクラス内で使用できるようにする（取得した値を入れる）
    var byYearDataList: [ByYearDataModel] = []
    
    private let mdpayCell = "medipayCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //お店の名前を入力するTextField
        //textField.layer.borderColor = UIColor.lightGray.cgColor
        //textField.layer.borderWidth = 1.0
        
        storeNameField.placeholder = "薬局・ドラッグストア名"
        //medicineNameTableViewの設定
        medicineNameTableView.dataSource = self
        medicineNameTableView.delegate = self
        medicineNameTableView.tableFooterView = UIView()
        //register関数でUITableViewCellを登録
        medicineNameTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        //XibCellをここで使えるようにするために必要(registerを忘れない！！)
        medicineNameTableView.register(UINib(nibName: "MedicinePaymentTableViewCell", bundle: nil), forCellReuseIdentifier: mdpayCell)
        
        //navigation Barのタイトル設定
        self.navigationItem.title = "購入ごとの記録🖊️"
        //LearnViewControllerに「＜戻る」の表示にするには、遷移元の画面でBarの設定をする
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "戻る",
            style: .plain,
            target: nil,
            action: nil
        )
    }
    
    
    //画面表示される直前（毎回）
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        medicineNameTableView.reloadData()
    }

    //UIAlertController を作成する
    func alertTF(){
        //アラートを追加
        let alert = UIAlertController(
            title: "医薬品名・購入額の入力",
            message: "レシートに★マークが印字されている対象医薬品を入力していきます！",
            preferredStyle: .alert)
        //textFieldをアラートコントローラーに追加する
        //1つめのtextField
        alert.addTextField(configurationHandler: {(textField: UITextField) -> Void in
            textField.placeholder = "医薬品名"
        })
        //２つめのtextField
        alert.addTextField(configurationHandler: {(textField: UITextField) -> Void in
            textField.placeholder = "購入額"
        })
        //キャンセルボタンの追加
        alert.addAction(UIAlertAction(title: "キャンセル", style: .default, handler: { (action: UIAlertAction) -> Void in
                print("textField: キャンセル")
        }))

        //OKボタンの追加
        //UIAlertController に追加した TextField には、alert.textFields でアクセスできる。[0]でひとつめの TextField 取得し、その text を取得。
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) -> Void in
            let textField1 = alert.textFields![0] as UITextField
            let textField2 = alert.textFields![1] as UITextField
                print("医薬品名: \(textField1.text ?? "")")
                print("購入額: \(textField2.text ?? "")")
            

        }))
                    
//            //ByYearDataModelをインスタンス化
//            let byYearDataModel = ByYearDataModel()
//            //DataModelにユーザーが入力したTextを保存
//            //Dateは自動入力のため、以下に記載なし
//            byYearDataModel.medicineName = textField1
//            byYearDataModel.payMentAmount = textField2
//            try! realm.write {
//                realm.add(byYearDataModel)
//            }
//
            //👀テキストフィールドに入力された値とデータモデルの関係を考えコード作成
            present(alert,
                    animated: true, completion: nil)
        }
    
}
 

//購入ごとの記録を表示するbyStoreDetailTableViewの実装
extension RecordViewController: UITableViewDataSource {
    //テーブルの行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        let byYearData = realm.objects(ByYearDataModel.self)
//
//        return byYearData.count
        return 5 //ひとまず５個
    }
    //セルに値をセット
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let byYearData = realm.objects(ByYearDataModel.self)
////        //セルの取得(dequeueReusableCell関数)
        let cell = tableView.dequeueReusableCell(withIdentifier: "medipayCell", for: indexPath) as! MedicinePaymentTableViewCell
//
        let textFields = alert.textFields
//        let text1 = textFields![0].text
//        let text2 = textFields![1].text

//
//        try! realm.write {
//            byYearData[indexPath.row].medicineName = text1!
//            byYearData[indexPath.row].payMentAmount = text2!
//        }
        self.medicineNameTableView.reloadData()

//        // UITableViewCellに値をセット(←この実装で合ってる⁉️)
//        //Alert内のLabelに入力したTextをTableViewに表示したい
//        //Realmデータを全件取得。（初めにlet realm = try! Realm()を書込）
//        let recordData = realm.objects(ByYearDataModel.self)
//        //cellで設定した各テキストボックスに、各DataModelを代入
        cell.medicineField!.text = "医薬品名: \(String(describing: textFields![0].text))"
        cell.mediPriceField!.text = " 購入額: \(String(describing: textFields![1].text))円"
        //TableView全体のセルを選択不可にする
        //🍋cellを選択不可
        cell.isUserInteractionEnabled = false
        return cell
    }
}
extension RecordViewController: UITableViewDelegate {
    //各cellの高さを指定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    //セルがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Backで戻るとセルが選択状態のままになっているのを解除
        medicineNameTableView.deselectRow(at: indexPath, animated: true)
    }
}

