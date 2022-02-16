//
//  SafariWebExtensionHandler.swift
//  Shared (Extension)
//
//  Created by Tema Sysoev on 16.02.2022.
//

import SafariServices
import os.log

let SFExtensionMessageKey = "message"

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
        let item = context.inputItems[0] as! NSExtensionItem
        let message = item.userInfo?[SFExtensionMessageKey]
        os_log(.default, "Received message from browser.runtime.sendNativeMessage: %@", message as! CVarArg)

        let response = NSExtensionItem()
        response.userInfo = [ SFExtensionMessageKey: [ "Response to": message ] ]

        context.completeRequest(returningItems: [response], completionHandler: nil)
    }
    func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        print("The extension's toolbar item was clicked")

        window.getActiveTab(completionHandler: { (activeTab) in
            activeTab?.getActivePage(completionHandler:  { (activePage) in
                activePage?.dispatchMessageToScript(withName: "toolbarItemClicked", userInfo: nil)

            })
        })
    }
}
