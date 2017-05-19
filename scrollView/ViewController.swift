//
//  ViewController.swift
//  scrollView
//
//  Created by tembin on 2017/5/10.
//  Copyright © 2017年 YQ. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, YQScrollViewDelegate {
  
  
  var images = [UIImage]()
  let scroll = YQScrollView()
  override func viewDidLoad() {
    super.viewDidLoad()
    set()
    NotificationCenter.default.addObserver(self, selector: #selector(deleteImage(_:)), name: NSNotification.Name(rawValue: "deleteImage"), object: nil)
  }
  
  func deleteImage(_ noti: Notification) {
    let index = noti.object as! Int
    print(index)
  }
  

  func set ()  {
    
    for i in 1 ... 4 {
      let image = UIImage(named: "\(i).jpg")
      images.append(image!)
    }
    
    
    self.view.addSubview(scroll)
    scroll.snp.makeConstraints { (make) in
      make.left.equalTo(self.view).offset(20)
      make.top.equalTo(self.view).offset(100)
      make.width.equalTo(self.view.bounds.size.width)
      make.height.equalTo(60)
      
    }
    
    scroll.imageWidth = 80
    scroll.imageHeight = 60
    scroll.speace = 5
    scroll.isHiddenDelete = false
    scroll.imageContentMode = UIViewContentMode.scaleAspectFit
    scroll.showImages = images
    scroll.YQDelegate = self
    
    
    

  }

  @IBAction func add(_ sender: Any) {
    for i in 1 ... 4 {
      let image = UIImage(named: "\(i).jpg")
      images.append(image!)
    }
    scroll.showImages = images
  }
  func lookImage(imageViews: [UIImageView], currenIndex: Int) {
    print(imageViews.count, currenIndex)
  }
  
  func currentImags(images: [UIImage]) {
    self.images = images
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

