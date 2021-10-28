//
//  Color.swift
//  RightOnTarget
//
//  Created by Pavel Yarovoi on 27.10.2021.
//

import Foundation
import UIKit

extension UIColor {
    convenience init?(hex: String) {
        let hexColorCode = hex.replacingOccurrences(of: "#", with: "")
        
        var channelR: CGFloat = 0.0
        var channelG: CGFloat = 0.0
        var channelB: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        var hexNumber: UInt64 = 0
        
        guard Scanner(string: hexColorCode).scanHexInt64(&hexNumber) else {
            return nil
        }
        
        if hexColorCode.count == 8 {
            channelR = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            channelG = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            channelB = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            alpha = CGFloat(hexNumber & 0x000000ff) / 255
        } else if hexColorCode.count == 6 {
            channelR = CGFloat((hexNumber & 0xff000000) >> 16) / 255
            channelG = CGFloat((hexNumber & 0x00ff0000) >> 8) / 255
            channelB = CGFloat(hexNumber & 0x0000ff00) / 255
        } else {
            return nil
        }
        
        self.init(red: channelR, green: channelG, blue: channelB, alpha: alpha)
    }
    
    func asHexColorCode() -> String {
        let colorComponents = self.cgColor.components
        let channelR: CGFloat = colorComponents?[0] ?? 0.0
        let channelG: CGFloat = colorComponents?[1] ?? 0.0
        let channelB: CGFloat = colorComponents?[2] ?? 0.0
        var alpha: CGFloat = 1.0
        if colorComponents?.count == 4 {
            alpha = colorComponents?[3] ?? 1.0
        }
        
        
        let hexColorCode = String(format: "#%02lX%02lX%02lX%02lX", lroundf(Float(channelR) * 255), lroundf(Float(channelG) * 255), lroundf(Float(channelB) * 255), lroundf(Float(alpha) * 255))
        return hexColorCode.lowercased()
    }
    
}
