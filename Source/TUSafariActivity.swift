//
//  TUSafariActivity.swift
//
//  Created by David Beck on 11/30/12.
//  Copyright (c) 2012 ThinkUltimate. All rights reserved.
//
//  Adapted in Swift by Thibault Vlacich
//  http://thibault.vlacich.fr
//
//  http://github.com/davbeck/TUSafariActivity
//
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//
//  - Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//  - Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
//  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
//  OF THE POSSIBILITY OF SUCH DAMAGE.
//

import UIKit

class TUSafariActivity: UIActivity {
    
    var URL: Foundation.URL?
    
    override func activityType() -> String {
        return NSStringFromClass(self.dynamicType)
    }
        
    override func activityTitle() -> String {
        let resourcesURL: Foundation.URL = Bundle(for: self.dynamicType).urlForResource("TUSafariActivity", withExtension: "bundle")!
        let bundle: Bundle = Bundle(url: resourcesURL)!
        let defaultString: String = bundle.localizedString(forKey: "Open in Safari", value: "Open in Safari", table: "TUSafariActivity")
        
        return Bundle.main.localizedString(forKey: "Open in Safari", value: defaultString, table: nil)
    }
            
    override func activityImage() -> UIImage {
        if UIImage.responds(to: Selector("imageNamed:inBundle:compatibleWithTraitCollection:")) {
            return UIImage(named: "TUSafariActivity.bundle/safari", in: Bundle(for: self.dynamicType), compatibleWith: nil)!
        } else {
            // because pre iOS 8 doesn't allow embeded frameworks, our bundle will always be the main bundle
            return UIImage(named:"TUSafariActivity.bundle/safari-7")!
        }
    }
                
    override func canPerform(withActivityItems activityItems: [AnyObject]) -> Bool {
        for activityItem in activityItems {
            if activityItem is Foundation.URL && UIApplication.shared().canOpenURL(activityItem as! Foundation.URL) {
                return true
            }
        }
    
        return false;
    }
    
    override func prepare(withActivityItems activityItems: [AnyObject]) {
        for activityItem in activityItems {
            if activityItem is Foundation.URL {
                self.URL = activityItem as? Foundation.URL
            }
        }
    }
    
    override func perform() -> Void {
        guard let url = self.URL else {
            self.activityDidFinish(true)
            return
        }
        
        let completed = UIApplication.shared().openURL(url)

        self.activityDidFinish(completed)
    }
}
