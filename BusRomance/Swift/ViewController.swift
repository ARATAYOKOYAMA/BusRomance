//
//  ViewController.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/09/20.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var busStopLabel1: UILabel!
    @IBOutlet weak var busStopLabel2: UILabel!
    @IBOutlet weak var fareLabel: UILabel!
    @IBOutlet weak var busTimeLabel1: UILabel!
    @IBOutlet weak var busTimeLabel2: UILabel!
    @IBOutlet weak var busRemainLabel1: UILabel!
    @IBOutlet weak var busRemainLabel2: UILabel!

    
    var fare:Int = 190 //乗車運賃
    var busRem1:Int = 3 //乗車までの時間1
    var busRem2:Int = 65 //乗車までの時間2
    var busStop1:String = "乗車バス停名" //乗車バス停名
    var busStop2:String = "はこだて未来大学" //降車バス停名
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //グラデーションの開始色(朝)
        let topColor = UIColor(red:0.000, green:0.557, blue:1.000, alpha:1)
        
        //グラデーションの終了色(朝)
        let bottomColor = UIColor(red:0.000, green:1.000, blue:1.000, alpha:0.0)
        
        //let topColor = UIColor(red:0.980, green:0.439, blue:0.604, alpha:1)//夕方
        
        //let bottomColor = UIColor(red:0.996, green:0.882, blue:0.251, alpha:1)//夕方
        
        // let topColor = UIColor(red:0.200, green:0.031, blue:0.404, alpha:1)//夜
        
        // let bottomColor = UIColor(red:0.108, green:0.442, blue:0.746, alpha:1)//夜
        
        //グラデーションの色を配列で管理
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        
        //グラデーションレイヤーを作成
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        //グラデーションの色をレイヤーに割り当てる
        gradientLayer.colors = gradientColors
        //グラデーションレイヤーをスクリーンサイズにする
        gradientLayer.frame = self.view.bounds
        
        //グラデーションレイヤーをビューの一番下に配置
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        busStopLabel1.text = "\(busStop1)"
        busStopLabel2.text = "\(busStop2)"
        fareLabel.text = "\(fare) 円"
        busRemainLabel1.text = "到着まで約 \(busRem1) 分"
        busRemainLabel2.text = "到着まで約 \(busRem2) 分"
        let realm = try! Realm()
        let getOnBusStop = realm.objects(FrequentlyPlaceObject.self)
        busStopLabel1.text = "\(getOnBusStop.last!.busStop)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

