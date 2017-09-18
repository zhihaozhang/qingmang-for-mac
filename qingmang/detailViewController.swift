//
//  detailViewController.swift
//  qingmang
//
//  Created by Chih-Hao on 2017/8/18.
//  Copyright © 2017年 Chih-Hao. All rights reserved.
//

import Cocoa
import WebKit
class detailViewController: NSViewController {

   
    @IBOutlet var webview: WKWebView!
    var url :NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    func changeWebContent(_ html:String){
        
        webview.loadHTMLString(html, baseURL: nil)
        
    }
    

    @IBAction func shareClicked(_ sender: Any) {
     
        
    
    }
   
    @IBAction func openInBrowser(_ sender: Any) {
        NSWorkspace.shared().open(url as URL)
    }
    
   
    
}
