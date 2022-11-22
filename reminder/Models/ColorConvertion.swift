//
//  ColorConvertion.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 22/11/2022.
//

import Foundation
import SwiftUI

//https://stackoverflow.com/questions/56874133/use-hex-color-in-swiftui

extension Color {
        
        var hex: String {
            
            var components: [CGFloat]?
            
            // mac uses NSColor, iOS UIColor
            let uiColor = UIColor(self)
            components = uiColor.cgColor.components

            
            let r: CGFloat = components?[0] ?? 0.0
            let g: CGFloat = components?[1] ?? 0.0
            let b: CGFloat = components?[2] ?? 0.0
            
            let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
            
            return hexString
        }
        
        static func colorFromHex(_ hex: String) -> Color {
            
            var colorString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()
            
            let alpha: CGFloat = 1.0
            let red: CGFloat = self.colorComponentFrom(colorString: colorString, start: 0, length: 2)
            let green: CGFloat = self.colorComponentFrom(colorString: colorString, start: 2, length: 2)
            let blue: CGFloat = self.colorComponentFrom(colorString: colorString, start: 4, length: 2)
            
            let cgColor = CGColor(red: red, green: green, blue: blue, alpha: alpha)
            return Color(cgColor)
        }
        
        static func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {

            let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
            let endIndex = colorString.index(startIndex, offsetBy: length)
            let subString = colorString[startIndex..<endIndex]
            let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
            var hexComponent: UInt64 = 0
            
            guard Scanner(string: String(fullHexString)).scanHexInt64(&hexComponent) else {
                return 0
            }

            let hexFloat: CGFloat = CGFloat(hexComponent)
            let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
            
            return floatValue
        }
}

//
//extension Color {
//    init(hex: UInt, alpha: Double = 1) {
//        self.init(
//            .sRGB,
//            red: Double((hex >> 16) & 0xff) / 255,
//            green: Double((hex >> 08) & 0xff) / 255,
//            blue: Double((hex >> 00) & 0xff) / 255,
//            opacity: alpha
//        )
//    }
//}

//extension Color {
//    init(hex: Int, opacity: Double = 1.0) {
//        let red = Double((hex & 0xff0000) >> 16) / 255.0
//        let green = Double((hex & 0xff00) >> 8) / 255.0
//        let blue = Double((hex & 0xff) >> 0) / 255.0
//        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
//    }
//}
//Usage:
//
//Text("Hello World!")
//    .background(Color(hex: 0xf5bc53))
//
//Text("Hello World!")
//    .background(Color(hex: 0xf5bc53, opacity: 0.8))


//hackingwithswift

//init?(hex: String) {
//    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
//    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
//
//    var rgb: UInt64 = 0
//
//    var red: Double = 0.0
//    var green: Double = 0.0
//    var blue: Double = 0.0
//    var opacity: Double = 1.0
//
//    let length = hexSanitized.count
//
//    guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
//
//    if length == 6 {
//        red = Double((rgb & 0xFF0000) >> 16) / 255.0
//        green = Double((rgb & 0x00FF00) >> 8) / 255.0
//        blue = Double(rgb & 0x0000FF) / 255.0
//
//    } else if length == 8 {
//        red = Double((rgb & 0xFF000000) >> 24) / 255.0
//        green = Double((rgb & 0x00FF0000) >> 16) / 255.0
//        blue = Double((rgb & 0x0000FF00) >> 8) / 255.0
//        opacity = Double(rgb & 0x000000FF) / 255.0
//
//    } else {
//        return nil
//    }
//
//    self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
//}
//
