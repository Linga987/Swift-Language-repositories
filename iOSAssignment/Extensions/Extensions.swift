//
//  Extensions.swift
//  iOSAssignment
//
//  Created by Lingaswami Karingula on 02/09/25.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 1) // Default to white
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
    }
}

extension UIView {
    
    func setupShadowConfiguration(cornerRadius: CGFloat = 20.0) {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor(red: 0, green: 0.692, blue: 0.724, alpha: 1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 1
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }
}

extension UIViewController {
    
    /// Show a simple toast-like alert message
    /// - Parameters:
    ///   - message: The message to display
    ///   - duration: How long the toast stays visible
    func showToast(message: String, duration: TimeInterval = 3.0) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            alert.dismiss(animated: true)
        }
    }
}
