//
//  ContentView.swift
//  MailAppExtensionExample
//
//  Created by Jonas Sannewald on 02.07.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("HeaderImage")
                .resizable()
                .frame(width: 100, height: 100)
            Text("The container app should never be useless!")
                .font(.title)
            List {
                Text("➡️ Guide the user how to enable the extension")
                Text("➡️ Provide access to all relevant preferences")
                Text("➡️ Introduce the latest features after an update")
                Text("➡️ Refer to your FAQ/help page and feedback form")
                Text("➡️ ...")
            }.padding()
            Button("Open Mail.app") {
                // Unfortunately, the control options of Mail App Extensions are very limited
                // None of the APIs listed below are currently available for Mail App Extensions:
                // SFSafariApplication => showPreferencesForExtension(withIdentifier:completionHandler:)
                // SFSafariExtensionManager => getStateOfSafariExtension(withIdentifier:completionHandler:)
                
                // FIXME: Feature Request (FB10534874)
                // Take a look at my SO post: https://stackoverflow.com/q/72679849/12915015
                if let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: "com.apple.mail") {
                    NSWorkspace.shared.open(url)
                }
            }
        }.frame(width: 500, height: 350).padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
