//
//  DicSetViewController.swift
//  Trace
//
//  Created by Bertram on 2016/12/17.
//  Copyright © 2016年 Bertram. All rights reserved.
//

import UIKit

class DicSetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setImageInVisable()
        print("???")
    }
    
    //红色选择框图片设置
    @IBOutlet var chooseImagePublic: UIImageView!
    @IBOutlet var chooseImagePrivate: UIImageView!
    @IBOutlet var chooseImageSunny: UIImageView!
    @IBOutlet var chooseImageCloudy: UIImageView!
    @IBOutlet var chooseImageRainy: UIImageView!
    @IBOutlet var chooseImageSnowy: UIImageView!
    @IBOutlet var chooseImageGoodMood: UIImageView!
    @IBOutlet var chooseImageNormalMood: UIImageView!
    @IBOutlet var chooseImageBadMood: UIImageView!
    @IBOutlet var chooseImageTrip: UIImageView!
    @IBOutlet var chooseImageEssay: UIImageView!
    @IBOutlet var chooseImageLife: UIImageView!
    @IBOutlet var chooseImageThink: UIImageView!
    @IBOutlet var chooseImageComplain: UIImageView!
    

    
    func setImageInVisable(){
        chooseImagePrivate.alpha = 0
        //chooseImagePublic.alpha = 0
        chooseImageSunny.alpha = 0
        //chooseImageCloudy.alpha = 0
        chooseImageRainy.alpha = 0
        chooseImageSnowy.alpha = 0
        //chooseImageGoodMood.alpha = 0
        chooseImageNormalMood.alpha = 0
        chooseImageBadMood.alpha = 0
        chooseImageTrip.alpha = 0
        chooseImageEssay.alpha = 0
        //chooseImageLife.alpha = 0
        chooseImageThink.alpha = 0
        chooseImageComplain.alpha = 0
    }

    @IBAction func privateClick(_ sender: UITapGestureRecognizer) {
        chooseImagePrivate.alpha = 1.0
        chooseImagePublic.alpha = 0
    }
    
    @IBAction func publicClick(_ sender: UITapGestureRecognizer) {
        chooseImagePublic.alpha = 1.0
        chooseImagePrivate.alpha = 0
    }
    
    @IBAction func sunnyClick(_ sender: UITapGestureRecognizer) {
        chooseImageSunny.alpha = 1.0
        chooseImageCloudy.alpha = 0
        chooseImageRainy.alpha = 0
        chooseImageSnowy.alpha = 0
    }

    @IBAction func cloudyClick(_ sender: UITapGestureRecognizer) {
        chooseImageSunny.alpha = 0
        chooseImageCloudy.alpha = 1.0
        chooseImageRainy.alpha = 0
        chooseImageSnowy.alpha = 0
    }
    
    @IBAction func rainyClick(_ sender: UITapGestureRecognizer) {
        chooseImageSunny.alpha = 0
        chooseImageCloudy.alpha = 0
        chooseImageRainy.alpha = 1.0
        chooseImageSnowy.alpha = 0
    }
    
    @IBAction func snowyClick(_ sender: UITapGestureRecognizer) {
        chooseImageSunny.alpha = 0
        chooseImageCloudy.alpha = 0
        chooseImageRainy.alpha = 0
        chooseImageSnowy.alpha = 1.0
    }
    
    @IBAction func goodMoodClick(_ sender: UITapGestureRecognizer) {
        chooseImageGoodMood.alpha = 1.0
        chooseImageNormalMood.alpha = 0
        chooseImageBadMood.alpha = 0
    }
    
    @IBAction func normalMoodClick(_ sender: UITapGestureRecognizer) {
        chooseImageGoodMood.alpha = 0
        chooseImageNormalMood.alpha = 1.0
        chooseImageBadMood.alpha = 0
    }
    
    @IBAction func badMoodClick(_ sender: UITapGestureRecognizer) {
        chooseImageGoodMood.alpha = 0
        chooseImageNormalMood.alpha = 0
        chooseImageBadMood.alpha = 1.0
    }
    
    @IBAction func tripClick(_ sender: UITapGestureRecognizer) {
        chooseImageTrip.alpha = 1.0
        chooseImageEssay.alpha = 0
        chooseImageLife.alpha = 0
        chooseImageThink.alpha = 0
        chooseImageComplain.alpha = 0
    }
    
    @IBAction func essayClick(_ sender: UITapGestureRecognizer) {
        chooseImageTrip.alpha = 0
        chooseImageEssay.alpha = 1.0
        chooseImageLife.alpha = 0
        chooseImageThink.alpha = 0
        chooseImageComplain.alpha = 0
    }
    
    @IBAction func lifeClick(_ sender: UITapGestureRecognizer) {
        chooseImageTrip.alpha = 0
        chooseImageEssay.alpha = 0
        chooseImageLife.alpha = 1.0
        chooseImageThink.alpha = 0
        chooseImageComplain.alpha = 0
    }
    
    @IBAction func thinkClick(_ sender: UITapGestureRecognizer) {
        chooseImageTrip.alpha = 0
        chooseImageEssay.alpha = 0
        chooseImageLife.alpha = 0
        chooseImageThink.alpha = 1.0
        chooseImageComplain.alpha = 0
    }
    
    @IBAction func complainClick(_ sender: UITapGestureRecognizer) {
        chooseImageTrip.alpha = 0
        chooseImageEssay.alpha = 0
        chooseImageLife.alpha = 0
        chooseImageThink.alpha = 0
        chooseImageComplain.alpha = 1.0
    }
    
    
}
