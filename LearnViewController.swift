//
//  LearnViewController.swift
//  MedicinePurchaseRecordApp
//
//  Created by 松田珠美 on 2022/11/16.
//

import Foundation
import UIKit

class LearnViewController : UIViewController {
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation Barのタイトル設定
        self.navigationItem.title = "学ぶ📚"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                title:  "戻る",
                style:  .plain,
                target: nil,
                action: nil
            )
        

        print("LearnViewConが表示中")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
    }
    
//    @objc func backButtonPressed(_ sender: UIBarButtonItem) {
//        print("戻るボタンが押されました")
//      }
    
//    @objc func tapAddButton() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let memoDetailViewController = storyboard.instantiateViewController(identifier: "MemoDetailViewController") as!
//            MemoDetailViewController
//        navigationController?.pushViewController(memoDetailViewController, animated: true)
//    }
//
//    func setNavigationBarButton() {
//        let buttonActionSelector: Selector = #selector(tapAddButton)
//        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: buttonActionSelector)
//        navigationItem.rightBarButtonItem = rightBarButton
//    }
    
}
