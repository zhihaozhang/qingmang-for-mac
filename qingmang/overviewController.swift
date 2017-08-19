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
    
    @IBAction func firstPage(_ sender: Any) {
        changeTheme("p2557")
    }
    @IBAction func people(_ sender: Any) {
        changeTheme("p3023")
    }
    @IBAction func news(_ sender: Any) {
         changeTheme("p3029")
    }
    @IBAction func atitude(_ sender: Any) {
        changeTheme("p4318")
    }
    @IBAction func duanzi(_ sender: Any) {
        changeTheme("p4320")
    }
    @IBAction func knowledge(_ sender: Any) {
        changeTheme("p4322")
    }
    @IBAction func product(_ sender: Any) {
        changeTheme("p4324")
    }
    @IBAction func productClicked(_ sender: Any) {
        changeTheme("p4326")
    }
    @IBAction func travel(_ sender: Any) {
        changeTheme("i4928")
    }
    @IBAction func google(_ sender: Any) {
        changeTheme("i6280")
    }
 
    @IBAction func catClicked(_ sender: Any) {
        changeTheme("p2451")
    }
    
    
    
    var feed : JSON?
    
    
    func changeTheme(_ categroy_id:String){
        
        self.feed = nil
        
        self.tableview.reloadData()
        
        
        guard let splitVC = parent as? NSSplitViewController else {
            return
        }
        
        if let detail = splitVC.childViewControllers[1] as? detailViewController{
            var webContent = ""
            
            detail.changeWebContent(webContent)
        }

        
         var dataSource = "https://api.qingmang.me/v2/article.list?token=92f136746dd34370a71363f6b66a3e01&category_id="+categroy_id
        guard let url = NSURL(string: dataSource) else{return }
        guard let data = try? Data(contentsOf: url as URL) else {
            
            return
        }
        
        self.tableview.reloadData()
        
        
        let newFeed = JSON(data: data)
            self.feed = newFeed
            self.tableview.reloadData()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dataSource = "https://api.qingmang.me/v2/article.list?token=92f136746dd34370a71363f6b66a3e01&category_id=p2557"
        
        guard let url = NSURL(string: dataSource) else{return }
        guard let data = try? Data(contentsOf: url as URL) else {
            
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
        guard self.feed != nil else{
            return 0
        }
        return feed["articles"].count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.make(withIdentifier: "Cell", owner: self) as? Cell else { return nil }
        guard self.feed!["articles"][row]["title"].string != nil else {return nil}
        vw.textView?.string = ""
        vw.textView?.string = self.feed!["articles"][row]["title"].string! as! String
        
        guard self.feed!["articles"][row]["covers"][0]["url"].string != nil else {return nil}
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
            
            webContent = "<head><style>p{font-family: STKaiti} img{max-width:400px !important; height:auto;}</style></head><h2 style=\"text-align:center;font-family: STKaiti;\">"+self.feed!["articles"][row]["title"].string!+"</h2><hr style=\"height:8px;border:none;border-top:4px solid #EDEDED;\" />" + webContent
            
            detail.changeWebContent(webContent)
        }
    }
    
    
    func getWebContentAccordingToArticleID(_ articleID:String) -> String{
        var webContent = ""
        
        var dataSource = "https://api.qingmang.me/v2/article.get?token=92f136746dd34370a71363f6b66a3e01&id="+articleID
        
        guard let url = NSURL(string: dataSource) else{return webContent}
        guard let data = try? Data(contentsOf: url as URL) else {
            return webContent
        }
        let article = JSON(data: data)
        webContent = article["article"]["content"].string!
        
        return webContent
    }
    
    
    
    
    
    
    
    
}
