//
//  ViewController.swift
//  Swift实现轮播
//
//  Created by mac on 16/9/16.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let array = ["scene1",
                      "scene2",
                       "scene3",
                        "scene4",
                         "scene5"]
        let loopView : LoopScrollView = LoopScrollView.init(frame: CGRect(x:0,y:20,width:self.view.frame.width,height:260))
        self.view .addSubview(loopView)
       loopView.titleArray = array as NSArray
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

