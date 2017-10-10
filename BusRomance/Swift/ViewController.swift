//
//  ViewController.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/09/20.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit

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
    var busStop1:String = "はこだて未来大学" //乗車バス停名
    var busStop2:String = "赤川通" //降車バス停名
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        busStopLabel1.text = "\(busStop1)"
        busStopLabel2.text = "\(busStop2)"
        fareLabel.text = "\(fare) 円"
        busRemainLabel1.text = "到着まで約 \(busRem1) 分"
        busRemainLabel2.text = "到着まで約 \(busRem2) 分"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

