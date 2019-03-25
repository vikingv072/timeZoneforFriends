//
//  StoryboarProtocol.swift
//  TimezoneForFriends
//
//  Created by C02PX1DFFVH5 on 3/22/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import UIKit

protocol StoryboarProtocol {
    static func instantiate() -> Self
}

extension StoryboarProtocol where Self: UIViewController{
    static func instantiate() -> Self {
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
