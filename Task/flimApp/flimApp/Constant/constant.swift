//
//  constant.swift
//  flimApp
//
//  Created by Mac on 28/07/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import UIKit

let APPNAME : String = "The FilmApp"
extension UIView
{
    func dropShadow()
    {
        // set the corner radius
        layer.masksToBounds = false
        // set the shadow properties
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
        layer.cornerRadius = 8
    }
    
}

extension UIViewController
{
    
    
    
    func showAlert(message : String)
    {
        let alertController = UIAlertController(title: APPNAME, message: message, preferredStyle: UIAlertController.Style.alert)
        
        
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            //            print("You've pressed OK Button")
        }
        
        
        
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertLeftAligned(message : String)
    {
        let alertController = UIAlertController(title: APPNAME, message: message, preferredStyle: UIAlertController.Style.alert)
        
        
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            //            print("You've pressed OK Button")
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        
        let messageText = NSMutableAttributedString(
            string: message,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        )
        
        alertController.setValue(messageText, forKey: "attributedMessage")
        
        
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithSingleOptionResponce(message : String, result:@escaping (String)->())
    {
        let alertController = UIAlertController(title: APPNAME, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            
            result("1")
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func showAlertWithOption(message : String, result:@escaping (String)->())
    {
        let alertController = UIAlertController(title: APPNAME, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            
            result("1")
        }
        
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
            result("0")
        }
        
        alertController.addAction(CancelAction)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


