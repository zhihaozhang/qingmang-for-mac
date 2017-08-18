//
//  myScrollView.swift
//  qingmang
//
//  Created by Chih-Hao on 2017/8/18.
//  Copyright © 2017年 Chih-Hao. All rights reserved.
//

import Cocoa

class myScrollView: NSScrollView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func hitTest(_ point: NSPoint) -> NSView? {
        return nil
    }
    
    
    
    override func scrollWheel(with event: NSEvent) {
        let f = abs(event.deltaY)
        if event.deltaX == 0.0 && f>=0.01
        {
            return
        }
        else if event.deltaX == 0.0 && f==0.0
        {
            return
        }
        else{
            super.scrollWheel(with: event)
        }
    }
}
