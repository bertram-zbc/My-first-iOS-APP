//
//  PhotoView.swift
//  Trace
//  自定义照片View，用于嵌入其他view中
//  Created by Bertram on 2016/12/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit

class PhotoView: UIView {

    
    @IBOutlet var p1: UIImageView!
    @IBOutlet var p2: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadView()
    }
    
    //从XIB中读取视图
    func loadView(){
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PhotoView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        p1.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI/20))//正，顺时针
        p2.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI/18))//负，逆时针
        self.addSubview(view);
    }
    

}
