//
//  UIColorExtension.swift
//  Mod
//
//  Created by JEROME on 2019/9/24.
//  Copyright © 2019 jerome. All rights reserved.
//

import UIKit

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
