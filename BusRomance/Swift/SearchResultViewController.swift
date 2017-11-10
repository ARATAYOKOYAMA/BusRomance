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
        
    }
    
    var departureBusStop = ""
    var arrivalBusStop = ""
    
    override func viewDidLoad() {
        departureTextField.text = departureBusStop
        arrivalTextField.text = arrivalBusStop
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "検索結果"
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
