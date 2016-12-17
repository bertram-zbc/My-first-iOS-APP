//
//  Config.swift
//  Trace
//
//  Created by Apple on 2016/12/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

import Foundation

//一些配置信息
let Config = config()

//这样就是设置全局变量
//let IP: String = "192.168.253.1"

class config {
    
    public let ip: String = "192.168.253.1" //服务器IP
    public let port: String = "8888"  //端口号
    
}
