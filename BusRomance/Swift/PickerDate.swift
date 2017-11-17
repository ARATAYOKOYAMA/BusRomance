//
//  PickerDate.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/10/09.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit

var searchTargetData = (dateTime: "", departureFlag: 0)

class PickerDate: UITextField{
    
    var departureFlag:Int  = 1 // 1なら乗車する時刻 0なら降車する時刻
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    
    let departureButton = UIBarButtonItem(title: "出発", style: .done, target: self, action: #selector(PickerDate.changeDeparture))
    
    let arrivalButton = UIBarButtonItem(title: "到着", style: .done, target: self, action: #selector(PickerDate.changeArrival))
    
    /*
     pickerのセットアップ
     */
    
    func setup() {
        // Pickerのtoolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        
        //UIBarButtonItemを追加して，datepicekrを複数形式に??
        //let JayZButton = UIBarButtonItem(title: "JayZ", style: .done, target: self, action: #selector(PickerDate.getNow))
        
        departureButton.tintColor = UIColor.blue

        arrivalButton.tintColor = UIColor.lightGray
        
        // Pickerのdone
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PickerDate.done))
        
        // pickerのcancel
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(PickerDate.cancel))
        
        
        toolbar.setItems([departureButton, arrivalButton, cancelItem, doneItem], animated: true)
        
//        toolbar.isUserInteractionEnabled = true
//        toolbar.sizeToFit()
//
        // textfieldの入力をdatepickerに
        self.inputView = datePicker
        self.inputAccessoryView = toolbar
        
        // 日付のフォーマットを日本時間に設定
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
    
        // 現在時刻を初期値として入力
        getNow()
    }
    
    
    /*
     出発時刻で検索
     */
    func changeDeparture(){
        departureButton.tintColor = UIColor.blue
        arrivalButton.tintColor = UIColor.lightGray
        departureFlag = 1
    }
    
    /*
     到着時刻で検索
     */
    func changeArrival(){
        departureButton.tintColor = UIColor.lightGray
        arrivalButton.tintColor = UIColor.blue
        departureFlag = 0
    }
    
    
    /*
     現在時刻の取得
     */
    func getNow(){
        // 現在日時
        let date = Date()
        datePicker.date = date
        searchTargetData.dateTime = dateFormatter.string(from: datePicker.date)
        self.text = dateFormatter.string(from: datePicker.date) + "発"
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
        
        var flagResult:String = ""
        if departureFlag == 1 {
            flagResult = "発"
        }else if departureFlag == 0 {
            flagResult = "着"
        }
        
        searchTargetData.dateTime = dateFormatter.string(from: datePicker.date)
        searchTargetData.departureFlag = departureFlag
        self.text = dateFormatter.string(from: datePicker.date) + flagResult
        self.endEditing(true)
    }
    
}
