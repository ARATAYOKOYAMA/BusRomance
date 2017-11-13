//
//  HttpGetPost.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/10/16.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import Foundation

func httpTransmission(departureBusStop: String,arrivalBusStop: String, dayTime: String, departureFlag: Int) -> (nextOriginTime: String, nextLocatingTime: String) {
    
            // サーバーからの値を格納する変数
            var nextOriginTime = ""
            var nextLocatingTime = ""
    
            // Sessionを生成.
            let session: URLSession = URLSession.shared
            // 通信先のURL
            let url = "http://localhost:8000/api/v1/getBus/"
    
            // POST用のリクエストを生成.
            var request = URLRequest(url: URL(string:url)!)
            // POSTのメソッドを指定.2
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
            // 送信するデータを生成・リクエストにセット.
            //let postString = "departureBusStop=\(departureBusStop)&arrivalBusStop=\(arrivalBusStop)&dayTime=\(dayTime)&departureFlag=\(departureFlag)"
            //let postString = "departureBusStop=\(departureBusStop)"
            //request.httpBody = postString.data(using: .utf8)
            let  postString : [String: Any] = [
                "departureBusStop": departureBusStop,
                "arrivalBusStop": arrivalBusStop
            ]
    
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: [])
            }catch{
                print(error.localizedDescription)
            }
    
            // リクエストをタスクとして登録
            let task = session.dataTask(with: request, completionHandler: {
                (data:Data? , response:URLResponse? , error:Error?) in
                //通信完了後の処理
                // エラーかどうか
                guard error == nil else {
                    // エラー表示
                    print(error!.localizedDescription)
                    return
                }
    
                // データがあるかどうか
                guard let data = data else {
                    //　データなし
                    print("JSONなし")
                    return
                }

                // 受け取ったJSONデータをパースして格納
                guard let jsonData = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any] else {
                    // 変換失敗
                    print("変換失敗")
                    return
                }
                
                print(jsonData)
                
                // データの解析
                if let resultDataValues = jsonData["times"] as? [[String:Any]],!resultDataValues.isEmpty {
                    // 出発時刻
                    guard let tmpNextOriginTime = resultDataValues[0]["nextOriginTime"]! as? String else {
                        return
                    }
                    // 運行状況
                    guard let tmpNextLocatingTime = resultDataValues[0]["nextLocatingTime"]! as? String else {
                        return
                    }
                    nextOriginTime = tmpNextOriginTime
                    nextLocatingTime = tmpNextLocatingTime
                    print("getpost",nextOriginTime)
                    print("getpost",nextLocatingTime)

                } else {
                    // データなし
                    print("該当データなし")
                }
            })
            // http通信開始
            task.resume()

    return(nextOriginTime,nextLocatingTime)
    
}
