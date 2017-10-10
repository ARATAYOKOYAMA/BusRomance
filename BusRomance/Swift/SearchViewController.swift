//
//  SearchViewController.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/10/02.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController{
    
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
    
    @IBAction func seach(_ sender: Any) {
        print(departureTextField.text)
        print(arrivalTextField.text)
        print(dateTextField.text)
    }
    
}
