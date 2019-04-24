//
//  IndexPath+Extension.swift
//  Hotel_Manzana
//
//  Created by user on 24/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

extension IndexPath {

    var prevRow: IndexPath {
        return IndexPath(row: self.row - 1, section: self.section)
    }
    
}
