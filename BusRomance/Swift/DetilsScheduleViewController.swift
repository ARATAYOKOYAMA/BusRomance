//
//  DetilsScheduleViewController.swift
//  BusRomance
//
//  Created by 山口賢登 on 2017/09/28.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit
import RealmSwift

class SaveScheduleObject:Object{
    @objc dynamic var time = 0
    @objc dynamic var name = ""
    @objc dynamic var place = ""
}
func deleateRealm(){
    let realm = try! Realm()
    let obj = realm.objects(SaveScheduleObject.self)
    try! realm.write {
        realm.delete(obj)//obj削除
    }
    print("dataを削除した")
}

class DetilsScheduleViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var entryButton: UIButton!
    var naviWeekText = ""
    var naviTimeText = 0
    var tappedCell = 0
    
    var loadTime = 0
    var loadName = ""
    var loadPlace = ""
    
    var changeText = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "\(naviWeekText)\(naviTimeText)限"
        if loadName != ""{
            print("いえいえいえい")
            nameTextField.text = loadName
            placeTextField.text = loadPlace
            entryButton.isEnabled = false
            entryButton.alpha = 0.3
            changeText = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  changeText = false
    }
    
    
    @IBAction func entryButton(_ sender: Any) {
        if nameTextField != nil && placeTextField != nil && changeText == false{
            print("上のif分実行")
            let realm = try! Realm()
            let obj = SaveScheduleObject()
            obj.time = tappedCell//Int型に変えたい
            obj.name = nameTextField.text!
            obj.place = placeTextField.text!
            try! realm.write {
                realm.add(obj)
            }
        }else if nameTextField != nil && placeTextField != nil && changeText == true{
            print("下のif分実行")
            let realm = try! Realm()
            var results = realm.objects(SaveScheduleObject.self)
            results = results.sorted(byKeyPath: "time",
                                     ascending: true)
            let obj = SaveScheduleObject()
            obj.time = tappedCell
            obj.name = nameTextField.text!
            obj.place = placeTextField.text!
            for h in results{
                var count = 0
                count += 1
                if loadTime == h.time{
                    print(h.time)
                    try! realm.write {
                        print("削除する前\(results[count])")
                        realm.delete(results[count])
                        realm.add(obj)
                        print("count = \(count)")
                        print("削除した後\(results[count])")
                    }
                }
            }
            //print(results)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nameTextFieldEvent(_ sender: Any) {
        if loadName != (sender as AnyObject).text{
            entryButton.isEnabled = true
            entryButton.alpha = 1.0
            //changeText = true
        }
    }
    
    @IBAction func placeTextFieldEvent(_ sender: Any) {
        if loadPlace != (sender as AnyObject).text{
            entryButton.isEnabled = true
            entryButton.alpha = 1.0
            //changeText = true
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

