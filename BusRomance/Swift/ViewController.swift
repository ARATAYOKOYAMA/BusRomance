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
    
    var monday:[String] = ["","","","","",""]
    var thuesday:[String] = ["","","","","",""]
    var wednesday:[String] = ["","","","","",""]
    var thursday:[String] = ["","","","","",""]
    var friday:[String] = ["","","","","",""]
    
    var todayFirstClass = 0//今日の最初の授業のコマ数
    var todayLastClass = 0//今日の最後の授業のコマ数
    var tomorrowFirstClass = 0//明日の最初の授業のコマ数
    var tomorrowLastClass = 0//明日の最後の授業のコマ数
    
    //ページ遷移系
    @IBOutlet var firstView: UIView!
    var tapEndPosX:CGFloat = 0
    var tapEndPosY:CGFloat = 0
    
    
    // インジケータのインスタンス
    let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //deleateRealmSchedule()
        //busStopLabel1.text = "\(busStop1)"
        busStopLabel2.text = "\(busStop2)"
      //  costLabel.text = "\(cost)円"
        //busRemainLabel1.text = "到着まで約 \(busRem1) 分"
       // busRemainLabel2.text = "到着まで約 \(busRem2) 分"
        readSchedule()
        let today = checkToday()
        todayAndTomorrowSchedule(today)
        // バックグラウンドからの復帰を監視する
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
        let nowTimeInt:Int = Int(nowTimeString)!
        readSchedule()
        let today = checkToday()
        todayAndTomorrowSchedule(today)
        print("todayFirstClass = \(todayFirstClass)")
        print("todayLastClass = \(todayLastClass)")
        print("tomorrowFirstClass = \(tomorrowFirstClass)")
        print("tomorrowLastClass = \(tomorrowLastClass)")
        setColor(nowTimeInt)
        
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
    
    func setColor(_ nowTimeInt:Int){
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
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
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
                monday.remove(at: time)
                monday.insert("\(results[i].name)", at: time)
            }else if results[i].time >= 21 && results[i].time <= 25{
                let time = results[i].time - 20
                thuesday.remove(at: time)
                thuesday.insert("\(results[i].name)", at: time)
            }else if results[i].time >= 31 && results[i].time <= 35{
                let time = results[i].time - 30
                wednesday.remove(at: time)
                wednesday.insert("\(results[i].name)", at: time)
            }else if results[i].time >= 41 && results[i].time <= 45{
                let time = results[i].time - 40
                thursday.remove(at: time)
                thursday.insert("\(results[i].name)", at: time)
            }else if results[i].time >= 51 && results[i].time <= 55{
                let time = results[i].time - 50
                friday.remove(at: time)
                friday.insert("\(results[i].name)", at: time)
            }
        }
    }
    
    func checkToday()->Int{
        let date: NSDate = NSDate()
        let cal: NSCalendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
        let comp: NSDateComponents = cal.components(
            [NSCalendar.Unit.weekday],
            from: date as Date
            ) as NSDateComponents
        let weekday: Int = comp.weekday - 1//月曜日から1234567
        return weekday
    }
    
    func todayAndTomorrowSchedule(_ today:Int){
        switch today {
        case 1://月曜日
            setSchedule(monday, thuesday)
        case 2://火曜日
            setSchedule(thuesday, wednesday)
        case 3://水曜日
            setSchedule(wednesday, thursday)
        case 4://木曜日
            setSchedule(thursday, friday)
        case 5://金曜日
            setSchedule(friday, [])
        case 6://土曜日
            setSchedule([], [])
        case 7://日曜日
            setSchedule([], monday)
        default:
            break
        }
        
    }
    
    func setSchedule(_ todayArray:[String],_ tomorrowArray:[String]){
        for i in 1..<todayArray.count{
            if todayArray[i] != ""{
                todayFirstClass = i
                break
            }
        }
        for i in (1...5).reversed() {
            if todayArray[i] != ""{
                todayLastClass = i
                break
            }
        }
        for i in 1..<tomorrowArray.count{
            if tomorrowArray[i] != ""{
                tomorrowFirstClass = i
                break
            }
        }
        for i in (1...5).reversed() {
            if tomorrowArray[i] != ""{
                tomorrowLastClass = i
                break
            }
        }
        if todayArray == []{
            todayFirstClass = 0
            todayLastClass = 0
        }
        if tomorrowArray == []{
            tomorrowFirstClass = 0
            tomorrowLastClass = 0
        }
    }
}

