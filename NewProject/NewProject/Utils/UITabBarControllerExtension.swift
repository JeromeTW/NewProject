//
//  UITabBarControllerExtension.swift
//  JeromeYoutube
//
//  Created by JEROME on 2019/9/12.
//  Copyright © 2019 jerome. All rights reserved.
//

import UIKit

struct ViewControllerInfo {
  var hasNavigation: Bool
  var viewController: UIViewController
  var tabBarItem: UITabBarItem?
}

extension UITabBarController {
  func setupViewControllers(_ viewControllerInfos: [ViewControllerInfo]) {
    var viewControllers = [UIViewController]()
    viewControllerInfos.forEach {
      let viewController = $0.viewController
      if $0.hasNavigation {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true
        navigationController.tabBarItem = $0.tabBarItem
        viewControllers.append(navigationController)
      } else {
        viewController.tabBarItem = $0.tabBarItem
        viewControllers.append(viewController)
      }
    }
    setViewControllers(viewControllers, animated: true)
  }
}
