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
    
    @IBOutlet weak var spreadsheetView: SpreadsheetView!
    
    var topColor:UIColor = UIColor(red:0.000, green:0.000, blue:0.000, alpha:1)
    var bottomColor:UIColor = UIColor(red:0.000, green:0.000, blue:0.000, alpha:1)
    
    let week = ["月","火","水","木","金"]
    var month = ["","","","",""]
    var tues = ["","","","",""]
    var wednes = ["","","","",""]
    var thurs = ["","","","",""]
    var fri = ["","","","",""]
    let time = ["1","2","3","4","5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self
        
        let hairline = 1 / UIScreen.main.scale
        spreadsheetView.intercellSpacing = CGSize(width: hairline, height: hairline)
        spreadsheetView.gridStyle = .solid(width: hairline, color: .lightGray)
        
        spreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        spreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        spreadsheetView.register(TaskCell.self, forCellWithReuseIdentifier: String(describing: TaskCell.self))
        spreadsheetView.register(ChartBarCell.self, forCellWithReuseIdentifier: String(describing: ChartBarCell.self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spreadsheetView.flashScrollIndicators()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        let nowTimeString = getNowClockString()
        var nowTimeInt:Int = Int(nowTimeString)!
        
        if nowTimeInt >= 6 && nowTimeInt <= 15{
            topColor = UIColor(red:0.000, green:0.557, blue:1.000, alpha:1)//朝
            bottomColor = UIColor(red:0.000, green:1.000, blue:1.000, alpha:0)//朝
        }else if nowTimeInt >= 16 && nowTimeInt <= 18{
            topColor = UIColor(red:0.980, green:0.439, blue:0.604, alpha:1)//夕方
            bottomColor = UIColor(red:0.996, green:0.882, blue:0.251, alpha:1)//夕方
        }else if nowTimeInt >= 19 && nowTimeInt <= 24 || nowTimeInt >= 0 && nowTimeInt <= 5{
            topColor = UIColor(red:0.200, green:0.031, blue:0.404, alpha:1)//夜
            bottomColor = UIColor(red:0.108, green:0.442, blue:0.746, alpha:1)//夜
        }
        print(nowTimeString)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func getNowClockString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let now = Date()
        return formatter.string(from: now)
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 6//3 + titles.count * 2 + 5
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 6//2 + 22
    }
    
    //cellのwidth
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if case 0 = column {
            return UIScreen.main.bounds.width/6.0/2.0
        }else{
        return UIScreen.main.bounds.width/6.0 + UIScreen.main.bounds.width/6.0/6/2
        }
    }
    
    //cellのheight
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        if case 0 = row{
            return (UIScreen.main.bounds.height-93.0)/6.0/2.0
        }else{
            return (UIScreen.main.bounds.height-93.0)/6.0 + (UIScreen.main.bounds.height-93.0)/6.0/6.0/2.0
        }
    }
    
    //何行固定するか
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 6
    }
    
    //何列固定するか
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 6
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        switch (indexPath.column, indexPath.row) {
        case (0, 0):
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            //cell.backgroundColor = UIColor.white
            cell.label.text = ""
            cell.gridlines.left = .default
            cell.gridlines.right = .default
            return cell
            //12345限
        case (0,1...5):
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            cell.label.text = time[indexPath.row-1]
            cell.gridlines.left = .default
            cell.gridlines.right = .default
            return cell
        //月火水木金
        case (1...5,0):
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            cell.label.text = week[indexPath.column-1]
            cell.gridlines.left = .default
            cell.gridlines.right = .default
            return cell
            //月曜日の授業
        case (1,1...5):
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            cell.label.text = month[indexPath.row-1]
            cell.gridlines.left = .default
            cell.gridlines.right = .default
            return cell
            //火曜日の授業
        case (2,1...5):
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            cell.label.text = tues[indexPath.row-1]
            cell.gridlines.left = .default
            cell.gridlines.right = .default
            return cell
            //水曜日の授業
        case (3,1...5):
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            cell.label.text = wednes[indexPath.row-1]
            cell.gridlines.left = .default
            cell.gridlines.right = .default
            return cell
            //木曜日の授業
        case (4,1...5):
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            cell.label.text = thurs[indexPath.row-1]
            cell.gridlines.left = .default
            cell.gridlines.right = .default
            return cell
            //金曜日の授業
        case (5,1...5):
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            cell.label.text = fri[indexPath.row-1]
            cell.gridlines.left = .default
            cell.gridlines.right = .default
            return cell
            
        default:
            return nil
        }
    }
    
    /// Delegate
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: (row: \(indexPath.row), column: \(indexPath.column))")
    }
    
    
}


