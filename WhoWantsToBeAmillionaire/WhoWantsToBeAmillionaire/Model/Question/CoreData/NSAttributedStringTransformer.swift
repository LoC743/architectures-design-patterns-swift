//
//  NSAttributedStringTransformer.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 26.02.2021.
//

import Foundation

@objc(NSAttributedStringTransformer)
class NSAttributedStringTransformer: NSSecureUnarchiveFromDataTransformer {
    override class var allowedTopLevelClasses: [AnyClass] {
        return super.allowedTopLevelClasses + [NSAttributedString.self]
    }
}
