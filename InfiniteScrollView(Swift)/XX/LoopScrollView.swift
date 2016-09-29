//
//  LoopScrollView.swift
//  Swift实现轮播
//
//  Created by mac on 16/9/16.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class LoopScrollView: UIView ,UIScrollViewDelegate{

    //宏定义：分页控件的高度 
    let pageControlHeight = 37
    //屏幕宽高
    let ScreenWidth = UIScreen.mainScreen().bounds.width
    let ScreenHeight = UIScreen.mainScreen().bounds.height
    //定义一个数组存放图片的名字
    private var titleArray1 : NSArray?
    
    //变量
    var _scrollView : UIScrollView?
    var _pageControl : UIPageControl?
    var _timer:NSTimer?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI(frame:CGRect) {
       
        //滑动视图的创建
        _scrollView = UIScrollView.init(frame: CGRect(x:0,y:0,width:frame.width,height:frame.height))
        _scrollView?.backgroundColor = UIColor.redColor()
        _scrollView?.delegate = self
        _scrollView?.pagingEnabled = true
        _scrollView?.showsVerticalScrollIndicator = false
        _scrollView?.showsHorizontalScrollIndicator = false
        self.addSubview(_scrollView!)
        
        //创建分页效果
        _pageControl = UIPageControl.init(frame: CGRect(x:0,y:frame.size.height-CGFloat(pageControlHeight),width:ScreenWidth,height:CGFloat(pageControlHeight)))
        _pageControl?.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(_pageControl!)
    }
    
    var titleArray : NSArray?
        
        {
        
        didSet{
            //使用mutableArray来
            let mutArray = NSMutableArray.init(array: titleArray!)
            //将最后一张图片插入两次，目的是使得到最后一张图片的时候直接跳转到第一张
            mutArray.insertObject((titleArray?.lastObject)!, atIndex: 0)
            //同时将一张图片添加进去
            mutArray.addObject((titleArray?.firstObject)!)
            //将生成的数组给_titleArray = 5 1 2 3 4 5 1
            self.titleArray = mutArray
            
            //创建视图
            createScrollContentView()
        }
        
    }
    
    
    func createScrollContentView (){
        //获取滑动视图的子视图
        let subViews = _scrollView?.subviews
        //如果子视图存在，就要删除，然后重绘
        for obj in subViews!{
          obj.removeFromSuperview()
        }
        
        for i in 0 ..< Int((self.titleArray?.count)!) {
            
             let imageView : UIImageView = UIImageView.init(frame: CGRect(x: CGFloat(i)*ScreenWidth,y:0,width:ScreenWidth,height:(_scrollView?.frame.size.height)!))
            let ss:String = NSString.init(format: "\(self.titleArray![i])" as NSString) as String
            imageView.image = UIImage.init(named: ss);
            
            //将图片视图添加到滑动视图上
            _scrollView?.addSubview(imageView)
   
        }
     
        //分页效果
        _pageControl?.numberOfPages = (self.titleArray?.count)! - 2
        //设置分页大小
        _scrollView?.contentSize = CGSize(width:CGFloat((self.titleArray?.count)!)*ScreenWidth,height:(_scrollView?.frame.size.height)!)
        //设置偏移量
        _scrollView?.contentOffset = CGPoint(x:(_scrollView?.frame.size.width)!,y:0)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
    //获取当前的分页效果
    let currentPage  = scrollView.contentOffset.x/ScreenWidth
    //获取当前分页
    _pageControl?.currentPage = Int(currentPage) - 1
    //
        if currentPage == 0 {
            //设置滑动视图的偏移量
            scrollView.contentOffset = CGPoint(x:CGFloat((self.titleArray?.count)!-2)*ScreenWidth,y:0)
            //设置分页指示位置
            _pageControl?.currentPage = (self.titleArray?.count)! - 2 - 1
            
        }else if currentPage == CGFloat((self.titleArray?.count)!) - 1 {
            scrollView.contentOffset = CGPoint(x:Int(ScreenWidth),y:0)
            //设置分页指示器
            _pageControl?.currentPage = 0
        }
    
    }

}
  
