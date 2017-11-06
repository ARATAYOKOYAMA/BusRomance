//
//  SearchViewController.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/10/02.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit


var departureBusStop = ""
var arrivalBusStop = ""
var Datea = ""

class SearchViewController: UIViewController, URLSessionDelegate, URLSessionDataDelegate{
    
    @IBOutlet weak var departureTextField: PickerTextField! //乗車するバス停を入力するtextFeld
    @IBOutlet weak var arrivalTextField: PickerTextField! //降車するバス停を入力するtextFeld
    @IBOutlet weak var dateTextField: PickerDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // バス停を入力するTextFieldのセットアップ
        departureTextField.setup(dataList: ["バス停を選択してください","はこだて未来大学", "赤川貯水池", "赤川3区", "赤川小学校", "浄水場下", "低区貯水池", "赤川入口", "赤川１丁目ライフプレステージ白ゆり美原前", "赤川通","函館地方気象台前"])
        arrivalTextField.setup(dataList: ["バス停を選択してください","はこだて未来大学", "赤川貯水池", "赤川3区", "赤川小学校", "浄水場下", "低区貯水池", "赤川入口", "赤川１丁目ライフプレステージ白ゆり美原前", "赤川通","函館地方気象台前"])
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

        let httpResult = httpTransmission(departureBusStop: departureTextField.text!, arrivalBusStop: arrivalTextField.text!, Date: dateTextField.text!)
        
        // グローバル関数に代入
        departureBusStop = httpResult.departureBusStop
        arrivalBusStop = httpResult.arrivalBusStop
        Datea = httpResult.Date
       
        // 検索結果へ遷移
        performSegue(withIdentifier: "search_result", sender: nil)
    }
    
 
    /*  遷移内容をチェックして、値渡しとかする */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "search_result" { //Segueのid
            // Detailをインスタンス化
            let secondVc = segue.destination as! SearchResultViewController
            // 値を渡す
            secondVc.departureBusStop = departureBusStop
            secondVc.arrivalBusStop = arrivalBusStop
            
        }else {
            // どちらでもない遷移
        }
    }
    
}
