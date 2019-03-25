//
//  Coordinator.swift
//  TimezoneForFriends
//
//  Created by C02PX1DFFVH5 on 3/22/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators : [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    func start()
    
}
