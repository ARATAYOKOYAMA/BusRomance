//
//  DetilsScheduleViewController.swift
//  BusRomance
//
//  Created by 山口賢登 on 2017/09/28.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit
import RealmSwift
/*
class SaveScheduleObject:Object{
    @objc dynamic var schedule = ["1","","","","","","2","","","","","","3","","","","","","4","","","","","","5","","","","","",]
}*/

class DetilsScheduleViewController: UIViewController {
    
    var naviText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "\(naviText)"
       /* let realm = try! Realm()
        let results = realm.objects(SaveScheduleObject.self)
        let result = results.last
        print("\(result?.schedule))")*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    
}
