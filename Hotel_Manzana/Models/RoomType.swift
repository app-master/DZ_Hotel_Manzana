//
//  RoomType.swift
//  Hotel_Manzana
//
//  Created by user on 22/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import Foundation

typealias RoomTypes = [RoomType]

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

extension RoomTypes {
    
    static func loadRoomTypes() -> RoomTypes {
        return [RoomType(id: 0, name: "Double Queens", shortName: "2Q", price: 179),
                RoomType(id: 1, name: "One King", shortName: "1K", price: 209),
                RoomType(id: 2, name: "Penthouse", shortName: "PHS", price: 270)]
    }
    
}
