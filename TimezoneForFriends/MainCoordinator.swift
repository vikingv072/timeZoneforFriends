//
//  MainCoordinator.swift
//  TimezoneForFriends
//
//  Created by C02PX1DFFVH5 on 3/22/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController =  UINavigationController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        
    }
    
    func configure(friend: Friend) {
        let vc = FriendViewController.instantiate()
        vc.coordinator = self
        vc.friend = friend
        navigationController.pushViewController(vc, animated: true)
    }
    
    func updater(friend: Friend) {
        guard let vc = navigationController.viewControllers.first as? MainViewController else {
            return
        }
        vc.updater(friend: friend)
    }
    
    
}
