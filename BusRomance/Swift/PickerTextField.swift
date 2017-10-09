//
//  PickerTextField.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/10/09.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import Foundation
import UIKit

class PickerTextField: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {
    var dataList = [String]()
    
    //初期化
    init() {
        super.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
     pickerのセットアップ
     */
    func setup(dataList: [String]) {
        self.dataList = dataList
        
        let picker = UIPickerView()
        
        // Delegateを設定する.
        picker.delegate = self
        
        // DataSourceを設定する.
        picker.dataSource = self
        picker.showsSelectionIndicator = true
        
        // Pickerのtoolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        
        // Pickerのdone
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PickerTextField.done))
        
        // pickerのcancel
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(PickerTextField.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        self.inputView = picker
        self.inputAccessoryView = toolbar
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
     pickerに表示する行数を返すデータソースメソッド.
     (実装必須)
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    /*
     pickerに表示する値の数を返すデリゲートメソッド.
     */
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    
    /*
     pickerに表示する値を返すデリゲートメソッド.
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = dataList[row]
    }
    
    func cancel() {
        self.text = ""
        self.endEditing(true)
    }
    
    func done() {
        self.endEditing(true)
    }
}
