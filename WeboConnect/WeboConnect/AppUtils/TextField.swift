//
//  TextField.swift
//  WeboConnect
//
//  Created by apple on 19/04/23.
//

import Foundation
import UIKit


class TextField: UITextField {
    
    @IBInspectable var paddingLeft: CGFloat = 25.0
    @IBInspectable var paddingRight: CGFloat = 25.0
    @IBInspectable var isThematicStyleEnabled:Bool {
        get {
            return false
        }
        set {
            if newValue {
                self.addThematicStyle()
            }
        }
    }
    var padding = UIEdgeInsets()
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    private func commonInit() {
        let placeholderText = self.placeholder ?? ""
        self.attributedPlaceholder =
            NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.6)])
    }
    private func addThematicStyle() {
        self.backgroundColor = UIColor(named: "#EEEEEE")
        self.layer.cornerRadius = 7
        self.borderStyle = .none
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
    padding = UIEdgeInsets(top: 0, left: paddingLeft, bottom: 0, right: paddingRight)
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        padding = UIEdgeInsets(top: 0, left: paddingLeft, bottom: 0, right: paddingRight)
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        padding = UIEdgeInsets(top: 0, left: paddingLeft, bottom: 0, right: paddingRight)
      return bounds.inset(by: padding)
    }
}

