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
    var articleName :String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    func changeWebContent(_ html:String){
        
        webview.loadHTMLString(html, baseURL: nil)
        
    }
    

    @IBAction func shareClicked(_ sender: Any) {
        var articleName = self.articleName!
        var url = self.url!
        let item = "\(articleName)  \(url) 来自青芒Mac客户端"
        let picker = NSSharingServicePicker(items:[item])
        picker.show(relativeTo: .zero, of: sender as! NSView, preferredEdge: .minY)

    
    }
   
    @IBAction func openInBrowser(_ sender: Any) {
        NSWorkspace.shared().open(url as URL)
    }
    
    @IBOutlet var shareClicked: NSButtonCell!
   
    
}
