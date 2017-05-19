//
//  YQScrollView.swift
//  scrollView
//
//  Created by tembin on 2017/5/10.
//  Copyright © 2017年 YQ. All rights reserved.
//

import UIKit
import SDWebImage

@objc public protocol YQScrollViewDelegate: NSObjectProtocol {
  func lookImage(imageViews: [UIImageView], currenIndex: Int)
  @objc optional func currentImags(images: [UIImage])
}

class YQScrollView: UIScrollView, YQScrollViewDelegate {
  
  fileprivate var imageViews = [UIImageView]()
  fileprivate var currentImages = [UIImage]()
  
  var imageWidth: CGFloat!
  var imageHeight: CGFloat!
  var speace: CGFloat!
  var isHiddenDelete = false
  var imageContentMode: UIViewContentMode!
  var imageURL: [String]? {
    didSet {
      loadImagesWithURL(imageURLs: imageURL!, imageWidth: imageWidth, imageHeight: imageHeight, speace: speace, imageContentMode: imageContentMode)
    }
  }
  
  weak var YQDelegate: YQScrollViewDelegate?
  
  var showImages: [UIImage]? {
    didSet {
      currentImages = showImages!
      loadImages(images: showImages!, imageWidth: imageWidth, imageHeight: imageHeight, speace: speace, isHiddenDelete: isHiddenDelete, imageContentMode: imageContentMode)
    }
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func loadImages(images: [UIImage],imageWidth: CGFloat, imageHeight: CGFloat, speace: CGFloat, isHiddenDelete: Bool, imageContentMode: UIViewContentMode) {
    imageViews.removeAll()
    for sub  in self.subviews {
      sub.removeFromSuperview()
    }
    self.contentSize = CGSize(width: (imageWidth + speace) * CGFloat(images.count), height: imageHeight)
    for i in 0 ..< images.count {
      let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * (imageWidth + speace), y: 0, width: imageWidth, height: imageHeight))
      
      self.addSubview(imageView)
      
      imageView.image = images[i]
      imageView.isUserInteractionEnabled = true
      imageView.contentMode = imageContentMode
      
      let button = UIButton(type: .custom)
      button.frame = CGRect(x: 0, y: 20, width: imageWidth, height: imageHeight - 20)
      button.tag = 200 + i
      button.addTarget(self, action: #selector(lookImage(_:)), for: .touchUpInside)
      
      let deleteImageButton = UIButton(type: .custom)
      deleteImageButton.frame = CGRect(x: imageWidth - 20, y: 0, width: 20, height: 20)
      deleteImageButton.tag = 100 + i
      deleteImageButton.isHidden = isHiddenDelete
      deleteImageButton.setImage(UIImage(named: "delete"), for: .normal)
      deleteImageButton.addTarget(self, action: #selector(deleteImage(_:)), for: .touchUpInside)
      
      imageView.addSubview(button)
      imageView.addSubview(deleteImageButton)
      imageViews.append(imageView)
    }
  }
  
  func loadImagesWithURL(imageURLs: [String],imageWidth: CGFloat, imageHeight: CGFloat, speace: CGFloat, imageContentMode: UIViewContentMode) {
    imageViews.removeAll()
    self.contentSize = CGSize(width: (imageWidth + speace) * CGFloat(imageURLs.count), height: imageHeight)
    for i in 0 ..< imageURLs.count {
      let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * (imageWidth + speace), y: 0, width: imageWidth, height: imageHeight))
      
      self.addSubview(imageView)
      
      imageView.sd_setImage(with: URL(string: imageURLs[i]), placeholderImage: UIImage(named: "loading"))
      imageView.isUserInteractionEnabled = true
      imageView.contentMode = imageContentMode
      
      let button = UIButton(type: .custom)
      button.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
      button.tag = 200 + i
      button.addTarget(self, action: #selector(lookImage(_:)), for: .touchUpInside)
      imageView.addSubview(button)
      imageViews.append(imageView)
    }
  }
  
  
  func lookImage(_ button: UIButton) {
    YQDelegate?.lookImage(imageViews: imageViews, currenIndex: button.tag - 200)
  }
  
  func deleteImage(_ button: UIButton) {
    
    let index = button.tag - 100
    self.imageViews[index].removeFromSuperview()
    currentImages.remove(at: index)
    UIView.animate(withDuration: 0.2, animations: {
      for i in index ..< self.imageViews.count {
        let imageView = self.imageViews[i]
        imageView.frame.origin.x -= (self.imageWidth + self.speace)
      }
      self.YQDelegate?.currentImags!(images: self.currentImages)
    }) { (bool) in
      
      for imageView in self.imageViews {
        imageView.removeFromSuperview()
      }
      self.showImages = self.currentImages
    }
  }
  
  
  func currentImags(images: [UIImage]) {
    
  }
  
  
  func lookImage(imageViews: [UIImageView], currenIndex: Int) {
    
  }
}




