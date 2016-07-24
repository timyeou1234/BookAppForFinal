//
//  ViewController.swift
//  BookApp
//
//  Created by YeouTimothy on 2016/7/22.
//  Copyright © 2016年 YeouTimothy. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ViewController: UIViewController {
    
    var refreshControl: UIRefreshControl!
    var bookDict = [String:AnyObject]()
    var bookArr = [AnyObject]()
    
    @IBOutlet weak var bookTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookTableView.dataSource = self
        bookTableView.delegate = self
        
        bookTableView.registerNib(UINib(nibName: "BookDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        bookTableView.rowHeight = UITableViewAutomaticDimension
        bookTableView.estimatedRowHeight = 90
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(ViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        bookTableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    func refresh(sender:AnyObject) {
        let ref = FIRDatabase.database().reference()
        ref.child("Book").observeEventType(.ChildAdded, withBlock: {
            snapshot in
            
            if self.bookDict[snapshot.key] == nil{
                self.bookDict[snapshot.key] = snapshot.value
                
                self.bookArr.append(snapshot.value!)
                print(self.bookDict)
                
                
                //                self.sortArray(self.bookArr)
                self.bookTableView.reloadData()
            }
            
        })
        //        for i in 0...3{
        //            ref.child("Book").child(String(i)).setValue(["publisherGlocation": "新竹市富群街"])
        //        }
        

    }
        
        
        
        
    
    
    override func viewWillAppear(animated: Bool) {
            self.refresh(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sortArray(Array:[AnyObject]){
        //        if Array.count > 2{
        //            var ansArray = [AnyObject]()
        //            for _ in 0...Array.count - 1{
        //                ansArray.append(["a":"b"])
        //            }
        //            var position = 0
        //            var i = 0
        //            var smallerThan = 0
        //            while  i < Array.count {
        //                for y in 0...Array.count-1{
        //                    if (bookArr[i].objectForKey("name") as! String) > (bookArr[y].objectForKey("name") as! String){
        //                        smallerThan += 1
        //                    }else if (bookArr[i].objectForKey("name") as! String) == (bookArr[y].objectForKey("name") as! String){
        //                        smallerThan -= 1
        //                    }
        //                }
        //                position = bookArr.count - smallerThan - 1
        //                ansArray[position] = bookArr[i]
        //                i += 1
        //                position = 0
        //                smallerThan = 0
        //            }
        //            bookArr = ansArray
        var i = 0
        while i < bookArr.count-2 {
            for x in 0...bookArr.count-1{
                if bookArr[i].objectForKey("name") as? String == bookArr[x].objectForKey("name") as? String && i != x{
                    bookArr.removeAtIndex(i)
                    
                    break
                }else{
                }
            }
            i += 1
            //                if (bookArr[i+1].objectForKey("name") as? String) != nil && (bookArr[i+1].objectForKey("name") as? String) == nil {
            //                if (bookArr[i].objectForKey("name") as! String) == (bookArr[i+1].objectForKey("name") as! String){
            //                    bookArr.removeAtIndex(i)
            //                }else{
            //                    i += 1
            //                    }
            //                }else{
            //                    i += 1
            //                }
        }
        
        self.bookTableView.reloadData()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailSegue"{
            let indexPath = sender as! NSIndexPath
            let destVc = segue.destinationViewController as! BookPageViewController
            destVc.book = bookArr[indexPath.row] as! [String: String]
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetailSegue", sender: indexPath)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = bookTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! BookDetailTableViewCell
        
        let book = bookArr[indexPath.row] as! [String:String]
        cell.nameLable.text = book["name"]
        print(book["photoUrl"])
        if let _ = book["photoUrl"]{
            let url = NSURL(string: book["photoUrl"]!)
            cell.bookImage.sd_setImageWithURL(url)
        }
        cell.corpmeLable.text = book["publisher"]
        
        return cell
    }
    
}