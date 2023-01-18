//
//  HomeViewController.swift
//  MedicinePurchaseRecordApp
//
//  Created by 松田珠美 on 2022/11/11.
//

import Foundation
import UIKit
import RealmSwift



class HomeViewController : UIViewController {
    
    //年度表示用のTableView
    @IBOutlet weak var homeTableView: UITableView!
    //「新年度」追加用のボタン
    @IBOutlet weak var addNewYearButton: UIButton!
    //「新年度」追加用ボタン押した時のアクション
    @IBAction func addNewYearButton(_ sender: UIButton) {
        transitionToYearRegisterView()
    }
    //「学ぶ」画面へ遷移するボタン
    @IBOutlet weak var learnButton: UIButton!
    //「学ぶ」ボタンを押した時のアクション
    @IBAction func learnButton(_ sender: UIButton) {
        transitionToLearnView()
    }
    
    //realmの記載
    let realm = try! Realm()
    
//    let detailViewController = DetailViewController()
    var byYearDataList: [ByYearDataModel] = []
    
    
    //HomeTableViewに表示するデータ
//    var yearList = ["2020", "2021", "2022", "2023", "2024"]
    
    private let yearCell = "yearCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //homeTableViewの設定
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.tableFooterView = UIView()
        //register関数でUITableViewCellを登録
        homeTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: yearCell)
        
        
        homeTableView.estimatedRowHeight = 220 //追加
        homeTableView.rowHeight = UITableView.automaticDimension //追加
        
        //区切り線を左端まで伸ばす
        homeTableView.separatorInset = UIEdgeInsets.zero
        
        //navigation Barのタイトル設定
        self.navigationItem.title = "薬の購入記録💊"
        //LearnViewControllerに「＜戻る」の表示にするには、遷移元の画面でBarの設定をする
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "戻る",
            style: .plain,
            target: nil,
            action: nil
        )
        print("HomeViewConが表示されました")
    }
    
    
    
    
    //画面表示される直前（毎回）
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setYearData()
        homeTableView.reloadData()
    }
    
//    func setYearData() {
//        let resultYear = realm.objects(ByYearDataModel.self)
//        byYearDataList = Array(resultYear)
//    }


    //「セルフメディケーション税制について」のセル様ボタンがタップされた際に実行するメソッド
    @objc func transitionToLearnView() {
        let storyboard: UIStoryboard = self.storyboard!
        let learnViewController = storyboard.instantiateViewController(withIdentifier: "LearnVC")
        //横に画面遷移(push遷移)
        self.navigationController?.pushViewController(learnViewController, animated: true)
        //注意！！下から遷移→モーダル遷移で実装するとnavigationBarが使えない(戻るボタンやタイトルが表示されない)
    }
    
    //「新年度の登録」ボタンが押された時に画面遷移する
    @objc func transitionToYearRegisterView() {
        let storyboard: UIStoryboard = self.storyboard!
        let yearRegisterViewController = storyboard.instantiateViewController(withIdentifier: "YearRegisterVC")
        //下から遷移(モーダル遷移)
//        self.navigationController?.pushViewController(learnViewController, animated: true)

        yearRegisterViewController.modalPresentationStyle = .fullScreen
        self.present(yearRegisterViewController, animated: true)
    }
    
    
}

//年度を表示するTableViewの実装
extension HomeViewController: UITableViewDataSource {
    //テーブルの行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Realmデータを全件取得。（初めにlet realm = try! Realm()を書込）
        let byYearData = realm.objects(ByYearDataModel.self).map({$0.recordYear})
        return byYearData.count
//        return 5 //ひとまず５個
    }
    //セルに値をセット
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルの取得(dequeueReusableCell関数)
        //Xibのcellの設定をここで行う
        let cell = tableView.dequeueReusableCell(withIdentifier: "yearCell", for: indexPath) as! HomeTableViewCell
        
        //Realmデータを全件取得。（初めにlet realm = try! Realm()を書込）
        let byYearData = realm.objects(ByYearDataModel.self)
        
        //cellで設定した各テキストボックスに、各DataModelを代入
        cell.yearTF!.text = "年度: \(byYearData[indexPath.row].recordYear)年"
        print("年度: \(byYearData[indexPath.row].recordYear)年")
        //アクセサリに「DisclosureIndicator」を指定する場合
        //[>]←このマーク
//        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        //Backで戻るとセルが選択状態のままになっているのを解除
        tableView.deselectRow(at: indexPath, animated: true)
                
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    //各cellの高さを指定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //セルがタップされた時の処理
    //UItableViewのセルがタップされた際にそのセルのインデックス番号が渡されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
//            let byYearData = byYearDataList[indexPath.row]
//            detailViewController.configure(Data: byYearData)
        navigationController?.pushViewController(detailViewController, animated: true)
        //Detailから戻った時にcellが選択状態にならないようにする
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //Realmデータを全件取得。（初めにlet realm = try! Realm()を書込）
        let byYearData = realm.objects(ByYearDataModel.self)
            try! realm.write {
            //cellデータの削除
            realm.delete(byYearData[indexPath.row])
            }
            //cellの削除(横スライドでDelete)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
