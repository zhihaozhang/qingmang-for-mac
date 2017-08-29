//
//  TodayViewController.swift
//  青芒
//
//  Created by Chih-Hao on 2017/8/29.
//  Copyright © 2017年 Chih-Hao. All rights reserved.
//

import Cocoa
import NotificationCenter
class TodayViewController: NSViewController, NCWidgetProviding,NSTableViewDelegate,NSTableViewDataSource {
    
    var feed : JSON? {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet var tableView: NSTableView!



    override var nibName: String? {
        return "TodayViewController"
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        self.preferredContentSize = CGSize(width:self.view.frame.size.width, height:190)
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView.reloadData()
        let dataSource = "https://api.qingmang.me/v2/article.list?token=92f136746dd34370a71363f6b66a3e01&category_id=p2557"
        
        getData(with: dataSource, success: { (data: Data?) in
            if let data = data {
                self.feed = JSON(data: data)
//                print(self.feed)
            }
        })

        completionHandler(.noData)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        guard let feed = self.feed else {
            return 0
        }
        guard self.feed != nil else{
            return 0
        }
        return feed["articles"].count
//        return 10
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.make(withIdentifier: "CELL1", owner: self) as? NSTableCellView else { return nil }
        guard self.feed!["articles"][row]["title"].string != nil else {return nil}
        vw.textField?.stringValue = "test"
        vw.textField?.stringValue = self.feed!["articles"][row]["title"].string! as! String
        
        
        return vw
        
        
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        print(tableView.selectedRow)
        guard  tableView.selectedRow != -1 else {
            return
        }
        let row = tableView.selectedRow
        
        NSWorkspace.shared().open(URL(string: self.feed!["articles"][row]["webUrl"].string!)!)
        
       
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


}
