//
//  DetailViewController.swift
//  MedicinePurchaseRecordApp
//
//  Created by 松田珠美 on 2022/12/01.
//
import Foundation
import UIKit
import RealmSwift



class DetailViewController: UIViewController {
    //年度の購入合計額(年度ごとの合計金額が表示されるラベル)
    @IBOutlet weak var yearTotalLabel: UILabel!
    //店ごとの詳細を登録するための「新規作成」ボタン
    @IBOutlet weak var byStoreDetailButton: UIButton!
    //店ごとの詳細を登録するための「新規作成」ボタンを押した時のアクション
    @IBAction func byStoreDetailButton(_ sender: UIButton) {
        transitionToRecordView()
    }
    //店ごとの詳細を表示するためのTableView
    @IBOutlet weak var byStoreDetailTableView: UITableView!
    
    
    //realmの記載
    let realm = try! Realm()
    
    //recorddataをホームクラス内で使用できるようにする
    var byYearDataList: [ByYearDataModel] = []
    
    let byYearDL = ByYearDataModel()
    
    private let recordCell = "recordCell"
    
    ////byStoreDetailTableViewの時刻表示のために必要
    var dateFormat: DateFormatter {
        let dateFormatter = DateFormatter ()
        dateFormatter.dateFormat = "yyyy年MM月dd日　HH時mm分"
        return dateFormatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ラベルの線の幅
        self.yearTotalLabel.layer.borderWidth = 2.0
        //ラベルの線の色
        self.yearTotalLabel.layer.borderColor = UIColor.blue.cgColor
        
        //byStoreDetailTableViewの設定
        byStoreDetailTableView.dataSource = self
        byStoreDetailTableView.delegate = self
        byStoreDetailTableView.tableFooterView = UIView()
        //byStoreDetailTableView.tableHeaderView = UIView()
        
        //register関数でUITableViewCellを登録
        //XibCellをここで使えるようにするために必要(registerを忘れない！！)
        byStoreDetailTableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: recordCell)
        
        byStoreDetailTableView.estimatedRowHeight = 220 //追加
        byStoreDetailTableView.rowHeight = UITableView.automaticDimension //追加
        
        //区切り線を左端まで伸ばす
        byStoreDetailTableView.separatorInset = UIEdgeInsets.zero
        
        //navigation Barのタイトル設定
        self.navigationItem.title = "2022📝"
        //LearnViewControllerに「＜戻る」の表示にするには、遷移元の画面でBarの設定をする
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "戻る",
            style: .plain,
            target: nil,
            action: nil
        )
        

        print("DetailViewConが表示中ですよ！")
    }
    
    //画面表示される直前（毎回）
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        byStoreDetailTableView.reloadData()
    }
    
    //🍎
//    func configure(Data: ByYearDataModel) {
//        byYearDL.recordYear = Data.recordYear
//        byYearDL.storeName = Data.storeName
//        byYearDL.recordDate = Data.recordDate
//    }
    
    
    
    //「新規作成」ボタンが押された時に画面遷移する
    @objc func transitionToRecordView() {
        let storyboard: UIStoryboard = self.storyboard!
        let recordViewController = storyboard.instantiateViewController(withIdentifier: "RecordVC")
        //横に画面遷移(push遷移)
        self.navigationController?.pushViewController(recordViewController, animated: true)
        //注意！！下から遷移→モーダル遷移で実装するとnavigationBarが使えない(戻るボタンやタイトルが表示されない)
    }
}


//TableViewの中身を定義するために必要な設定を行う場所
//購入ごとの記録を表示するbyStoreDetailTableViewの実装
extension DetailViewController: UITableViewDataSource {
    //テーブルの行数指定(各セクションの行数を指定)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //👀.map使用でいい？？？
        let byYearDataDetail = realm.objects(ByYearDataModel.self).map({$0.recordDate})
        return byYearDataDetail.count
//        return 5 //ひとまず５個
    }
    //セルに値をセット
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルの取得(dequeueReusableCell関数)
        //Xibのcellの設定をここで行う
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordTableViewCell
        //Realmデータを全件取得。（初めにlet realm = try! Realm()を書込）
        let byYearDataDetail = realm.objects(ByYearDataModel.self)
        //cellで設定した各テキストボックスに、各DataModelを代入
        //Dateの時は、dateFormatでstringに変換する
        cell.dateField?.text = "記録日: \(dateFormat.string(from: byYearDataDetail[indexPath.row].recordDate))"
        cell.storeField!.text = "店名: \(byYearDataDetail[indexPath.row].storeName)"
        cell.priceField!.text = "支払金額: \(byYearDataDetail[indexPath.row].payMentAmount)円"
        
        //Backで戻るとセルが選択状態のままになっているのを解除
        byStoreDetailTableView.deselectRow(at: indexPath, animated: true)
        
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    //各cellの高さを指定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
//        return 50
    }
    //セルがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let storyboard: UIStoryboard = self.storyboard!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let recordViewController = storyboard.instantiateViewController(withIdentifier: "RecordVC")
        //    let memoData = memoDataList[indexPath.row]
        //    memoDetailViewController.configure(memo: memoData)
        navigationController?.pushViewController(recordViewController, animated: true)
        //        print("didSelectRowAt: \(indexPath)")
        //Reaordから戻った時にcellが選択状態にならないようにする
       tableView.deselectRow(at: indexPath, animated: true)
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //Realmデータを全件取得。（初めにlet realm = try! Realm()を書込）
        let byYearDataDetail = realm.objects(ByYearDataModel.self)
            try! realm.write {
            //cellデータの削除
            realm.delete(byYearDataDetail[indexPath.row])
            }
            //cellの削除
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }

}

