//
//  KeyboardViewController.swift
//  keyboard
//
//  Created by main on 2019/02/11.
//  Copyright © 2019 lam7. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var displayButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nextKeyboardButton = UIButton(type: .system)
        self.view.addSubview(self.nextKeyboardButton)
        // Perform custom UI setup here
        self.nextKeyboardButton.setTitle("次", for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        self.displayButton = UIButton(type: .system)
        self.view.addSubview(self.displayButton)
        self.displayButton.setTitle("表示", for: [])
        self.displayButton.sizeToFit()
        self.displayButton.translatesAutoresizingMaskIntoConstraints = false
        self.displayButton.addTarget(self, action: #selector(displayView), for: .allTouchEvents)
        self.displayButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.displayButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @objc func displayView(){
        let collectionKeyboardView = CollectionKeyboardView(frame: view.bounds)
        collectionKeyboardView.words = [
            ["👌","👽", "👌","👌","👽", "👌","👌","👽", "👌","👌","👽", "👌","👌","👽", "👌","👌","👽", "👌"],
            ["😺", "🐶", "😍"],
            ["😺", "🐶"],
        ]
        collectionKeyboardView.didTap = { text in
            self.textDocumentProxy.insertText(text)
        }
        view.addSubview(collectionKeyboardView)
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
