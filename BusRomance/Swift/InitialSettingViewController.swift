//
//  InitialSettingViewController.swift
//  BusRomance
//
//  Created by 山口賢登 on 2017/10/17.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit

class InitialSettingViewController: UIViewController {

    
    @IBOutlet weak var entryPlaceTextField: PickerTextField!
    @IBOutlet weak var entryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryButton.layer.borderWidth = 4.0 // 枠線の幅
        entryButton.layer.borderColor = UIColor.white.cgColor // 枠線の色
        entryButton.layer.cornerRadius = 8.0 // 角丸のサイズ
          entryPlaceTextField.setup(dataList: ["バス停を選択してください","はこだて未来大学", "赤川貯水池", "赤川3区", "赤川小学校", "浄水場下", "低区貯水池", "赤川入口", "赤川１丁目ライフプレステージ白ゆり美原前", "赤川通","函館地方気象台前"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func entryButton(_ sender: Any) {
//        if entryPlaceTextField.text! != ""{
//            performSegue(withIdentifier: "toHome",sender: nil)
//        }
    }
    

}
