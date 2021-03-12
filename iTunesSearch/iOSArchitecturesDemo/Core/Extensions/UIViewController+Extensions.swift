//
//  UIViewController+Extensions.swift
//  iOSArchitecturesDemo
//
//  Created by Alexey on 12.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

extension UIViewController {
    var topbarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.statusBarFrame.size.height +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        } else {
            return self.navigationController?.navigationBar.frame.height ?? 0.0
        }
    }
}
