//
//  DateFormatter+Extension.swift
//  Hotel_Manzana
//
//  Created by user on 26/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static func dateFormatterShortStyle() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter
    }
    
}
