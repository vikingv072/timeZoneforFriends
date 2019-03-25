//
//  int2TimeFormat.swift
//  TimezoneForFriends
//
//  Created by C02PX1DFFVH5 on 3/21/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import Foundation

extension Int {
    func timeString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        
        let formattedString = formatter.string(from: TimeInterval(self)) ?? "0"
        
        if formattedString == "0" {
            return "GMT+0"
        } else {
            if formattedString.hasPrefix("-") {
                return "GMT\(formattedString)"
            } else {
                return "GMT+\(formattedString)"
            }
        }
    }
    
}
