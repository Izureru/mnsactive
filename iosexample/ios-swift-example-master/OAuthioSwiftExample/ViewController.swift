//
//  ViewController.swift
//  OAuthioSwiftExample
//
//  Created by Antoine Jackson on 31/10/14.
//  Copyright (c) 2014 OAuth.io. All rights reserved.
//

import UIKit

class ViewController: UIViewController, OAuthIODelegate {
    @IBOutlet var login_button: UIButton!
    @IBOutlet var request_button: UIButton!
    @IBOutlet var logout_button: UIButton!
    
    @IBOutlet var name_label: UILabel!
    @IBOutlet var status_label: UILabel!
    
    var oauth_modal: OAuthIOModal? = nil
    var request_object: OAuthIORequest? = nil
    var data = NSMutableData()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.oauth_modal = OAuthIOModal(key: "G8F0X65uWDu3ZX-zOU_10eK7Jug", delegate: self)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Click(sender: UIButton) {
        if sender == self.login_button {
            self.status_label.text = "Logging in with Fitbit"
            var options = NSMutableDictionary()
            options.setValue("true", forKey: "cache")
            self.oauth_modal?.showWithProvider("fitbit", options: options as [NSObject : AnyObject])
        }
        if sender == self.request_button {
          
          var error: NSError
          self.request_object?.get("https://api.fitbit.com/1/user/-/activities/goals/daily.json", success: { (ResponseDictionary, Response, httpResponse) -> Void in
            
            if let responseStr = Response as? String
            {
              var outputdic = self.convertStringToDictionary(responseStr)
              
            }
//            var json: [NSObject: AnyObject] = NSJSONSerialization.dataWithJSONObject(objectData, options: NSJSONReadingMutableContainers, error: &error)
            
// convert json string to nsdictionary
            
          })
            } else {
                self.status_label.text = "Not logged in"
            }
      
        if sender == self.logout_button {
            var cache_available = self.oauth_modal?.cacheAvailableForProvider("fitbit")
            if cache_available! {
                self.oauth_modal?.clearCache()
                self.status_label.text = "Logged out"
            } else {
                self.status_label.text = "Not logged in"
            }
        }
    }

  func convertStringToDictionary(text: String) -> [String:String]? {
    if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
      var error: NSError?
      let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as? [String:String]
      if error != nil {
        println(error)
      }
      return json
    }
    return nil
  }
  
  
    func didReceiveOAuthIOResponse(request: OAuthIORequest!) {
        var cred: NSDictionary = request.getCredentials()
        println(cred.objectForKey("oauth_token"))
        println(cred.objectForKey("oauth_token_secret"))
        self.status_label.text = "Logged in with Twitter"
        self.request_object = request
        println(request)
    }
    
    func didFailWithOAuthIOError(error: NSError!) {
        self.status_label.text = "Could not login with twitter"
    }

    
    func didFailAuthenticationServerSide(body: String!, andResponse response: NSURLResponse!, andError error: NSError!) {
        
    }
    
    func didAuthenticateServerSide(body: String!, andResponse response: NSURLResponse!) {
        
    }
    
    func didReceiveOAuthIOCode(code: String!) {
        
    }
// delegate methods for nsurl connection
  func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
    println("didReceiveResponse")
  }
  
  func connection(connection: NSURLConnection, didFailWithError error: NSError) {
    println(error.localizedDescription)
  }

  func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
    self.data.appendData(conData)
  }

  func connectionDidFinishLoading(connection: NSURLConnection!) {
    println(self.data)
  }


}
