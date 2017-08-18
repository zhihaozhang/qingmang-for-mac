//
//  overviewController.swift
//  qingmang
//
//  Created by Chih-Hao on 2017/8/18.
//  Copyright © 2017年 Chih-Hao. All rights reserved.
//

import Cocoa

class overviewController: NSViewController,NSTableViewDelegate,NSTableViewDataSource {
    
    @IBOutlet var tableView: NSScrollView!
    
    var article = Array<Any>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 10//article.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.make(withIdentifier: "Cell", owner: self) as? Cell else { return nil }

        
        vw.textView?.string = "在日本，这位「阿宅」政治家一直守护着二次元的创作自由"
        
        return vw


    }
    
}
