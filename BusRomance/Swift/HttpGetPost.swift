//
//  HttpGetPost.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/10/16.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import Foundation

func httpTransmission(departureBusStop: String,arrivalBusStop: String,Date: String) -> (departureBusStop: String, arrivalBusStop: String, Date: String) {
            // Sessionを生成.
            let session: URLSession = URLSession.shared
            // 通信先のURL
            let url = "http://localhost/hoge/index.php"
    
            // POST用のリクエストを生成.
            var request = URLRequest(url: URL(string:url)!)
            // POSTのメソッドを指定.2
            request.httpMethod = "POST"
    
            // 送信するデータを生成・リクエストにセット.
            //let postString = "departureBusStop=\(departureBusStop)&arrivalBusStop=\(arrivalBusStop)&Date=\(Date)"
            let postString = "departureBusStop=\(departureBusStop)"
            request.httpBody = postString.data(using: .utf8)
    
            // リクエストをタスクとして登録
            let task = session.dataTask(with: request, completionHandler: {
                (data:Data? , response:URLResponse? , error:Error?) in
                //通信完了後の処理
                // エラーかどうか
                guard error == nil else {
                    // エラー表示
    
                    return
                }
                
                if data != nil {
                    let hoge = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        print(hoge,"うんち")
                    }
    
//                // 受け取ったJSONの処理
//                guard let data = data else {
//                    //　データなし
//                    print("JSONなし")
//                    return
//                }
//
//                // 受け取ったJSONデータをパースして格納
//                guard let jsonData = try! JSONSerialization.jsonObject(with: data) as? [String:Any] else {
//                    // 変換失敗
//                    print("変換失敗")
//                    return
//                }
//
//                // データの解析
//                if let resultDataValues = jsonData["hogehoge"] as? [String:Any]{
//
//                    // 出発時刻
//                    guard let departureTime = resultDataValues["hoge"] as? String else {
//                        return
//                    }
//                    print(departureTime)
//
//                } else {
//                    // データなし
//                    print("データなし")
//                }
            })
            // http通信開始
            task.resume()

    return (departureBusStop,arrivalBusStop,Date)
    
}
