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
    @IBOutlet weak var nextLocatingTimeTextField: UILabel!
    @IBOutlet weak var nextOriginTimeTextField: UILabel!
    @IBOutlet weak var arrivalTimeTextField: UILabel!
    @IBOutlet weak var costTextField: UILabel!
    @IBOutlet weak var lineageTextField: UILabel!
    
    var departureBusStop = ""
    var arrivalBusStop = ""
    var nextLocatingTime = ""
    var nextOriginTime = ""
    var arrivalTime = ""
    var cost = ""
    var lineage = ""
    
    override func viewDidLoad() {
        departureTextField.text = departureBusStop
        arrivalTextField.text = arrivalBusStop
        nextOriginTimeTextField.text = nextOriginTime
        nextLocatingTimeTextField.text = nextLocatingTime
        arrivalTimeTextField.text = arrivalTime
        costTextField.text = cost
        lineageTextField.text = lineage
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "検索結果"
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
