//
//  HttpGetPost.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/10/16.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import Foundation

struct ResultData {
    // サーバーからの値を格納する変数
    let nextOriginTime: String
    let arrivalTime : String
    let nextLocatingTime: String
    let afterNextOriginTime : String
    let afterNextLocationTime : String
    let cost : String
    let lineage : String
}

func getNowTime()->String{
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd' 'HH:mm"
    let nowTime = dateFormatter.string(from: date)
    return nowTime
}



class httpGetPost {
    
    let departureBusStop: String
    let arrivalBusStop : String
    let dayTime: String
    let departureFlag: Int
    
    
    // Sessionを生成.
    let session: URLSession = URLSession.shared
    // 通信先のURL
    let url: String
    
    
    init(departureBusStop: String, arrivalBusStop : String, dayTime: String, departureFlag: Int) {
        self.departureBusStop = departureBusStop
        self.arrivalBusStop = arrivalBusStop
        self.dayTime = dayTime
        self.departureFlag = departureFlag
        //self.url = "http://localhost:8000/api/v1/getBus/"
        self.url = "https://busproject-190313.appspot.com/api/v1/getBus/"
    }
    
    
    func httpTransmission(_ after:@escaping (ResultData) -> ()){
        // POST用のリクエストを生成.
        var request = URLRequest(url: URL(string:self.url)!)
        // POSTのメソッドを指定.2
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let  postString : [String: Any] = [
            "departureBusStop": self.departureBusStop,
            "arrivalBusStop": self.arrivalBusStop,
            "dayTime": dayTime
        ]
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        }catch{
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
           
            let str = String(data: data, encoding: .utf8)
            print(str ?? "data not in UTF-8")
            
            //print(data)
            
            // 受け取ったJSONデータをパースして格納
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any] else {
                // 変換失敗
                print("変換失敗")
                return
            }


            // データの解析
            if let resultDataValues = jsonData?["busDatas"] as? [[String:Any]],!resultDataValues.isEmpty {
                // 最早の出発時刻
                guard let tmpNextOriginTime = resultDataValues[0]["nextOriginTime"]! as? String else {
                    return
                }
                
                // 最早の到着時刻
                guard let tmpArrivalTime = resultDataValues[0]["arrivalTime"]! as? String else {
                    return
                }
                
                // 最早の運行状況
                guard let tmpNextLocatingTime = resultDataValues[0]["nextLocatingTime"]! as? String else {
                    return
                }
                
                // 最早の次の出発時刻
                guard let tmpAfterNextOriginTime = resultDataValues[0]["afterNextOriginTime"]! as? String else {
                    return
                }
                
                // 最早の次の到着時刻
                
                // 最早の次の運行状況
                guard let tmpAfterNextLocationTime = resultDataValues[0]["afterNextLocationTime"]! as? String else {
                    return
                }
                
                // 料金
                guard let tmpCost = resultDataValues[0]["cost"]! as? String else {
                    return
                }
                
                // 系統
                guard let tmpLineage = resultDataValues[0]["lineage"]! as? String else {
                    return
                }

                let resultData = ResultData(nextOriginTime: tmpNextOriginTime, arrivalTime : tmpArrivalTime, nextLocatingTime: tmpNextLocatingTime, afterNextOriginTime : tmpAfterNextOriginTime,
                                            afterNextLocationTime : tmpAfterNextLocationTime, cost : tmpCost, lineage : tmpLineage)
                after(resultData)


            } else {
                // データなし
                print("該当データなし")
            }
        })
        // http通信開始
        task.resume()
    }
}

