//
//  AppDelegate.swift
//  BusRomance
//
//  Created by 横山　新 on 2017/09/20.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let userDefault = UserDefaults.standard
        let dict = ["firstLaunch": true]
        userDefault.register(defaults: dict)
        if userDefault.bool(forKey: "firstLaunch") {
            userDefault.set(false, forKey: "firstLaunch")
            print("初回起動です")
            initialActivation(0, "1", "")
            initialActivation(6, "2", "")
            initialActivation(12, "3", "")
            initialActivation(18, "4", "")
            initialActivation(24, "5", "")
            
            //windowを生成
            self.window = UIWindow(frame: UIScreen.main.bounds)
            //Storyboardを指定
            let storyboard = UIStoryboard(name: "InitialActivationStoryboard", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "InitialActivationViewController")
            //rootViewControllerに入れる
            self.window?.rootViewController = initialViewController
            //表示
            self.window?.makeKeyAndVisible()
        }else{
            print("通常起動です")
        }
        
        //通知許可リクエスト
        if #available(iOS 10.0, *) {
            // iOS 10
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                if error != nil {
                    return
                }
                if granted {
                    print("通知許可")
                    let center = UNUserNotificationCenter.current()
                    center.delegate = self
                } else {
                    print("通知拒否")
                }
            })
        } else {
            // iOS 9以下
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        return true
    }
    
    func initialActivation(_ time:Int ,_ name:String ,_ place:String){
        let realm = try! Realm()
        let obj = SaveScheduleObject()
        obj.time = time
        obj.name = name
        obj.place = place
        try! realm.write{
            realm.add(obj)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        var nextBusTimeHour = 0
        var nextBusTimeMinute = 0
        if UserDefaults.standard.object(forKey: "timeHour") != nil {
            nextBusTimeHour = UserDefaults.standard.integer(forKey: "timeHour")
            nextBusTimeMinute = UserDefaults.standard.integer(forKey: "timeMinute") + 15
            print("nextBusTimeHour = \(nextBusTimeHour)")
            print("nextBusTimeMinute = \(nextBusTimeMinute)")
        }
        let trigger: UNNotificationTrigger
        let date = DateComponents(hour: nextBusTimeHour, minute: nextBusTimeMinute)//(month:7, day:7, hour:12, minute:0)
        trigger = UNCalendarNotificationTrigger.init(dateMatching: date, repeats: true)
        //trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //表示の設定
        let content = UNMutableNotificationContent()
        content.title = "ばすあぷり"
        content.body = "明日バス乗らへんの？"
        content.sound = UNNotificationSound.default()
        
        
        // デフォルトの通知。画像などは設定しない
        let request = UNNotificationRequest(identifier: "normal",
                                            content: content,
                                            trigger: trigger)
        //通知を予約
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

