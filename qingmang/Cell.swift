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
        textView.font = NSFont.init(name: "华文楷体", size: 20)
       
            
        
        // Drawing code here.
    }
    
    
}
