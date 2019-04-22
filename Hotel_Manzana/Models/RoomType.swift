//
//  RoomType.swift
//  Hotel_Manzana
//
//  Created by user on 22/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import Foundation

struct RoomType {
    
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
}

extension RoomType: Equatable {
    
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
    
}
