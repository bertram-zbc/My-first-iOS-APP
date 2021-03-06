//
//  Config.swift
//  Trace
//
//  Created by Apple on 2016/12/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

import Foundation
import UIKit

//一些配置信息
let Config = config()

//这样就是设置全局变量
//let IP: String = "192.168.253.1"


let homeDirectory = NSHomeDirectory() //文件主目录

//Documents目录，用于存放应用数据文件
//let documentPath = homeDirectory + "/Documents"
let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String

//Library目录，包含Cache目录
//let libraryPath = homeDirectory + "/Library"
let libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String

//Cache目录，用于存放缓存文件
//let cachePath = homeDirectory + "/Library/Caches"
let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String


//tmp目录，用于存放临时文件，重启后清空
let tmpDirectory = NSTemporaryDirectory()

struct DeviceSzie {
    
    enum DeviceType {
        case inch4
        case inch4_7
        case inch5_5
    }
    
    //判断屏幕类型
    static func currentSize() -> DeviceType {
        let screenWidth = UIScreen.main.bounds.width
        //let screenHeight = UIScreen.main.bounds.height
        
        switch screenWidth {
        case 320:
            return .inch4
        case 375:
            return .inch4_7
        default:
            return .inch5_5
        }
        
//        switch (screenWidth, screenHeight) {
//        case (320, 480),(480, 320):
//            return .iphone4
//        case (320, 568),(568, 320):
//            return .iphone5
//        case (375, 667),(667, 375):
//            return .iphone6
//        case (414, 736),(736, 414):
//            return .iphone6p
//        default:
//            return .iphone6
//        }
    }
}
let currDevice = DeviceSzie.currentSize()

//获取当前系统日期
func getDate() -> String {
    let currentDate = Date() //当前时间
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current //设置时区
    dateFormatter.dateFormat = "yyyy-MM-dd" //设置格式
    let stringDate = dateFormatter.string(from: currentDate)
    return stringDate
}

//获取当前的用户名
func getUserName() -> String {
    var username:String = ""
    let mydir = cachePath + "/Trace/Config"
    
    let filePath = mydir + "/login.txt"
    do {
        username = try NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue) as String
    } catch {
        print("error of read login.txt")
    }
    return username
}

class config {
    
    public let ip: String = "182.254.220.171" //服务器IP
    public let port: String = "8000"  //端口号
    
    public var keyboardHight: CGFloat //软键盘高度
    
    init() {
        //根据屏幕尺寸确定软键盘高度
        if currDevice == .inch4{
            keyboardHight = 253
        }else if currDevice == .inch4_7{
            keyboardHight = 258
        }else{
            keyboardHight = 271
        }
    }
   
    
}
