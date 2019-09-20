//
//  Coordinator.swift
//  JeromeYoutube
//
//  Created by JEROME on 2019/9/18.
//  Copyright © 2019 jerome. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
  var navigationController: CoordinatedNavigationController { get set }
}
