//
//  ComposeSessionHandler.swift
//  AttachmentReminder
//
//  Created by Jonas Sannewald on 02.07.22.
//

import MailKit
import SwiftUI

class ComposeSessionHandler: NSObject, MEComposeSessionHandler {
    
    
    // MARK: - Enums and Structs
    
    enum ComposeSessionError: LocalizedError {
        case attachmentMissing
        case analysisNotPossible
        
        var errorDescription: String? {
            switch self {
            case .attachmentMissing:
                return "Attachment may be missing. Are you sure you want to send the email?"
            case .analysisNotPossible:
                return "An error has occurred and therefore no analysis is possible. Please check yourself if an attachment is missing."
            }
        }
    }
    
    
    // MARK: - Methods from MEComposeSessionHandler
    
    func mailComposeSessionDidBegin(_ session: MEComposeSession) {
        // Perform any setup necessary for handling the compose session
    }
    
    func mailComposeSessionDidEnd(_ session: MEComposeSession) {
        // Perform any cleanup now that the compose session is over
    }

    func viewController(for session: MEComposeSession) -> MEExtensionViewController {
        return ComposeSessionViewController(composeSessionHandler: self, composeSession: session)
    }
    
    // FIXME: Bug in MailKit (FB10533807)
    // This bug currently prevents showing a warning when an attachment is missing
    func allowMessageSendForSession(_ session: MEComposeSession) async throws {
        guard let isAttachmentMissing = self.isAttachmentMissing(for: session) else {
            throw ComposeSessionError.analysisNotPossible
        }
        
        if isAttachmentMissing {
            throw ComposeSessionError.attachmentMissing
        }
    }
    
    
    // MARK: - Features of ComposeSessionHandler
    
    func isAttachmentMissing(for session: MEComposeSession) -> Bool? {
        // FIXME: Bug in MailKit (FB10533893)
        // This bug currently prevents the implementation of the function
        
        // Reference: https://tools.ietf.org/html/rfc2822
        guard let rawData = session.mailMessage.rawData, let _ = String(data: rawData, encoding: .utf8) else {
            return nil
        }
        
        // TODO: Get the subject and check if it contains the word "attachment"
        // Workaround: session.mailMessage.subject
        
        // TODO: Get the message and check if it contains the word "attachment"
        // No public workaround
        
        // TODO: Check if an attachment already exists
        // No public workaround
        
        return nil
    }
    
    func isTheWordAttachment(in text: String) -> Bool {
        // TODO: Check word variants and other languages
        return text.contains("attachment")
    }
    
    
}
