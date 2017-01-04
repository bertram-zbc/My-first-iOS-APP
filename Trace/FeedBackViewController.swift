//
//  FeedBackViewController.swift
//  Trace
//
//  Created by Apple on 2016/12/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit

class FeedBackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        textView.font = UIFont.init(name: "HYWaiWaiTiJ", size: 20.0)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenWidth = UIScreen.main.bounds.width
        //计算textview宽度
        let textWidth:CGFloat = screenWidth - 49 - 20
        //不要问为什么是这个值，调出来的
        let textHight:CGFloat = 195
        textView.frame = CGRect(x: 49, y: 60, width: textWidth, height: textHight)
        
        let sendButtonWidth = sendButton.frame.width
        let sendButtonHeight = sendButton.frame.height
        
        let sendX = screenWidth - 20 - sendButtonWidth
        let sendY = 58 - sendButtonHeight
        sendButton.frame.origin.x = sendX
        sendButton.frame.origin.y = sendY
        
        let labelWidth = label.frame.width
        let labelX = screenWidth - 20 - labelWidth
        label.frame.origin.x = labelX
        
    }
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var label: UILabel!
    
    @IBAction func returnBack(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //使用post异步发送数据
    @IBAction func send(_ sender: UIButton) {
        
        view.endEditing(true)
        
        if textView.text == "" || textView.text == "请输入您的宝贵意见!" {
            self.view.makeToast("写点什么再提交吧")
        } else {
            postData()
            self.view.makeToast("发送成功，感谢您的帮助", duration: 1.0, position: ToastPosition.bottom)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0, execute: {
                self.dismiss(animated: true, completion: nil)
            })
            
        }
        
        
    }
    
    func postData(){
        let urlString: String = "http://"+Config.ip+":"+Config.port+"/feedback"
        let url = URL(string: urlString)
        var request:URLRequest = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        
        //创建json数据
        let jsonObj = ["user":getUserName(),"content":textView.text] as [String : String]
        do {
            let postData = try JSONSerialization.data(withJSONObject: jsonObj, options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = postData
        } catch {
            print("json data error")
        }
        
        let session:URLSession = URLSession.shared
        let dataTask: URLSessionDataTask = session.dataTask(with: request){(data,response,error) in
            if error == nil { //连接成功
                //得到服务器返回数据
                let dataString = NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(dataString!)
            }
            else{ //连接失败
                print("network error")
            }
        }
        dataTask.resume()
    }
    
    //触摸关闭键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

//设置textview代理
extension FeedBackViewController: UITextViewDelegate{
    //设置提示字
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("begin")
        textView.text = ""
        textView.textColor = UIColor.black
        return true
    }
    
}

