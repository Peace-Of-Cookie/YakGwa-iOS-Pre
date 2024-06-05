//
//  Date+Ext.swift
//
//
//  Created by Ekko on 6/5/24.
//

import Foundation

public extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
