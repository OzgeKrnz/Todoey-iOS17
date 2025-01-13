//
//  AppDelegate.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //print("didFinishLaunchingWithOptions")
        //print((NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? "dafault") as String)
        
        return true
    }
    
    //bildirim, telefon cagrısı uygulamaya geçişiernde tetiklenir. Veri kaydetmek icin kullanılır
    func applicationWillResignActive(_ application: UIApplication) {
     
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    //uygulama tamamen kapatılmadan hemen önce cagrılır. Kapanısta veri kaydetmek ve log tutmak icin kullanılır.
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
    }


}

