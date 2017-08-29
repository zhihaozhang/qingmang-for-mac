//
//  Cell.swift
//  Project1
//
//  Created by Chih-Hao on 2017/8/16.
//  Copyright © 2017年 Chih-Hao. All rights reserved.
//

import Cocoa

class Cell: NSTableCellView,NSTextViewDelegate {
    
    @IBOutlet var textView: NSTextView!
    @IBOutlet var imageView1: NSImageView!
        override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
            self.wantsLayer = true
        textView.font = NSFont.init(name: "华文楷体", size: 20)
       
            
        
        // Drawing code here.
    }
    
    override var backgroundStyle:NSBackgroundStyle{
        didSet{
            if backgroundStyle == .dark{
                self.layer?.backgroundColor = NSColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
            }else{
                self.layer?.backgroundColor = NSColor.white.cgColor
            }
            
        }
    }

}
