//
//  ViewController.swift
//  ScrollView_3_Images
//
//  Created by Vuk on 3/13/17.
//  Copyright © 2017 Vuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var images = [UIImageView]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var contentWidth: CGFloat = 0.0
        
        let scrollWidth = scrollView.frame.size.width
        
        for x in 0...2 {
            var newX: CGFloat = 0.0
            newX = scrollWidth / 2 + scrollWidth * CGFloat(x)
            contentWidth += newX
            
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(frame: CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150))
            imageView.image = image
            imageView.contentMode = .scaleToFill
            imageView.tag = x + 1
            
            images.append(imageView)
            
            view?.insertSubview(pageControl, aboveSubview: imageView)
            scrollView.addSubview(imageView)
        }
        
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(images.count), height: view.frame.size.height)
        pageControl.numberOfPages = images.count
        Timer.scheduledTimer(timeInterval: 2, target: self, selector:  #selector(scrollingTimer), userInfo: nil, repeats: true)
    }
    
    func scrollingTimer() {
        let scrMain = self.scrollView
        let contentOffset = scrMain?.contentOffset.x
        let nextPage = (contentOffset!/(scrMain?.frame.size.width)!) + 1
        if Int(nextPage) != images.count {
            scrMain?.scrollRectToVisible(CGRect(x: CGFloat(nextPage * (scrMain?.frame.size.width)!), y: CGFloat(0), width: CGFloat((scrMain?.frame.size.width)!), height: CGFloat((scrMain?.frame.size.height)!)), animated: true)
            pageControl.currentPage = Int(nextPage)
        }
        else {
            scrMain?.scrollRectToVisible(CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat((scrMain?.frame.size.width)!), height: CGFloat((scrMain?.frame.size.height)!)), animated: false)
            pageControl.currentPage = 0
        }
    }

}

