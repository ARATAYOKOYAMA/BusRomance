//
//  ScheduleViewController.swift
//  BusRomance
//
//  Created by 山口賢登 on 2017/09/25.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit
import RealmSwift
import SpreadsheetView

class  ScheduleViewController: UIViewController, SpreadsheetViewDataSource, SpreadsheetViewDelegate  {
    
    @IBOutlet weak var weekSpreadsheetView: SpreadsheetView!
    @IBOutlet weak var firstSpreadsheetView: SpreadsheetView!
    @IBOutlet weak var secondSpreadsheetView: SpreadsheetView!
    @IBOutlet weak var thirdSpreadsheetView: SpreadsheetView!
    @IBOutlet weak var fourthSpreadsheetView: SpreadsheetView!
    @IBOutlet weak var fifthSpreadsheetView: SpreadsheetView!
    
    
    let week = ["","月","火","水","木","金"]
    var first = ["1","","","","",""]
    var second = ["2","","","","",""]
    var third = ["3","","","","",""]
    var fourth = ["4","","","","",""]
    var fifth = ["5","","","","",""]
    var tappedTime = 0//タップしたcellの時間
    var tappedWeek = ""//タップしたcellの曜日
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSpreadSheetView()
        readSchedule()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        readSchedule()
        firstSpreadsheetView.reloadData()
        secondSpreadsheetView.reloadData()
        thirdSpreadsheetView.reloadData()
        fourthSpreadsheetView.reloadData()
        fifthSpreadsheetView.reloadData()
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 6
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    //cellのwidth
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if case 0 = column {
            return firstSpreadsheetView.bounds.width/6.0/2.0
        }else{
            return firstSpreadsheetView.bounds.width/6.0 + firstSpreadsheetView.bounds.width/6.0/6/2
        }
    }
    
    //cellのheight
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        if spreadsheetView.tag == 0{
            return weekSpreadsheetView.bounds.height-1.0
        }else{
            return firstSpreadsheetView.bounds.height-1.0
        }
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 0
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 0
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
        cell.gridlines.left = .default
        cell.gridlines.right = .default
        switch (indexPath.column, indexPath.row, spreadsheetView.tag) {
        case (0...5, 0, 0):
            cell.label.text = week[indexPath.column]
            noneGridline(indexPath.column, cell)
            return cell
        case (0...5, 0, 1):
            cell.label.text = first[indexPath.column]
            noneGridline(indexPath.column, cell)
            return cell
        case (0...5, 0, 2):
            cell.label.text = second[indexPath.column]
            noneGridline(indexPath.column, cell)
            return cell
        case (0...5, 0, 3):
            cell.label.text = third[indexPath.column]
            noneGridline(indexPath.column, cell)
            return cell
        case (0...5, 0, 4):
            cell.label.text = fourth[indexPath.column]
            noneGridline(indexPath.column, cell)
            return cell
        case (0...5, 0, 5):
            cell.label.text = fifth[indexPath.column]
            noneGridline(indexPath.column, cell)
            return cell
        default:
            return nil
        }
    }
    
    func setUpSpreadsheetView(_ spreadsheetView:SpreadsheetView){
        let hairline = 1 / UIScreen.main.scale
        spreadsheetView.intercellSpacing = CGSize(width: hairline, height: hairline)
        spreadsheetView.gridStyle = .solid(width: hairline, color: .lightGray)
        spreadsheetView.layer.cornerRadius = 14
        spreadsheetView.layer.masksToBounds = true
    }
    func noneGridline(_ indexPathColumn: Int, _ cell:Cell){
        if indexPathColumn == 0{
            cell.gridlines.left = .none
        }else if indexPathColumn == 5{
            cell.gridlines.right = .none
        }else{
            cell.gridlines.left = .default
            cell.gridlines.right = .default
        }
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: (row: \(indexPath.row), column: \(indexPath.column))")
        tappedWeek = week[indexPath.column]
        tappedTime = spreadsheetView.tag
        self.performSegue(withIdentifier: "toDetilsSchedule", sender: nil)
    }
    
    /*  遷移内容をチェックして、値渡しとかする */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetilsSchedule" {
            let secondVc = segue.destination as! DetilsScheduleViewController
            secondVc.naviWeekText = tappedWeek
            secondVc.naviTimeText = tappedTime
        }
    }
    
    func setUpSpreadSheetView(){
        weekSpreadsheetView.dataSource = self
        weekSpreadsheetView.delegate = self
        firstSpreadsheetView.dataSource = self
        firstSpreadsheetView.delegate = self
        secondSpreadsheetView.dataSource = self
        secondSpreadsheetView.delegate = self
        thirdSpreadsheetView.dataSource = self
        thirdSpreadsheetView.delegate = self
        fourthSpreadsheetView.dataSource = self
        fourthSpreadsheetView.delegate = self
        fifthSpreadsheetView.dataSource = self
        fifthSpreadsheetView.delegate = self
        setUpSpreadsheetView(weekSpreadsheetView)
        weekSpreadsheetView.layer.cornerRadius = 7
        setUpSpreadsheetView(firstSpreadsheetView)
        setUpSpreadsheetView(secondSpreadsheetView)
        setUpSpreadsheetView(thirdSpreadsheetView)
        setUpSpreadsheetView(fourthSpreadsheetView)
        setUpSpreadsheetView(fifthSpreadsheetView)
        weekSpreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        weekSpreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        firstSpreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        firstSpreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        secondSpreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        secondSpreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        thirdSpreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        thirdSpreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        fourthSpreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        fourthSpreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        fifthSpreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        fifthSpreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
    }
    
    func readSchedule(){
        let realm = try! Realm()
        var results = realm.objects(SaveScheduleObject.self)
        results = results.sorted(byKeyPath: "time",
                                 ascending: true)
        print("results = \(results)")
        for i in 0..<results.count{
            if results[i].time >= 11 && results[i].time <= 15{
                let time = results[i].time - 10
                distributeWeek(time,"\(results[i].name)",1)
            }else if results[i].time >= 21 && results[i].time <= 25{
                let time = results[i].time - 20
                distributeWeek(time,"\(results[i].name)",2)
            }else if results[i].time >= 31 && results[i].time <= 35{
                let time = results[i].time - 30
                distributeWeek(time,"\(results[i].name)",3)
            }else if results[i].time >= 41 && results[i].time <= 45{
                let time = results[i].time - 40
                distributeWeek(time,"\(results[i].name)",4)
            }else if results[i].time >= 51 && results[i].time <= 55{
                let time = results[i].time - 50
                distributeWeek(time,"\(results[i].name)",5)
            }
        }
        print("first = \(first)")
        print("second = \(second)")
        print("third = \(third)")
        print("fourth = \(fourth)")
        print("fifth = \(fifth)")
    }
    
    func distributeWeek(_ time:Int,_ name:String,_ value:Int){
        switch time{
        case 1:
            first.remove(at: value)
            first.insert("\(name)", at: value)
        case 2:
            second.remove(at: value)
            second.insert("\(name)", at: value)
        case 3:
            third.remove(at: value)
            third.insert("\(name)", at: value)
        case 4:
            fourth.remove(at: value)
            fourth.insert("\(name)", at: value)
        case 5:
            fifth.remove(at: value)
            fifth.insert("\(name)", at: value)
        default:
            break
        }
    }
}


