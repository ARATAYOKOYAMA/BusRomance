//
//  BusStopEntryViewController.swift
//  BusRomance
//
//  Created by 山口賢登 on 2017/11/07.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit
import RealmSwift

class BusStopEntryViewController: UIViewController {
    
    @IBOutlet weak var entryPlaceTextField: PickerTextField!
    @IBOutlet weak var entryButton: UIButton!
    var busStop = ""
    var entryedBusStop1 = ""
    var entryedBusStop2 = ""
    var entryedBusStop3 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        entryButton.layer.borderWidth = 4.0 // 枠線の幅
        entryButton.layer.borderColor = UIColor.blue.cgColor // 枠線の色
        entryButton.layer.cornerRadius = 8.0 // 角丸のサイズ
        entryPlaceTextField.setup(dataList: ["バス停を選択してください","はこだて未来大学", "赤川貯水池", "赤川3区", "赤川小学校", "浄水場下", "低区貯水池", "赤川入口", "赤川１丁目ライフプレステージ白ゆり美原前", "赤川通","函館地方気象台前","亀田支所前","富岡","医師会病院前","田家入口","警察署前","五稜郭公園入口","五稜郭","中央病院前","千代台","堀川町","昭和橋","千歳町","新川町","松風町","棒二森屋前","函館駅前"])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func entryButton(_ sender: Any) {
        if entryPlaceTextField.text! != ""{
            let realm = try! Realm()
            let obj = FrequentlyPlaceObject()
            let results = realm.objects(FrequentlyPlaceObject.self)
            for i in results{
                if i.busStop1 != ""{
                    entryedBusStop1 = i.busStop1
                    print("busStop1みつかりました")
                }
                if i.busStop2 != ""{
                    entryedBusStop2 = i.busStop2
                    print("busStop２みつかりました")
                }
                if i.busStop3 != ""{
                    entryedBusStop3 = i.busStop3
                    print("busStop3みつかりました")
                }
            }
            if busStop == "バス停1"{
                obj.busStop1 = entryPlaceTextField.text!
                obj.busStop2 = entryedBusStop2
                obj.busStop3 = entryedBusStop3
            }else if busStop == "バス停2"{
                obj.busStop2 = entryPlaceTextField.text!
                obj.busStop1 = entryedBusStop1
                obj.busStop3 = entryedBusStop3
            }else if busStop == "バス停3"{//バス停3
                obj.busStop3 = entryPlaceTextField.text!
                obj.busStop1 = entryedBusStop1
                obj.busStop2 = entryedBusStop2
            }
            try! realm.write {
                realm.add(obj)
            }
            let resutls = realm.objects(FrequentlyPlaceObject.self)
            print("results = \(results)")
            self.navigationController?.popViewController(animated: true)
        }
    }
}
