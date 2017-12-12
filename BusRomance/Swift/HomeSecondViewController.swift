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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture(sender:)))
        secondView.addGestureRecognizer(panGestureRecognizer)
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
