//
//  overviewController.swift
//  qingmang
//
//  Created by Chih-Hao on 2017/8/18.
//  Copyright © 2017年 Chih-Hao. All rights reserved.
//

import Cocoa

class overviewController: NSViewController,NSTableViewDelegate,NSTableViewDataSource {
    
    var mywindowController : windowController? = nil
    
    
    @IBOutlet var firstPageButton: NSButton!
    @IBOutlet var button2: NSButton!
    @IBOutlet var button3: NSButton!
    @IBOutlet var button4: NSButton!
    @IBOutlet var button5: NSButton!
    @IBOutlet var button6: NSButton!
    @IBOutlet var button7: NSButton!
    @IBOutlet var button8: NSButton!
    @IBOutlet var button9: NSButton!
    @IBOutlet var button10: NSButton!
    @IBOutlet var button11: NSButton!
    
    var highlightNow: NSButton? = nil
    
    @IBOutlet var tableview: NSTableView!
    
    @IBAction func firstPage(_ sender: Any) {
        changeTheme("p2557")
        changeHighlight(sender)
        self.mywindowController?.changeHighlight(self.mywindowController?.firstPageButton)
    }
    @IBAction func people(_ sender: Any) {
        changeTheme("p3023")
        changeHighlight(sender)
        self.mywindowController?.changeHighlight(self.mywindowController?.button2)
    }
    @IBAction func news(_ sender: Any) {
        changeTheme("p3029")
        changeHighlight(sender)
        self.mywindowController?.changeHighlight(self.mywindowController?.button3)
    }
    @IBAction func atitude(_ sender: Any) {
        changeTheme("p4318")
        changeHighlight(sender)
        self.mywindowController?.changeHighlight(self.mywindowController?.button4)
        
    }
    @IBAction func duanzi(_ sender: Any) {
        changeTheme("p4320")
        changeHighlight(sender)
        self.mywindowController?.changeHighlight(self.mywindowController?.button5)
    }
    @IBAction func knowledge(_ sender: Any) {
        changeTheme("p4322")
        changeHighlight(sender)
        self.mywindowController?.changeHighlight(self.mywindowController?.button6)
    }
    @IBAction func product(_ sender: Any) {
        changeTheme("p4324")
        changeHighlight(sender)
        self.mywindowController?.changeHighlight(self.mywindowController?.button7)
    }
    @IBAction func productClicked(_ sender: Any) {
        changeTheme("p4326")
        changeHighlight(sender)
        self.mywindowController?.changeHighlight(self.mywindowController?.button8)
    }
    @IBAction func travel(_ sender: Any) {
        changeTheme("i4928")
        changeHighlight(sender)
        self.mywindowController?.changeHighlight(self.mywindowController?.button9)
    }
    @IBAction func google(_ sender: Any) {
        changeTheme("i6280")
        changeHighlight(sender)
        self.mywindowController?.changeHighlight(self.mywindowController?.button10)
    }
    
    @IBAction func catClicked(_ sender: Any) {
        changeTheme("p2451")
        changeHighlight(sender)
        self.mywindowController?.changeHighlight(self.mywindowController?.button11)
    }
    
    func changeHighlight(_ sender:Any){
        
        highlightNow?.state = NSOffState
        var sender1 = sender as! NSButton
        sender1.state = NSOnState
        highlightNow = sender1
    }
    
    
    @IBOutlet var categoryView: NSView!
    
    
    var feed : JSON? {
        didSet {
            tableview.reloadData()
        }
    }
    
    
    func changeTheme(_ categroy_id:String){
        
        self.feed = nil
        
        guard let splitVC = parent as? NSSplitViewController else {
            return
        }
        
        if let detail = splitVC.childViewControllers[1] as? detailViewController{
            let webContent = ""
            
            detail.changeWebContent(webContent)
        }
        
        
        let dataSource = "https://api.qingmang.me/v2/article.list?token=92f136746dd34370a71363f6b66a3e01&category_id="+categroy_id
        
        getData(with: dataSource, success: { (data: Data?) in
            if let data = data {
                self.feed = JSON(data: data)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mywindowController = NSApplication.shared().windows[0].windowController as? windowController
        print(self.mywindowController)
        
        
        highlightNow = firstPageButton
        
        categoryView.wantsLayer = true
        categoryView.layer?.backgroundColor = NSColor(red: 112/255, green: 128/255, blue: 144/255, alpha: 0.1).cgColor
        
        let dataSource = "https://api.qingmang.me/v2/article.list?token=92f136746dd34370a71363f6b66a3e01&category_id=p2557"
        
        getData(with: dataSource, success: { (data: Data?) in
            if let data = data {
                self.feed = JSON(data: data)
            }
        })
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
            
            webContent = "<head><style>p{font-family: STKaiti} img{max-width:400px !important; height:auto;} body,html{overflow-x:hidden;} p{font-size:20px}</style></head><h2 style=\"text-align:center;font-family: STKaiti;\">"+self.feed!["articles"][row]["title"].string!+"</h2><hr style=\"height:8px;border:none;border-top:4px solid #EDEDED;\" /><body> \(webContent)</body>"
            
            detail.url = NSURL(string:getArticleURL((self.feed!["articles"][row]["articleId"].string as? String)!))
            
            detail.articleName = getArticleName((self.feed!["articles"][row]["articleId"].string as? String)!)
            
            detail.changeWebContent(webContent)
        }
    }
    
    
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return MyNSTableRowView()
    }
    
    func getArticleURL(_ articleID:String) -> String{
        var articleURL = ""
        
        var dataSource = "https://api.qingmang.me/v2/article.get?token=92f136746dd34370a71363f6b66a3e01&id="+articleID
        
        
        guard let url = NSURL(string: dataSource) else{return articleURL}
        guard let data = try? Data(contentsOf: url as URL) else {
            return articleURL
        }
        let article = JSON(data: data)
        articleURL = article["article"]["webUrl"].string!
        
        
        return articleURL
    }
    
    func getArticleName(_ articleID:String) -> String{
        var articleName = ""
        
        var dataSource = "https://api.qingmang.me/v2/article.get?token=92f136746dd34370a71363f6b66a3e01&id="+articleID
        
        
        guard let url = NSURL(string: dataSource) else{return articleName}
        guard let data = try? Data(contentsOf: url as URL) else {
            return articleName
        }
        let article = JSON(data: data)
        articleName = article["article"]["title"].string!
        
        return articleName
    
    
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

func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
    return MyNSTableRowView()
}

class MyNSTableRowView: NSTableRowView {
    
    override func drawSelection(in dirtyRect: NSRect) {
        if self.selectionHighlightStyle != .none {
            let selectionRect = NSInsetRect(self.bounds, 2.5, 2.5)
            NSColor(calibratedWhite: 0.65, alpha: 1).setStroke()
            NSColor(calibratedWhite: 0.82, alpha: 1).setFill()
            let selectionPath = NSBezierPath.init(roundedRect: selectionRect, xRadius: 0, yRadius: 0)
            selectionPath.fill()
            selectionPath.stroke()
        }
    }
}


func getData(with urlString: String,success: @escaping (Data?)->Void, failure: ((Error)->Void)? = nil) {
    guard let url = URL(string: urlString) else {
        return
    }
    let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        DispatchQueue.main.async {
            if let error = error {
                failure?(error)
            } else {
                success(data)
            }
        }
    }
    task.resume()
}

