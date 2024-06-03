//
//  AppColor.swift
//
//
//  Created by Ekko on 6/2/24.
//

import UIKit

/// Yakgwa에서 사용되는 Color 집합
public enum AppColor: String {
    case primary100 = "Primary_100"
    
    public static func setColor(_ appColor: AppColor) -> UIColor {
        guard let palleteColor = UIColor(named: appColor.rawValue, in: Bundle.module, compatibleWith: nil) else {
            return UIColor.clear
        }
        return palleteColor
    }

    /// cgColor
    public static func setColor(_ appColor: AppColor) -> CGColor {
        guard let palleteColor = UIColor(named: appColor.rawValue, in: Bundle.module, compatibleWith: nil) else {
            return UIColor.clear.cgColor
        }
        return palleteColor.cgColor
    }
}
