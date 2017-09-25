//
//  ScheduleViewController.swift
//  BusRomance
//
//  Created by 山口賢登 on 2017/09/25.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    let weekArray = ["月","火","水","木","金"]
    let numOfDays = 5       //1週間の日数
    let cellMargin : CGFloat = 1.0  //セルのマージン。セルのアイテムのマージンも別にあって紛らわしい。アイテムのマージンはゼロに設定し直してる
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //コレクションビューのセクション数　今回は2つに分ける
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //データの個数（DataSourceを設定した場合に必要な項目）
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){   //section:0は曜日を表示
            return numOfDays
        }else{
            return 25        //section:1は日付を表示 　今の時点では適当な数字30日くらいなので30を入れる
        }
    }
    
    //データを返すメソッド（DataSourceを設定した場合に必要な項目）
    //動作確認の為セルの背景を変える。曜日については表示する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //コレクションビューから識別子「CalendarCell」のセルを取得する
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as! TimeCell
        if(indexPath.section == 0){             //曜日表示
            cell.backgroundColor = UIColor.gray
            cell.textLabel.text = weekArray[indexPath.row]
            
        }else{                                  //日付表示
            cell.backgroundColor = UIColor.white
            cell.textLabel.text = ""
        }
        return cell
    }
    
    //セルをクリックしたら呼ばれる
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Num：\(indexPath.row) Section:\(indexPath.section)")
    }
    
    /*
     
     セルのレイアウト設定
     
     */
    //セルサイズの指定（UICollectionViewDelegateFlowLayoutで必須）　横幅いっぱいにセルが広がるようにしたい
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin:CGFloat = 8.0
        let widths:CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin)/CGFloat(numOfDays)
        let heights:CGFloat = widths * 1.25//0.8
        
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
}

