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
    var naviWeekText = ""
    var naviTimeText = 0
    var tappedCell = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "\(naviWeekText)\(naviTimeText)限"
    }
    
    @IBAction func entryButton(_ sender: Any) {
        if nameTextField != nil && placeTextField != nil{
            let realm = try! Realm()
            let obj = SaveScheduleObject()
            obj.time = tappedCell//Int型に変えたい
            obj.name = nameTextField.text!
            obj.place = placeTextField.text!
            try! realm.write {
                realm.add(obj)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
