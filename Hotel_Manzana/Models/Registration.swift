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
