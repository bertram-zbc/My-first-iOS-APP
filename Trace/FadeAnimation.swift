//
//  FadeAnimation.swift
//  test
//
//  Created by Apple on 2016/12/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit

class FadeAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    
    // 指定转场动画持续的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    // 实现转场动画的具体内容
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 得到容器视图
        let containerView = transitionContext.containerView
        // 目标视图
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        containerView.addSubview(toView)
        
        // 为目标视图的展现添加动画
        toView.alpha = 0.0
        UIView.animate(withDuration: duration,
                                   animations: {
                                    toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }

}
