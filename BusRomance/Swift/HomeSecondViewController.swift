//
//  HomeSecondViewController.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/12/11.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit

class HomeSecondViewController: UIViewController {

    @IBOutlet var secondView: UIView!
    var tapEndPosX:CGFloat = 0
    var tapEndPosY:CGFloat = 0
    
    
    @IBOutlet weak var todayLabel: UILabel! //「今日」と表示するラベル
    @IBOutlet weak var todayDateLabel: UILabel! //今日の日付を表示するラベル
    @IBOutlet weak var todayView: UIView! //今日の情報を表示する白いview
    @IBOutlet weak var todayFirstScheduleLabel: UILabel! //「行」の講義名を表示するラベル
    @IBOutlet weak var todayFirstTimeLabel: UILabel! //「行」のバスの時刻を表示するラベル
    @IBOutlet weak var todayFirstBusLabel: UILabel! //「行」のバス系統名を表示するラベル
    @IBOutlet weak var todayFirstBusStopLabel: UILabel! //「行」の乗車停留所名を表示するラベル
    @IBOutlet weak var todayLastScheduleLabel: UILabel! //「帰」の講義名を表示するラベル
    @IBOutlet weak var todayLastTimeLabel: UILabel! //「帰」のバスの時刻を表示するラベル
    @IBOutlet weak var todayLastBusLabel: UILabel! //「帰」のバス系統名を表示するラベル
    @IBOutlet weak var todayLastBusStopLabel: UILabel! //「帰」の乗車停留所名を表示するラベル
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture(sender:)))
        secondView.addGestureRecognizer(panGestureRecognizer)
        
        /* --- Label・Viewの初期設定 --- */
        todayView.layer.cornerRadius = 20 //白いviewに角丸を設定
        todayView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8) //背景色を半透明化
        
        /* --- ラベルの初期値を設定.（現在は仮） ---*/
        //「今日（上のview）」のラベル
        todayLabel.text = "今日"
        todayDateLabel.text = "2017/02/02"
        todayFirstScheduleLabel.text = "1限　AAAAAAAAAAAAAAAA"
        todayFirstTimeLabel.text = "12:00"
        todayFirstBusLabel.text = "105系統"
        todayFirstBusStopLabel.text = "赤川入口"
        todayLastScheduleLabel.text = "1限　AAAAAAA"
        todayLastTimeLabel.text = "12:00"
        todayLastBusLabel.text = "105系統"
        todayLastBusStopLabel.text = "赤川入口"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
                    // performsegueの方がいいかどうかは要検討
                    self.navigationController?.popViewController(animated: true)
                    print("左フリック")
                }
            }
        default:
            break
        }
    }
}
