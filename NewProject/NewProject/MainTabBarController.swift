//
//  MainTabBarController.swift
//  JeromeYoutube
//
//  Created by JEROME on 2019/9/18.
//  Copyright © 2019 jerome. All rights reserved.
//

import UIKit

struct UITabBarItemInfo {
  var title: String?
  var image: UIImage?
  var selectedImage: UIImage?
}

class MainTabBarController: UITabBarController {
  
  let main = VideoCoordinator()
  let tabBarItemInfos: [UITabBarItemInfo] = [UITabBarItemInfo(title: "List", image: nil, selectedImage: nil)]
  
  // 呼叫順序 T -> TabBarController; N -> NacigationController; V -> ViewController
  // ViewDidLoad -> ViewDidAppeard
  // T N V    -> T N V
  override func viewDidLoad() {
    super.viewDidLoad()
    viewControllers = [main.navigationController]
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    guard let items = tabBar.items else {
      fatalError()
    }
    assert(tabBarItemInfos.count == items.count)
    for (index, item) in items.enumerated() {
      item.title = tabBarItemInfos[index].title
      item.image = tabBarItemInfos[index].image
      item.selectedImage = tabBarItemInfos[index].selectedImage
    }
  }
}
