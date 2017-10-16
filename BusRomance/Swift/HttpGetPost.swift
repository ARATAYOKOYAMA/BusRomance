//
//  HttpGetPost.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/10/16.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import Foundation

func httpTransmission(departureBusStop: String,arrivalBusStop: String,Date: String) -> (departureBusStop: String, arrivalBusStop: String, Date: String) {
    //        // 通信用のConfigを生成.
    //        let config:URLSessionConfiguration = URLSessionConfiguration.default
    //        // Sessionを生成.
    //        let session: URLSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    //        // 通信先のURL
    //        let url = ""
    //
    //        // POST用のリクエストを生成.
    //        var request = URLRequest(url: URL(string:url)!)
    //        // POSTのメソッドを指定.2
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

    return (departureBusStop,arrivalBusStop,Date)
    
}
