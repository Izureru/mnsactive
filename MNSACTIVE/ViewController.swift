//
//  ViewController.swift
//  MNSACTIVE
//
//  Created by Izureru on 12/06/2015.
//  Copyright (c) 2015 Marks and Spencer. All rights reserved.
//

import UIKit
import OAuthSwift

var authtk:String =  "xxxxxx"
var authtksct:String =  "zzzzz"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var tableView:UITableView?
  var items = NSMutableArray()
  
  override func viewWillAppear(animated: Bool) {
    let frame:CGRect = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height-100)
    self.tableView = UITableView(frame: frame)
    self.tableView?.dataSource = self
    self.tableView?.delegate = self
    self.view.addSubview(self.tableView!)
    
    let btn = UIButton(frame: CGRect(x: 0, y: 25, width: self.view.frame.width, height: 50))
    btn.backgroundColor = UIColor.cyanColor()
    btn.setTitle("Add new Dummy", forState: UIControlState.Normal)
    btn.addTarget(self, action: "addDummyData", forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(btn)
    
    // OAuth1.0
    let oauthswift = OAuth1Swift(
      consumerKey:    "1ff195784e64fba8bd4b721de69e1fc6",
      consumerSecret: "bd08bade4be43408bb6aa08ee5d644f6",
      requestTokenUrl: "https://api.fitbit.com/oauth/request_token",
      authorizeUrl:    "https://www.fitbit.com/oauth/authorize",
      accessTokenUrl:  "https://api.fitbit.com/oauth/access_token"
    )
    
    oauthswift.authorizeWithCallbackURL( NSURL(string: "oauth-swift://oauth-callback/fitbit")!, success: {
      credential, response in
      println(credential.oauth_token)
      authtk = credential.oauth_token
      authtksct = credential.oauth_token_secret
      println(credential.oauth_token_secret)
      }, failure: failureHandler)
  }
  
  func failureHandler(error: NSError){
    println("ERROR has occurred \(error)")
  }
  
  func addDummyData() {
    RestApiManager.sharedInstance.getUser { json in
      let results = json["user"]
      
      for (index: String, subJson: JSON) in results {
        let attribute: AnyObject = json["user"].object
        self.items.addObject(attribute)
        println(attribute)
        dispatch_async(dispatch_get_main_queue(),{
          tableView?.reloadData()
        })
      }
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count;
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
    
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CELL")
    }
    
    let attribute:JSON =  JSON(self.items[indexPath.row])
    
    let picURL = attribute["avatar"].string
    println(picURL)
    let url = NSURL(string: picURL!)
    let data = NSData(contentsOfURL: url!)
    
    cell!.textLabel?.text = attribute["displayName"].string
    cell?.imageView?.image = UIImage(data: data!)
    
    return cell!
  }
}
