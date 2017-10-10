//
//  PickerDate.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/10/09.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit

class PickerDate: UITextField{
    
    let datePicker = UIDatePicker()
    
    /*
     pickerのセットアップ
     */
    func setup() {
        // Pickerのtoolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        
        // Pickerのdone
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PickerDate.done))
        
        // pickerのcancel
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(PickerDate.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        // textfieldの入力をdatepickerに
        self.inputView = datePicker
        self.inputAccessoryView = toolbar
    }
    
    
    /*
     キャンセルボタン
     */
    func cancel() {
        self.text = ""
        self.endEditing(true)
    }
    
    /*
     完了ボタン
     */
    func done() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        self.text = dateFormatter.string(from: datePicker.date)
        self.endEditing(true)
    }
}
