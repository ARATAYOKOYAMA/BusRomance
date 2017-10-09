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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // バス停を入力するTextFieldのセットアップ
        departureTextField.setup(dataList: ["札幌", "新小樽", "倶知安", "長万部", "新八雲", "新函館北斗", "木古内", "奥津軽いまつべつ", "新青森"])
        arrivalTextField.setup(dataList: ["札幌", "新小樽", "倶知安", "長万部", "新八雲", "新函館北斗", "木古内", "奥津軽いまつべつ", "新青森"])
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
