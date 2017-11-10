//
//  ViewController.swift
//  Kung-fu Runner
//
//  Created by 中村　陽太 on 2017/11/09.
//  Copyright © 2017年 中村　陽太. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //画面サイズ
    let SCREEN_SIZE = CGSize(width: 480, height: 320)
    //スクロールする背景画像のサイズ
    let BG_IMAGE_SIZE = CGSize(width: 480 * 2, height: 54)
    //タイマー呼び出しの同期
    let TIMER_INTERVAL = 0.02
    //背景移動量
    let MOVEMENT_OF_BACKGROUND_PER_SECOND = 180.0
    //スクロールする背景
    var backgroundViews = [UIImageView]()
    //タイマー
    var gameTimer:Timer?
    
    //MARK: - 汎用メソッド
    
    //MARK: - プレイヤーの制御
    
    //MARK: - ゲーム処理
    func scrollBackground(){
        //移動量計算
        let movementOfBackground = CGFloat(MOVEMENT_OF_BACKGROUND_PER_SECOND * TIMER_INTERVAL)
        
        //背景をずらす
        backgroundViews.forEach({
            item in
            item.frame.origin.x -= movementOfBackground
        })
        
        //左側に消えた背景を右側へ移動させる
        for(index, item) in backgroundViews.enumerated(){
            if item.frame.origin.x < -BG_IMAGE_SIZE.width {
                item.frame.origin.x = backgroundViews[(index - 1 + backgroundViews.count) % backgroundViews.count].frame.origin.x + BG_IMAGE_SIZE.width
            }
        }
    }
    
    //MARK: - ゲーム管理
    func timerFunction(timer: Timer){
        
    }
    
    func gameStart() {
        gameTimer = Timer.scheduledTimerWithTimeInterval(TIMER_INTERVAL, target: self, selector: #selector(ViewController.timerMethod(_:)), userInfo: nil, repeats: true)
    }
    
    //MARK: - ボタン操作
    
    //MARK: - パラメータの操作
    
    //MARK: - 画像の設定
    func setBackgroundView() {
        //動かない背景の設定
        let fixedBackgroundView = UIImageView(image: UIImage(named: "bg.png"))
        self.view.addSubview(fixedBackgroundView)
        
        //スクロールする背景の設定
        let scrollImage = UIImage(named: "backbase.png")
        
        let scrollView = UIImageView(image: scrollImage)
        scrollView.frame.origin = CGPoint(x: 0, y: SCREEN_SIZE.height - scrollImage!.size.height)
        self.view.addSubview(scrollView)
        backgroundViews.append(scrollView)
        
        let nextScrollView = UIImageView(image: scrollImage)
        nextScrollView.frame.origin = CGPoint(x: SCREEN_SIZE.width, y: SCREEN_SIZE.height - scrollImage!.size.height)
        self.view.addSubview(nextScrollView)
        backgroundViews.append(nextScrollView)
    }
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundView()
        gameStart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

