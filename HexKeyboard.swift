//
//  HexKeyboard.swift
//
//  Created by Philipp Anné on 04.11.18.
//  Copyright © 2018 Philipp Anné. All rights reserved.
//

import UIKit

class HexKeyboard: UIView, UIInputViewAudioFeedback {
    
    fileprivate weak var input: UITextInput?
    
    // MARK:~ UIInputViewAudioFeedback protocol
    
    var enableInputClicksWhenVisible: Bool {
        return true
    }
    
    // MARK:- keyboard initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    convenience init(withInput input: UITextInput) {
        
        // height 120 may or may not be a good choice
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 120))
        
        self.input = input;
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "HexKeyboard"
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    // MARK:- Button actions from .xib file
    
    @IBAction func keyTapped(sender: UIButton) {
        
        UIDevice.current.playInputClick()
        
        // misused tag for some magic values: 8 = backspace, 13 = hide keyboard
        switch sender.tag {
        case 8: 
            self.input?.deleteBackward()
            break
        case 13:
            // have not found an other working method to hide the keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            break
        default:
            self.input?.insertText(sender.titleLabel!.text!)
            break
        }
    }
}
