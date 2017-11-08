//
//  ConfigViewController.swift
//  BusRomance
//
//  Created by 山口賢登 on 2017/11/07.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit
import RealmSwift

class ConfigViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var TableTitle = [ ["よく使うバス停", "バス停1", "バス停2", "バス停3"],
                       ["通知設定", "通知", "音", "バイブレーション"],
                       
//                       ["menuTitle03", "menuTitle05", "menuTitle06"],
//                       ["menuTitle04", "menuTitle07"]
                    ]
    
    
    var TableSubtitle = [ ["", "", "", ""],
                          ["", "switch", "switch", "switch"],
//                          ["", "subtitle06", "subtitle07"],
//                          ["", "subtitle08"]
                    ]
    var busStop = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm()
        let results = realm.objects(FrequentlyPlaceObject.self)
        if results.last!.busStop1 != ""{
            let busStop1 = results.last!.busStop1
            TableSubtitle[0][1] = busStop1
        }
        if results.last!.busStop1 != ""{
            let busStop2 = results.last!.busStop2
            TableSubtitle[0][2] = busStop2
        }
        if results.last!.busStop1 != ""{
            let busStop3 = results.last!.busStop3
            TableSubtitle[0][3] = busStop3
        }
    tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableTitle.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableTitle[section].count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        cell.textLabel?.text = TableTitle[indexPath.section][indexPath.row + 1]
        cell.detailTextLabel?.text = TableSubtitle[indexPath.section][indexPath.row + 1]
        if cell.detailTextLabel?.text == "switch"{
            cell.accessoryView = UISwitch()
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TableTitle[section][0]
    }
    
    // Cell が選択された場合
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        busStop = TableTitle[0][indexPath.row+1]
        print("busStop = \(busStop)")
        if TableTitle[1][indexPath.row + 1] != "switch"{
            performSegue(withIdentifier: "toBusStopEntry",sender: nil)
        }
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toBusStopEntry") {
            let subVC: BusStopEntryViewController = (segue.destination as? BusStopEntryViewController)!
            subVC.busStop = busStop
        }
    }
    
    // Cell の高さを6０にする
    func tableView(_ table: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    /*
    //Table Viewのセルの数を指定
    func tableView(_ table: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "cell",
                                             for: indexPath)
        cell.contentView.backgroundColor = UIColor.clear
        // Tag番号 1 で UILabel インスタンスの生成
        let label = cell.viewWithTag(1) as! UILabel
        label.text = (nameArray[indexPath.row] as! String)
        
        return cell
    }
    // Cell の高さを5０にする
    func tableView(_ table: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }*/

}
