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
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var busTimeLabel1: UILabel!
    @IBOutlet weak var busTimeLabel2: UILabel!
    @IBOutlet weak var busRemainLabel1: UILabel!
    @IBOutlet weak var busRemainLabel2: UILabel!
    @IBOutlet weak var hayaLabel: UILabel!
    @IBOutlet weak var tsugiLabel: UILabel!
    
    //var cost:Int = 0 //乗車運賃
    //var busRem1:Int = 3 //乗車までの時間1
    //var busRem2:Int = 65 //乗車までの時間2

    var busStop1:String = ""//"はこだて未来大学" //乗車バス停名
    var busStop2:String = "はこだて未来大学" //降車バス停名
    var topColor:UIColor = UIColor(red:0.000, green:0.000, blue:0.000, alpha:1)
    var bottomColor:UIColor = UIColor(red:0.000, green:0.000, blue:0.000, alpha:1)
    
    var nextOriginTime = ""
    var nextLocatingTime = ""
    var afterNextOriginTime = ""
    var afterNextLocationTime = ""
    var cost = ""
    
    
    //ページ遷移系
    @IBOutlet var firstView: UIView!
    var tapEndPosX:CGFloat = 0
    var tapEndPosY:CGFloat = 0
    
    
    // インジケータのインスタンス
    let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //deleateRealm2()
        //busStopLabel1.text = "\(busStop1)"
        busStopLabel2.text = "\(busStop2)"
      //  costLabel.text = "\(cost)円"
        //busRemainLabel1.text = "到着まで約 \(busRem1) 分"
       // busRemainLabel2.text = "到着まで約 \(busRem2) 分"
        
        // バックグラウンドからの復帰を監視するやつ
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.viewWillEnterForeground(_:)),
                                               name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        //getDate()
        // パン（フリック）ジェスチャーのレコグナイザを定義、自分で定義した関数「panGesture」を呼び出すようにする
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture(sender:)))
        firstView.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        let nowTimeString = getNowClockString()
        var nowTimeInt:Int = Int(nowTimeString)!
        
        if nowTimeInt >= 6 && nowTimeInt <= 15{
            topColor = UIColor(red:0.000, green:0.557, blue:1.000, alpha:1)//朝
            bottomColor = UIColor(red:0.000, green:1.000, blue:1.000, alpha:0)//朝
            hayaLabel.backgroundColor = UIColor(red:0.000, green:0.557, blue:1.000, alpha:1)
            busStopLabel1.backgroundColor = UIColor(red:0.000, green:0.707, blue:1.000, alpha:0.7)
            busStopLabel2.backgroundColor = UIColor(red:0.000, green:0.707, blue:1.000, alpha:0.7)
            hayaLabel.backgroundColor =  UIColor(red:0.000, green:0.777, blue:1.000, alpha:0.7)
            tsugiLabel.backgroundColor =  UIColor(red:0.000, green:0.777, blue:1.000, alpha:0.7)
        }else if nowTimeInt >= 16 && nowTimeInt <= 18{
            topColor = UIColor(red:0.980, green:0.439, blue:0.604, alpha:1)//夕方
            bottomColor = UIColor(red:0.996, green:0.882, blue:0.251, alpha:1)//夕方
            busStopLabel1.backgroundColor = UIColor(red:0.985, green:0.587, blue:0.484, alpha:1)
            busStopLabel2.backgroundColor = UIColor(red:0.985, green:0.587, blue:0.484, alpha:1)
            hayaLabel.backgroundColor =  UIColor(red:0.990, green:0.659, blue:0.421, alpha:1)
            tsugiLabel.backgroundColor =  UIColor(red:0.990, green:0.659, blue:0.421, alpha:1)
        }else if nowTimeInt >= 19 && nowTimeInt <= 24 || nowTimeInt >= 0 && nowTimeInt <= 5{
            topColor = UIColor(red:0.200, green:0.031, blue:0.404, alpha:1)//夜
            bottomColor = UIColor(red:0.108, green:0.442, blue:0.746, alpha:1)//夜
            busStopLabel1.backgroundColor = UIColor(red:0.170, green:0.170, blue:0.520, alpha:1)
            busStopLabel2.backgroundColor = UIColor(red:0.170, green:0.170, blue:0.520, alpha:1)
            hayaLabel.backgroundColor =  UIColor(red:0.150, green:0.240, blue:0.570, alpha:1)
            tsugiLabel.backgroundColor =  UIColor(red:0.150, green:0.240, blue:0.570, alpha:1)
        }
        print(nowTimeString)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    
        let realm = try! Realm()
        let getOnBusStop = realm.objects(FrequentlyPlaceObject.self)
        busStopLabel1.text = "\(getOnBusStop.last!.busStop1)"
    }
    
    @objc func viewWillEnterForeground(_ notification: Notification?) {
        getDate()
    }
    
    @IBAction func reloadButton(_ sender: Any) {
        getDate()
    }
    
    func getNowClockString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let now = Date()
        return formatter.string(from: now)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDate(){
        let realm = try! Realm()
        let getOnBusStop = realm.objects(FrequentlyPlaceObject.self).last?.busStop1
        let object = httpGetPost(departureBusStop: getOnBusStop!,arrivalBusStop: "はこだて未来大学", dayTime: getNowTime(), departureFlag: 0)
        
        let dispatchGroup = DispatchGroup()
        // 直列キュー / attibutes指定なし
        let dispatchQueue = DispatchQueue(label: "queue")
        
        // UIActivityIndicatorView のスタイルをテンプレートから選択
        self.indicator.activityIndicatorViewStyle = .whiteLarge
        
        // 表示位置
        self.indicator.center = self.view.center
        
        // 色の設定
        self.indicator.color = UIColor.black
        
        // アニメーション停止と同時に隠す設定
        self.indicator.hidesWhenStopped = true
        
        // 画面に追加
        self.view.addSubview(self.indicator)
        
        // 最前面に移動
        self.view.bringSubview(toFront: self.indicator)
        
        // アニメーション開始
        self.indicator.startAnimating()
        
        // 非同期処理を実行
        dispatchGroup.enter()
        dispatchQueue.async(group: dispatchGroup) {
            [weak self] in
            object.httpTransmission({ (str:ResultData?) -> () in
                self?.nextOriginTime = (str?.nextOriginTime)!
                self?.nextLocatingTime = (str?.nextLocatingTime)!
                self?.afterNextOriginTime = (str?.afterNextOriginTime)!
                self?.afterNextLocationTime = (str?.afterNextLocationTime)!
                self?.cost = (str?.cost)!
                dispatchGroup.leave()
            })
        }
        
        // 全ての非同期処理完了後にメインスレッドで処理
        dispatchGroup.notify(queue: .main) {
            self.indicator.stopAnimating()
            self.busTimeLabel1.text = self.nextOriginTime
            self.busRemainLabel1.text = self.nextLocatingTime
            self.busTimeLabel2.text = self.afterNextOriginTime
            self.busRemainLabel2.text = self.afterNextLocationTime
            self.costLabel.text = self.cost
            let nextBusTime = self.busTimeLabel1.text!
            let split = nextBusTime.components(separatedBy: ":")
            //print(split)
            UserDefaults.standard.set(split[0], forKey: "timeHour")
            UserDefaults.standard.set(split[1], forKey: "timeMinute")
        }
    }
    
    // パン（フリック）ジェスチャー中に呼び出される関数
    @objc func panGesture(sender: UIPanGestureRecognizer) {
        // 指が離れた時（sender.state = .ended）だけ処理をする
        switch sender.state {
        case .ended:
            // タップ開始地点からの移動量を取得
            let position = sender.translation(in: view)
            tapEndPosX = position.x     // x方向の移動量
            tapEndPosY = -position.y    // y方向の移動量（上をプラスと扱うため、符号反転する）
            // 上下左右のフリック方向を判別する
            // xがプラスの場合（右方向）とマイナスの場合（左方向）で場合分け
            if tapEndPosX > 0 {
                // 右方向へのフリック
                if tapEndPosY > tapEndPosX {
                    // yの移動量がxより大きい→上方向
                    print("上フリック")
                } else if tapEndPosY < -tapEndPosX {
                    // yの移動量が-xより小さい→下方向
                    print("下フリック")
                } else {
                    // 右方向
//                    let next = storyboard!.instantiateViewController(withIdentifier: "secondPage")
//                    next.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//                    self.present(next,animated: false, completion: nil)
                    self.performSegue(withIdentifier: "homeSegue", sender: nil)
                    print("右フリック")
                }
            } else {
                // 左方向へのフリック
                if tapEndPosY > -tapEndPosX {
                    // yの移動量が-xより大きい→上方向
                    print("上フリック")
                } else if tapEndPosY < tapEndPosX {
                    // yの移動量がxより小さい→下方向
                    print("下フリック")
                } else {
                    // 左方向
                    print("左フリック")
                }
            }
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "homeSegue" { //Segueのid
            // 値を渡す
        }else {
            // どちらでもない遷移
        }
    }

}

