//
//  DictionaryViewController.swift
//  Trace
//
//  Created by Apple on 2017/1/2.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        text.font = UIFont.init(name: "HYWaiWaiTiJ", size: 17.0)
        
        
        DispatchQueue.main.async {
            self.prepareText()//处理文本
        }
        getImage() //加载图片
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenWidth = UIScreen.main.bounds.width
        let textViewWidth:CGFloat = screenWidth - 49 - 20
        let textViewHeight:CGFloat = getTextViewHight()
        text.frame = CGRect(x: 49, y: 90, width: textViewWidth, height: textViewHeight)
        
        let photoViewWidth = photoView.frame.width
        let photoViewHeight = photoView.frame.height
        let photoViewX = screenWidth - 20 - photoViewWidth
        photoView.frame = CGRect(x: photoViewX, y: 89, width: photoViewWidth, height: photoViewHeight)
        // 消除背景颜色
        photoView.backgroundColor = UIColor.clear
    }

    
    
    @IBOutlet var photoView: PhotoView!
    @IBOutlet var text: UITextView!
    
    //加载image
    func getImage() {
        var imagePath = String()
        let date: String = getDate()
        let fileManager = FileManager.default
        let mydir = documentPath + "/Trace/Document"
        print(mydir)
        let urls: [String] = try! fileManager.contentsOfDirectory(atPath: mydir)
        //得到当前图片文件目录
        for i in 0..<urls.count {
            if urls[i].contains(date){
                imagePath = mydir + "/" + urls[i] + "/image"
                break
            }
        }
        //取出前两张
        let image1 = imagePath + "/0.png"
        if fileManager.fileExists(atPath: image1){
            let handler = FileHandle(forReadingAtPath: image1)
            let data = handler?.readDataToEndOfFile()
            self.photoView.p1.image = UIImage(data: data!)
        }else{
            self.photoView.p1.alpha = 0
        }
        
        let image2 = imagePath + "/1.png"
        if fileManager.fileExists(atPath: image2){
            let handler = FileHandle(forReadingAtPath: image2)
            let data = handler?.readDataToEndOfFile()
            self.photoView.p2.image = UIImage(data: data!)
        }else{
            self.photoView.p2.alpha = 0
        }
        
    }
    
    func prepareText() {
        //前4行图文部分文本宽度
        let smallTextWidth:CGFloat = UIScreen.main.bounds.width - photoView.frame.width - 20 - 49
        let num: Int = Int(smallTextWidth/17) //计算这一行有多少个字
        let str = getText()
        
        var newStr: String = ""//记录新的字符串
        var i:Int = 0
        //TODO 这里的换行方式太简单，需要改进，先进行换行符分割
        for char in (str.characters) {
            //print(char)
            if i==num || i==num*2 || i==num*3 || i==num*4{
                //需要换行，插入换行符
                newStr.append("\r\n")
            }
            newStr.append(char)
            i += 1
        }
        
        text.text = newStr
    }
    
    
    //从文件中获取字符串
    func getText() -> String {
        var content: String = String()
        let date: String = getDate()
        let fileManager = FileManager.default
        let mydir = documentPath + "/Trace/Document"
        let urls: [String] = try! fileManager.contentsOfDirectory(atPath: mydir)
        for i in 0..<urls.count {
            if urls[i].contains(date){
                let filePath = mydir + "/" + urls[i] + "/content.txt"
                do {
                    try content = NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue) as String
                } catch {
                    print("read file error")
                }
            }
        }
        //print(content)
        return content
    }
    
    //计算textview的height值
    func getTextViewHight() -> CGFloat {
        let viewBounds = UIScreen.main.bounds
        var currentY:CGFloat = 60
        while currentY < viewBounds.height{
            currentY += 32
        }
        currentY -= 30
        let offset:CGFloat = 0 //设置容差调整
        let textViewHight = currentY + offset - 59
        return textViewHight
    }
    
}
