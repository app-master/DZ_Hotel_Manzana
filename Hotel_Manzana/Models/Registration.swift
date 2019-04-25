//
//  Registration.swift
//  Hotel_Manzana
//
//  Created by user on 22/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import Foundation

struct Registration {
    
    var firstName: String
    var lastName: String
    var email: String
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    var isWiFi: Bool
    var roomType: RoomType
    
}

extension Registration {
    
    static func calculateWiFiCost(fromDate: Date, toDate: Date) -> Int {
        
        let dateComponents = Calendar.current.dateComponents([Calendar.Component.day], from: fromDate, to: toDate)
        
        guard let day = dateComponents.day else { return 0}
        
        return day * 10
    }
    
}
