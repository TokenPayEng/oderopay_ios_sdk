//
//  Untitled.swift
//  OderoPayShop
//
//  Created by Kadir Guzel on 16.12.2024.
//  Copyright © 2024 Odero Pay. All rights reserved.
//

import UIKit

extension UIColor {
    /// Converts a HEX string (e.g., "253FC3") to a UIColor object.
    /// - Parameter hex: A HEX color code string.
    convenience init?(hex: String) {
        var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanedHex = cleanedHex.hasPrefix("#") ? String(cleanedHex.dropFirst()) : cleanedHex
        
        guard cleanedHex.count == 6,
              let rgbValue = Int(cleanedHex, radix: 16) else {
            return nil
        }
        
        let red = CGFloat((rgbValue >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgbValue >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgbValue & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
