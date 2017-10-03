//
//  ScheduleViewController.swift
//  BusRomance
//
//  Created by 山口賢登 on 2017/09/25.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit
import RealmSwift

class ScheduleViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let weekArray = ["","月","火","水","木","金"]
    var schedule:[String]=["1","","","","","","2","","","","","","3","","","","","","4","","","","","","5","","","","","",]
    let numOfDays = 6       //1週間の日数 + 時間割の枠
    let cellMargin : CGFloat = 1.0  //セルのマージン。セルのアイテムのマージンも別にあって紛らわしい。アイテムのマージンはゼロに設定し直してる
    var cellHeight:CGFloat = 0.0
    var cellWidth:CGFloat = 0.0
    var tapCell = 0
    var timeTitle = 0
    var weekTitle = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
       self.navigationItem.title = "時間割"
        //deleateRealm()
        let realm = try! Realm()
        var results = realm.objects(SaveScheduleObject.self)
        results = results.sorted(byKeyPath: "time",
                                 ascending: true)
        schedule = []
        var flag = 0
        print("\(results)")
        for i in 0...29{
            for h in results{
                if i == h.time{
                    schedule.append(h.name+"\n"+h.place)
                    flag = 1
                }
            }
            if flag == 0{
                schedule.append("")
            }
            flag = 0
        }
        print(schedule)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "時間割"
        let realm = try! Realm()
        var results = realm.objects(SaveScheduleObject.self)
        results = results.sorted(byKeyPath: "time",
                                 ascending: true)
        schedule = []
        var flag = 0
        print("\(results)")
        for i in 0...29{
            for h in results{
                if i == h.time{
                    schedule.append(h.name+"\n"+h.place)
                    flag = 1
                }
            }
            if flag == 0{
                schedule.append("")
            }
            flag = 0
        }
        print(schedule)
        myCollectionView.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //データの個数（DataSourceを設定した場合に必要な項目）
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){   //section:0は曜日を表示
            return numOfDays
        }else{
            return 30
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as! TimeCell
        if(indexPath.section == 0){             //曜日表示
            cell.backgroundColor = UIColor.lightGray
            cell.textLabel.text = weekArray[indexPath.row]
            cell.textLabel.center = CGPoint(x:cellWidth/2,y:cellHeight/2)
            cell.textLabel.font = UIFont.systemFont(ofSize: 20)
            
        }else{
            cell.backgroundColor = UIColor.white
            cell.textLabel.text = schedule[indexPath.row]
            cell.textLabel.center = CGPoint(x:cellWidth/2,y:cellHeight/2)
            cell.textLabel.font = UIFont.systemFont(ofSize: 20)
        }
        return cell
    }
    
    //セルをクリックしたら呼ばれる
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Num：\(indexPath.row) Section:\(indexPath.section)")
        if indexPath.section == 1 && indexPath.row != 0 && indexPath.row != 6 && indexPath.row != 12 && indexPath.row != 18 && indexPath.row != 24 && indexPath.row != 30{
            tapCell = indexPath.row
            if tapCell >= 1 && tapCell <= 5{
                timeTitle = 1
            }else if tapCell >= 7 && tapCell <= 11{
                timeTitle = 2
            }else if tapCell >= 13 && tapCell <= 17{
                timeTitle = 3
            }else if tapCell >= 19 && tapCell <= 23{
                timeTitle = 4
            }else if tapCell >= 25 && tapCell <= 29{
                timeTitle = 5
            }
            if tapCell==1||tapCell==7||tapCell==13||tapCell==19||tapCell==25{
                weekTitle = "月曜日"
            }else if tapCell==2||tapCell==8||tapCell==14||tapCell==20||tapCell==26{
                weekTitle = "火曜日"
            }else if tapCell==3||tapCell==9||tapCell==15||tapCell==21||tapCell==27{
                weekTitle = "水曜日"
            }else if tapCell==4||tapCell==10||tapCell==16||tapCell==22||tapCell==28{
                weekTitle = "木曜日"
            }else if tapCell==5||tapCell==11||tapCell==17||tapCell==23||tapCell==29{
                weekTitle = "金曜日"
            }
            performSegue(withIdentifier: "toDetilsSchedule",sender: nil)
        }
    }
    //セルサイズの指定（UICollectionViewDelegateFlowLayoutで必須）　横幅いっぱいにセルが広がるようにしたい
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin:CGFloat = 8.0
        let widths:CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin)/CGFloat(numOfDays)
        let heights:CGFloat = widths * 1.5
        cellHeight = heights
        cellWidth = widths
        return CGSize(width:widths,height:heights)
    }
    
    //セルのアイテムのマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0.0 , 0.0 , 0.0 , 0.0 )  //マージン(top , left , bottom , right)
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    //セルの垂直方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toDetilsSchedule") {
            let detilsVC: DetilsScheduleViewController = (segue.destination as? DetilsScheduleViewController)!
            detilsVC.naviWeekText = "\(weekTitle)"
            detilsVC.naviTimeText = timeTitle
            detilsVC.tappedCell = tapCell
        }
    }
}

