//
//  ComposeSessionViewController.swift
//  AttachmentReminder
//
//  Created by Jonas Sannewald on 02.07.22.
//

import MailKit

class ComposeSessionViewController: MEExtensionViewController {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var titleDescription: NSTextField!
    
    private let composeSessionHandler: ComposeSessionHandler
    private let composeSession: MEComposeSession
    
    
    // MARK: - Initializers
    
    init(composeSessionHandler: ComposeSessionHandler, composeSession: MEComposeSession) {
        self.composeSessionHandler = composeSessionHandler
        self.composeSession = composeSession
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    
    // MARK: - AppKit Lifecycle Methods
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        guard let isAttachmentMissing = self.composeSessionHandler.isAttachmentMissing(for: self.composeSession) else {
            return self.showError()
        }
                
        if isAttachmentMissing {
            self.showAttachmentIsMissing()
        } else {
            self.showAttachmentIsNotMissing()
        }
    }
    
    
    // MARK: - Features of ComposeSessionViewController
    
    private func showAttachmentIsMissing() {
        self.imageView.image = NSImage(systemSymbolName: "xmark.seal.fill", accessibilityDescription: nil)
        self.titleDescription.stringValue = "Attachment missing"
    }
    
    private func showAttachmentIsNotMissing() {
        self.imageView.image = NSImage(systemSymbolName: "checkmark.seal.fill", accessibilityDescription: nil)
        self.titleDescription.stringValue = "No attachment missing"
    }
    
    private func showError() {
        self.imageView.image = NSImage(systemSymbolName: "exclamationmark.triangle.fill", accessibilityDescription: nil)
        self.titleDescription.stringValue = "Error: no analysis possible"
    }
    

}
