//
//  windowController.swift
//  qingmang
//
//  Created by Chih-Hao on 2017/8/18.
//  Copyright © 2017年 Chih-Hao. All rights reserved.
//

import Cocoa

class windowController: NSWindowController {

    @IBOutlet var firstPage: NSButton!
    
    @IBOutlet var firstPageButton: NSButton!
   
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        window?.titleVisibility = .hidden
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        window?.backgroundColor = NSColor.white
        
        let myViewcontroller = self.window?.contentViewController as! mainViewController
         self.overviewController = myViewcontroller.childViewControllers[0] as! overviewController
        
        self.highlightNow = firstPage
        
        
        self.window?.titleVisibility = .hidden
        self.window?.titlebarAppearsTransparent = true
        self.window?.styleMask.insert(.fullSizeContentView)
        self.highlightNow? = firstPageButton
        
    }
    
    var highlightNow: NSButton? = nil
    
    var overviewController : overviewController? = nil
    
    @IBAction func getPeople(_ sender: Any) {
        changeHighlight(sender)
        self.overviewController?.people(self.overviewController?.button2)
    }
    
    @IBAction func button1clicked(_ sender: Any) {
        changeHighlight(sender)
        self.overviewController?.people(self.overviewController?.firstPageButton)
    }
    
    @IBAction func button3clicked(_ sender: Any) {
        changeHighlight(sender)
        self.overviewController?.people(self.overviewController?.button3)
    }
    
    @IBAction func button4clicked(_ sender: Any) {
        changeHighlight(sender)
        self.overviewController?.people(self.overviewController?.button4)
    }
    
    @IBAction func button5clicked(_ sender: Any) {
        changeHighlight(sender)
        self.overviewController?.people(self.overviewController?.button5)
    }
    
    @IBAction func button6clicked(_ sender: Any) {
        changeHighlight(sender)
        self.overviewController?.people(self.overviewController?.button6)
    }
    
    @IBAction func button7clicked(_ sender: Any) {
        changeHighlight(sender)
        self.overviewController?.people(self.overviewController?.button7)
    }
    
    @IBAction func button8clicked(_ sender: Any) {
        changeHighlight(sender)
        self.overviewController?.people(self.overviewController?.button8)
    }
    
    @IBAction func button9clicked(_ sender: Any) {
        changeHighlight(sender)
        self.overviewController?.people(self.overviewController?.button9)
    }
    
    @IBAction func button10clicked(_ sender: Any) {
        changeHighlight(sender)
        self.overviewController?.people(self.overviewController?.button10)
    }
    
    @IBAction func button11clicked(_ sender: Any) {
        changeHighlight(sender)
        self.overviewController?.people(self.overviewController?.button11)
    }
    
    func changeHighlight(_ sender:Any){
        
        self.highlightNow?.state = NSOffState
        var sender1 = sender as! NSButton
        sender1.state = NSOnState
        self.highlightNow = sender1 as? NSButton
    }

}
