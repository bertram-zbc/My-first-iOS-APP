//
//  ContentInputViewController.swift
//  Trace
//
//  Created by Bertram on 2016/12/15.
//  Copyright © 2016年 Bertram. All rights reserved.
//

import UIKit

class ContentInputViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置字体
        text.font = UIFont.init(name: "HYWaiWaiTiJ", size: 17.0)
        //设置textview躲避键盘
        keyboard.avoid(inView: self.view, textView: text, offSetY: 24)
        text.text = ""

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenWidth = UIScreen.main.bounds.width
        let textViewWidth:CGFloat = screenWidth - 49 - 20
        let textViewHeight:CGFloat = getTextViewHight()
        text.frame = CGRect(x: 49, y: 60, width: textViewWidth, height: textViewHeight)
        
        
        let sendButtonWidth = sendButton.frame.width
        let sendButtonHeight = sendButton.frame.height
        let sendX = screenWidth - 20 - sendButtonWidth
        let sendY = 58 - sendButtonHeight
        sendButton.frame.origin.x = sendX
        sendButton.frame.origin.y = sendY
    }
    
    @IBAction func finishClick(_ sender: UIButton) {
        //判断textview不是空后写入文件   
        if text.text == "" {
            self.view.makeToast("写点什么吧")
        }else{
            let date: String = getDate()
            let fileManager = FileManager.default
            //进入文件目录
            let mydir = documentPath + "/Trace/Document"
            print(mydir)
            //查询当前路径下所有子目录
            let urls: [String] = fileManager.subpaths(atPath: mydir)!
            //print("path")
            for i in 0..<urls.count{
                //遍历子目录并确定要储存的目录
                if urls[i].contains(date) && !urls[i].contains("/") {
                    let filePath = mydir + "/" + urls[i] + "/content.txt"
                    let isExist = fileManager.fileExists(atPath: filePath)
                    if isExist{
                        do {
                            try fileManager.removeItem(atPath: filePath)
                        } catch {
                            print("delete file error")
                        }
                    }
                    
                    do {
                        try text.text.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
                    } catch {
                        print("error write file")
                    }
                }
            }
            
        }
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
    
    var keyboard = TextViewKeyBoard()
    @IBOutlet var text: UITextView!
    @IBOutlet var sendButton: UIButton!
    
    //触摸关闭键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
