//
//  MailExtension.swift
//  AttachmentReminder
//
//  Created by Jonas Sannewald on 02.07.22.
//

import MailKit

class MailExtension: NSObject, MEExtension {
    
    func handler(for session: MEComposeSession) -> MEComposeSessionHandler {
        return ComposeSessionHandler()
    }
    
}
