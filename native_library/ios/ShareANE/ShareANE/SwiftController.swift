/* Copyright 2018 Tua Rua Ltd.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
import FreSwift

// https://github.com/d-silveira/flutter-share
// https://github.com/flutter/plugins/pull/970/files

public class SwiftController: NSObject {
    public static var TAG = "ShareANE"
    public var context: FreContextSwift!
    public var functionsToSet: FREFunctionMap = [:]
    
    func initController(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        return true.toFREObject()
    }
    
    func shareText(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let text = String(argv[0])
            else {
                return FreArgError(message: "shareText").getError(#file, #line, #column)
        }
        show(items: [text])
        return nil
    }
    
    func shareFile(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 3,
            let path = String(argv[0]),
            !path.isEmpty
            else {
                return FreArgError(message: "shareFile").getError(#file, #line, #column)
        }
         var items: [Any] = []
        if let mimeType = String(argv[1]) {
            if mimeType.hasPrefix("image/") {
                let image = UIImage(contentsOfFile: path)
                items.append(image as Any)
            } else {
                let url = URL.init(fileURLWithPath: path)
                items.append(url)
            }
        }
        if let subject = String(argv[2]) {
            items.append(subject)
        }
        if let text = String(argv[3]) {
            items.append(text)
        }
        show(items: items)
        return nil
    }
    
    func show(items: [Any]) {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = rootViewController.view
            rootViewController.present(activityVC, animated: true, completion: nil)
        }
    }
    
}
