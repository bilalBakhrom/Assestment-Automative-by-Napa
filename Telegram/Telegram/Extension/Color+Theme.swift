//
//  Color+Theme.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import UIKit

extension UIColor {
    public struct Theme {
        public static var accent: UIColor {
            UIColor(red: 73/255, green: 138/255, blue: 208/255, alpha: 1.0)
        }
        
        public static var red: UIColor {
            UIColor(red: 237/255, green: 112/255, blue: 108/255, alpha: 1.0)
        }
        
        public static var primaryBackground: UIColor {
            UIColor(red: 26/255, green: 34/255, blue: 45/255, alpha: 1.0)
        }
        
        public static var secondaryBackground: UIColor {
            UIColor(red: 34/255, green: 47/255, blue: 62/255, alpha: 1.0)
        }
        
        public static var primaryLabel: UIColor {
            UIColor(white: 1, alpha: 1)
        }
        
        public static var secondaryLabel: UIColor {
            UIColor(red: 125/255, green: 139/255, blue: 149/255, alpha: 1.0)
        }
    }
}
