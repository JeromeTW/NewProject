//
//  StoryboardExtension.swift
//  JeromeYoutube
//
//  Created by JEROME on 2019/9/12.
//  Copyright © 2019 jerome. All rights reserved.
//

import UIKit

protocol Storyboarded {
  static func instantiate(storyboard: UIStoryboard) -> Self
}

extension Storyboarded where Self: UIViewController {
  static func instantiate(storyboard: UIStoryboard) -> Self {
    // this pulls out "MyApp.MyViewController"
    let fullName = NSStringFromClass(self)

    // this splits by the dot and uses everything after, giving "MyViewController"
    let className = fullName.components(separatedBy: ".")[1]

    // instantiate a view controller with that identifier, and force cast as the type that was requested
    return storyboard.instantiateViewController(withIdentifier: className) as! Self
  }
}
