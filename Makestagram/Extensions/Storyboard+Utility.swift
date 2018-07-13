//
//  Storyboard+Utility.swift
//  Makestagram
//
//  Created by Connie Liu on 7/13/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation

import UIKit

extension UIStoryboard {
    enum MGType: String {
        case main
        case login
        var filename: String {
            return rawValue.capitalized
        }
    }
    convenience init(type: MGType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
}
