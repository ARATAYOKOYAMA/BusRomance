//
//  SearchResultViewController.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/10/14.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController{
    
    @IBOutlet weak var departureTextField: UILabel!
    @IBOutlet weak var arrivalTextField: UILabel!
    
    @IBAction func alert(_ sender: Any) {
//        let alert = UIAlertController(
//            title: "アラートのタイトル",
//            message: "アラートの本文",
//            preferredStyle: .actionSheet)
//        // アラートにボタンをつける
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        // アラート表示
//        self.present(alert, animated: true, completion: nil)
        
    }
    
    var departureBusStop = ""
    var arrivalBusStop = ""
    
    override func viewDidLoad() {
        departureTextField.text = departureBusStop
        arrivalTextField.text = arrivalBusStop
    }
    
    override func didReceiveMemoryWarning() {
        
    }
}
