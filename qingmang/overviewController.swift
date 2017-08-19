//
//  overviewController.swift
//  qingmang
//
//  Created by Chih-Hao on 2017/8/18.
//  Copyright © 2017年 Chih-Hao. All rights reserved.
//

import Cocoa

class overviewController: NSViewController,NSTableViewDelegate,NSTableViewDataSource {
    
    @IBOutlet var tableview: NSTableView!
    
    
    var feed : JSON?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dataSource = "https://api.qingmang.me/v2/article.list?token=92f136746dd34370a71363f6b66a3e01&category_id=p2557"
        
        guard let url = NSURL(string: dataSource) else{return }
        guard let data = try? Data(contentsOf: url as URL) else {
            DispatchQueue.main.async { [unowned self] in
                
            }
            return
        }
        
        let newFeed = JSON(data: data)
        
        DispatchQueue.main.async {
            
            self.feed = newFeed
            self.tableview.reloadData()
        }
        
        
        // Do view setup here.
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        guard let feed = self.feed else {
            return 0
        }
        return feed["articles"].count//article.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.make(withIdentifier: "Cell", owner: self) as? Cell else { return nil }
        
        vw.textView?.string = self.feed!["articles"][row]["title"].string as! String
        vw.imageView?.image = NSImage(byReferencing: URL(string: self.feed!["articles"][row]["covers"][0]["url"].string as! String)!)
        return vw
        
        
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        guard  tableview.selectedRow != -1 else {
            return
        }
        let row = tableview.selectedRow
        
        guard let splitVC = parent as? NSSplitViewController else {
            return
        }
        
        if let detail = splitVC.childViewControllers[1] as? detailViewController{
            var webContent = getWebContentAccordingToArticleID(self.feed!["articles"][row]["articleId"].string as! String)
            
            webContent = "<h1 style=\"text-align:center\">"+self.feed!["articles"][row]["title"].string!+"</h1><hr style=\"height:8px;border:none;border-top:4px solid #EDEDED;\" />" + webContent
            
            detail.changeWebContent(webContent)
        }
    }
    
    
    func getWebContentAccordingToArticleID(_ articleID:String) -> String{
        var webContent = ""
        
        var dataSource = "https://api.qingmang.me/v2/article.get?token=92f136746dd34370a71363f6b66a3e01&id="+articleID
        
        guard let url = NSURL(string: dataSource) else{return webContent}
        guard let data = try? Data(contentsOf: url as URL) else {
            DispatchQueue.main.async { [unowned self] in
                
            }
            return webContent
        }
        let article = JSON(data: data)
            webContent = article["article"]["content"].string!
        
        return webContent
    }
    
    
    
    
    
    
    
    
}
