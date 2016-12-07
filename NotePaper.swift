//
//  NotePaper.swift
//  Trace
//
//  Created by Bertram on 2016/12/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit

class NotePaper: UIView {

    //Draw the real note paper which will be the fundation of other view
    
    //获取屏幕尺寸
    let viewBounds = UIScreen.main.bounds
    //设置第一条线的位置
    let startX : CGFloat = 50 //距离左边界
    let startY : CGFloat = 70
    //设置右边界距离
    let alignRight : CGFloat = 20
    //设置第一个圆的圆心位置
    let centerX : CGFloat = 25
    let centerY : CGFloat = 60
    //设置圆的半径
    let radius : CGFloat = 10
    //设置圆的间隔
    let circleGap : CGFloat = 50
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true //设置圆角
        self.backgroundColor = UIColor(red: 0xf7/255, green: 0xee/255, blue: 0xd6/255, alpha: 1) //设置背景色为米黄色(#f7eed6)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true //设置圆角
        self.backgroundColor = UIColor(red: 0xf7/255, green: 0xee/255, blue: 0xd6/255, alpha: 1) //设置背景色为米黄色(#f7eed6)
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        let lineWidth : CGFloat = viewBounds.width - startX - alignRight  //线的长度
        let lineGap : CGFloat = 30 //两直线间隔距离
        
        //绘制直线
        //设置矩形填充颜色，即线的颜色
        context!.setFillColor(red: 0xc6/255, green: 0xc0/255, blue: 0xb2/255, alpha: 1)
        
        context!.addRect(CGRect(x: startX, y: startY-2, width: lineWidth, height: 1))
        var currentY = startY
        while currentY < viewBounds.height{
            context!.addRect(CGRect(x: startX, y: currentY, width: lineWidth, height: 1))
            currentY += 2 + lineGap
        }
        
        context!.fillPath() //填充路径，绘制直线
        
        //绘制圆
        context!.setFillColor(red: 0xff/255, green: 0xff/255, blue: 0xff/255, alpha: 1)
        currentY = centerY
        while currentY < viewBounds.height{
            let currentCenter = CGPoint(x: centerX, y: currentY)
            context!.addArc(center: currentCenter, radius: radius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: false)
            currentY += radius + circleGap
        }
        context!.fillPath()//填充路径，绘制圆
        
    }

}
