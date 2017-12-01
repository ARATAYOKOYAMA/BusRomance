//
//  SearchViewController.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/10/02.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, URLSessionDelegate, URLSessionDataDelegate{
    
    // サーバからの結果を保持
    var nextOriginTime = ""
    var arrivalTime = ""
    var nextLocatingTime = ""
    var afterNextOriginTime = ""
    var afterNextLocationTime  = ""
    var cost = ""
    var lineage = ""
    
    let dispatchGroup = DispatchGroup()
    // 直列キュー / attibutes指定なし
    let dispatchQueue = DispatchQueue(label: "queue")
    
    @IBOutlet weak var departureTextField: PickerTextField! //乗車するバス停を入力するtextFeld
    @IBOutlet weak var arrivalTextField: PickerTextField! //降車するバス停を入力するtextFeld
    @IBOutlet weak var dateTextField: PickerDate!
    
    
    // インジケータのインスタンス
    let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "検索"
        // バス停を入力するTextFieldのセットアップ
        departureTextField.setup(dataList: ["選択してください","はこだて未来大学", "赤川貯水池", "赤川3区", "赤川小学校", "浄水場下", "低区貯水池", "赤川入口", "赤川１丁目ライフプレステージ白ゆり美原前", "赤川通","函館地方気象台前"])
        arrivalTextField.setup(dataList: ["選択してください","はこだて未来大学", "赤川貯水池", "赤川3区", "赤川小学校", "浄水場下", "低区貯水池", "赤川入口", "赤川１丁目ライフプレステージ白ゆり美原前", "赤川通","函館地方気象台前"])
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
        
        let tmpDeparture = departureTextField.text!
        let tmpArrival = arrivalTextField.text!
        
        if tmpDeparture != "" && tmpArrival != "" && tmpDeparture != "選択してください" && tmpArrival != "選択してください" && tmpDeparture != tmpArrival{
            
            let object = httpGetPost(departureBusStop: tmpDeparture,arrivalBusStop: tmpArrival, dayTime: searchTargetData.dateTime, departureFlag: searchTargetData.departureFlag)
            
            // UIActivityIndicatorView のスタイルをテンプレートから選択
            self.indicator.activityIndicatorViewStyle = .whiteLarge
            
            // 表示位置
            self.indicator.center = self.view.center
            
            // 色の設定
            self.indicator.color = UIColor.black
            
            // アニメーション停止と同時に隠す設定
            self.indicator.hidesWhenStopped = true
            
            // 画面に追加
            self.view.addSubview(self.indicator)
            
            // 最前面に移動
            self.view.bringSubview(toFront: self.indicator)
            
            // アニメーション開始
            self.indicator.startAnimating()
            
            // 非同期処理を実行
            dispatchGroup.enter()
            dispatchQueue.async(group: dispatchGroup) {
                [weak self] in
                object.httpTransmission({ (str:ResultData?) -> () in
                    self?.nextOriginTime = (str?.nextOriginTime)!
                    self?.nextLocatingTime = (str?.nextLocatingTime)!
                    self?.arrivalTime = (str?.arrivalTime)!
                    self?.afterNextOriginTime = (str?.afterNextOriginTime)!
                    self?.afterNextLocationTime = (str?.afterNextLocationTime)!
                    self?.cost = (str?.cost)!
                    self?.lineage = (str?.lineage)!
                    self?.dispatchGroup.leave()
                })
            }
            
            // 全ての非同期処理完了後にメインスレッドで処理
            dispatchGroup.notify(queue: .main) {
                self.indicator.stopAnimating()
                
                // 検索結果へ遷移
                self.performSegue(withIdentifier: "search_result", sender: nil)
            }
            
            
            
        }else {
            
            var alertMessage = ""
            var alertTitle = "未選択"
            
            if tmpDeparture == "" {
                alertMessage = "乗車するバス停を選択してください"
            }else if tmpArrival == "" {
                alertMessage = "降車するバス停を選択してください"
            }else if tmpDeparture == tmpArrival {
                alertTitle = "エラー"
                alertMessage = "異なるバス停を選択してください"
            }
            
            // アラートを作成
            let alert = UIAlertController(
                title: alertTitle,
                message: alertMessage,
                preferredStyle: .alert)
            
            // アラートにボタンをつける
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            // アラート表示
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    /*
     乗車と降車のバス停名の切り替え
    */
    @IBAction func changeStationName(_ sender: Any) {
        let tmpStationName = departureTextField.text!
        departureTextField.text! = arrivalTextField.text!
        arrivalTextField.text! = tmpStationName
    }
    
 
    /*  遷移内容をチェックして、値渡しとかする */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "search_result" { //Segueのid
            // Detailをインスタンス化
            let secondVc = segue.destination as! SearchResultViewController
            // 値を渡す
            secondVc.departureBusStop = departureTextField.text!
            secondVc.arrivalBusStop = arrivalTextField.text!
            secondVc.nextOriginTime = nextOriginTime
            secondVc.nextLocatingTime = nextLocatingTime
            secondVc.arrivalTime = arrivalTime
            secondVc.cost = cost
            secondVc.lineage = lineage
        }else {
            // どちらでもない遷移
        }
    }
    
}
