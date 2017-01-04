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
        
        
        let sendButtonWidth:CGFloat = sendButton.frame.width
        let sendButtonHeight:CGFloat = sendButton.frame.height
        let sendX = screenWidth - 20 - sendButtonWidth
        let sendY = 58 - sendButtonHeight
        sendButton.frame.origin.x = sendX
        sendButton.frame.origin.y = sendY
    }
    
    @IBAction func finishClick(_ sender: UIButton) {
        
        var fileDir = String()//记录文件目录
        
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
            let urls: [String] = try! fileManager.contentsOfDirectory(atPath: mydir)
            for i in 0..<urls.count{
                //遍历子目录并确定要储存的目录
                if urls[i].contains(date) {
                    //print(urls[i])
                    fileDir = urls[i]
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
        
        //异步上传到服务器
//        DispatchQueue.global().async {
//            self.postData(fileDir: fileDir)
//        }
        
        
        //跳转
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "DictionaryViewController")
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    //post方法上传
    //TODO 图片传输方式还有些问题
    //POST请求文件大小有限制，因此需要用文件流的方式传输图片
    func postData(fileDir:String){
        
        var imageData = Array<Data>()
        
        let fileManager = FileManager.default
        let urlString: String = "http://"+Config.ip+":"+Config.port+"/dictionary"
        let url = URL(string: urlString)
        var request: URLRequest = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        //获取图片
        let imageDir = documentPath + "/Trace/Document" + "/" + fileDir + "/image"
        if fileManager.fileExists(atPath: imageDir){
            let urls: [String] = try! fileManager.contentsOfDirectory(atPath: imageDir)
            for i in 0..<urls.count {
                //排除属性文件
                print(urls[i])
                if !urls[i].contains("DS_Store"){
                    let handler = FileHandle(forReadingAtPath: imageDir + "/" + urls[i])
                    let data = handler?.readDataToEndOfFile()
                    imageData.append(data!)
                }
            }
            
        }
        
        //获取文本
//        let textPath = fileDir + "/content.txt"
//        let handler = FileHandle(forReadingAtPath: textPath)
//        let textData = handler?.readDataToEndOfFile()
        
        //获取日记属性
        let settings:[String] = fileDir.components(separatedBy: "&")
        let date = settings[0] //日期
        let secret = settings[1] //隐私
        let weather = settings[2] //天气
        let mood = settings[3] //心情
        let tag = settings[4] //标记
        
        
        //创建json数据
        let jsonObj = [
            "date" : date,
            "secret" : secret,
            "weather" : weather,
            "mood" : mood,
            "tag" : tag,
            "text" : text.text,
            "image" : imageData] as [String : Any
        ]
        do {
            let postData = try JSONSerialization.data(withJSONObject: jsonObj, options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = postData
            print(postData)
        } catch {
            print("json data error")
        }
        
        //发送数据  
        let session:URLSession = URLSession.shared
        let dataTask: URLSessionDataTask = session.dataTask(with: request){(data,response,error) in
            if error == nil{//连接成功，得到服务器返回数据
                let dataString = NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(dataString!)
            }
            else{
                print("network error")
            }
            
        }
        dataTask.resume()
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

//设置转场动画代理
extension ContentInputViewController: UIViewControllerTransitioningDelegate{
    
    //present动画效果
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
    //dismiss动画效果
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
}
