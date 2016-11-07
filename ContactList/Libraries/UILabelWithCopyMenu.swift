//
//  UILabelWithCopyMenu.swift
//  ContactList
//
//  Created by Nishadh Shrestha on 11/10/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

import UIKit


/// Extends UILabel to support showing 'Copy' menu when the label is long-pressed.
class UILabelWithCopyMenu: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attachGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        attachGestureRecognizer()
    }
    
    func attachGestureRecognizer() {
        userInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: "showCopyMenu:"))
    }
    
    func showCopyMenu(sender: AnyObject?) {
        becomeFirstResponder()
        let menu = UIMenuController.sharedMenuController()
        if !menu.menuVisible {
            let menuBounds = CGRectMake(bounds.origin.x, bounds.origin.y, 5, 5)
            menu.setTargetRect(menuBounds, inView: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    override func copy(sender: AnyObject?) {
        let board = UIPasteboard.generalPasteboard()
        board.string = text
        let menu = UIMenuController.sharedMenuController()
        menu.setMenuVisible(false, animated: true)
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == "copy:" {
            return true
        }
        return false
    }
    
}