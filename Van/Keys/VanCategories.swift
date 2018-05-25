//
//  VanCategories.swift
//  Van
//
//  Created by Christopher Harrison on 24/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import UIKit

enum VanCategory: String {
    case iceCream
    case fishChips
    case other
    
    var image: UIImage {
        switch self {
            case .iceCream: return #imageLiteral(resourceName: "iceCream")
            case .fishChips: return #imageLiteral(resourceName: "fishChips")
            case .other: return #imageLiteral(resourceName: "iceCream")
        }
    }
}
