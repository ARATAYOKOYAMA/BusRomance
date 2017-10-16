//
//  SearchViewController.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/10/02.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, URLSessionDelegate, URLSessionDataDelegate{
    
    @IBOutlet weak var departureTextField: PickerTextField! //乗車するバス停を入力するtextFeld
    @IBOutlet weak var arrivalTextField: PickerTextField! //降車するバス停を入力するtextFeld
    @IBOutlet weak var dateTextField: PickerDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // バス停を入力するTextFieldのセットアップ
        departureTextField.setup(dataList: ["バス停を選択してください","はこだて未来大学", "赤川貯水池", "赤川3区", "赤川小学校", "浄水場下", "低区貯水池", "赤川入口", "赤川１丁目ライフプレステージ白ゆり美原前", "赤川通","函館地方気象台前"])
        arrivalTextField.setup(dataList: ["バス停を選択してください","札幌", "新小樽", "倶知安", "長万部", "新八雲", "新函館北斗", "木古内", "奥津軽いまつべつ", "新青森"])
        // datepickerのセットアップ
        dateTextField.setup()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     サーバー側へリクエスト
     */
    @IBAction func seach(_ sender: Any) {
        print(departureTextField.text)
        print(arrivalTextField.text)
        print(dateTextField.text)
        
//        // 通信用のConfigを生成.
//        let config:URLSessionConfiguration = URLSessionConfiguration.default
//        // Sessionを生成.
//        let session: URLSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
//        // 通信先のURL
//        let url = ""
//
//        // POST用のリクエストを生成.
//        var request = URLRequest(url: URL(string:url)!)
//        // POSTのメソッドを指定.
//        request.httpMethod = "POST"
//
//        // 送信するデータを生成・リクエストにセット.
//        let postString = "departureBusStop=\(departureTextField.text!)&arrivalBusStop=\(arrivalTextField.text!)&Date=\(dateTextField.text!)"
//        request.httpBody = postString.data(using: .utf8)
//
//        // リクエストをタスクとして登録
//        let task = session.dataTask(with: request, completionHandler: {
//            (data:Data? , response:URLResponse? , error:Error?) in
//            //通信完了後の処理
//            // エラーかどうか
//            guard error == nil else {
//                // エラー表示
//                let alert = UIAlertController(title:"http通信エラー",
//                                              message:error?.localizedDescription,
//                                              preferredStyle:UIAlertControllerStyle.alert)
//
//                // UIに関する処理
//                DispatchQueue.main.async {
//                    self.present(alert, animated: true,completion: nil)
//                }
//
//                return
//            }
//
//            // 受け取ったJSONの処理
//            guard let data = data else {
//                //　データなし
//                print("JSONなし")
//                return
//            }
//
//            // 受け取ったJSONデータをパースして格納
//            guard let jsonData = try! JSONSerialization.jsonObject(with: data) as? [String:Any] else {
//                // 変換失敗
//                print("変換失敗")
//                return
//            }
//
//            // データの解析
//            if let resultDataValues = jsonData["hogehoge"] as? [String:Any]{
//
//                // 出発時刻
//                guard let departureTime = resultDataValues["hoge"] as? String else {
//                    return
//                }
//
//            } else {
//                // データなし
//                print("データなし")
//            }
//        })
//        // http通信開始
//        task.resume()
        
        
    }
 
    /*  遷移内容をチェックして、値渡しとかする */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "search_result" { //Segueのid
            // Detailをインスタンス化
            let secondVc = segue.destination as! SearchResultViewController
            // 値を渡す
            secondVc.departureBusStop = departureTextField.text!
            secondVc.arrivalBusStop = arrivalTextField.text!
            
        }else {
            // どちらでもない遷移
        }
    }
    
}
