//
//  StringExtension.swift
//  Van
//
//  Created by Christopher Harrison on 24/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

extension String {
    
    func vanCategory() -> VanCategory {
        switch self {
        case VanCategory.iceCream.rawValue : return VanCategory.iceCream
        case VanCategory.fishChips.rawValue : return VanCategory.fishChips
        default : return VanCategory.other
        }
    }
    
}
