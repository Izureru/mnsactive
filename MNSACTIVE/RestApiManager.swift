//
//  RestApiManager.swift
//  MNSACTIVE
//
//  Created by Izureru on 12/06/2015.
//  Copyright (c) 2015 Marks and Spencer. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
  static let sharedInstance = RestApiManager()
  
//  let baseURL = "https://api.fitbit.com"
  let baseURL = "https://api.fitbit.com"
  
  func getRandomUser(onCompletion: (JSON) -> Void) {
    let route = baseURL
    makeHTTPGetRequest(route, onCompletion: { json, err in
      onCompletion(json as JSON)
    })
  }
  
  func getUser(onCompletion: (JSON) -> Void) {
    let route = baseURL + "/1/user/-/activities/steps/date/2015-06-16/1d.json"
    makeHTTPGetRequest(route, onCompletion: { json, err in
      onCompletion(json as JSON)
    })
  }

  
  func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
    let request = NSMutableURLRequest(URL: NSURL(string: path)!)
    request.addValue("OAuth oauth_consumer_key=\"1ff195784e64fba8bd4b721de69e1fc6\", oauth_nonce=\"tester\", oauth_signature=\"AGjRS3ErOKjkF2SnWXGbpBocstc%3D\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1434442823\", oauth_token=\"91c4df3acfc800c612a2caf493d051ce\", oauth_version=\"1.0\"", forHTTPHeaderField: "Authorization")
    let session = NSURLSession.sharedSession()
    
    
    
    let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
      let json:JSON = JSON(data: data)
      onCompletion(json, error)
    })
    task.resume()
  }
}



//curl -X GET -i -H 'Authorization: OAuth oauth_consumer_key="1ff195784e64fba8bd4b721de69e1fc6", oauth_nonce="tester", oauth_signature="3qYopoeMI0BlnvWamSDpBFMtqcg%3D", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1434442144", oauth_token="91c4df3acfc800c612a2caf493d051ce", oauth_version="1.0"' https://api.fitbit.com/1/user/-/activities/steps/date/2015-06-16/1d.json


//curl -X GET -i -H 'Authorization: OAuth oauth_consumer_key="1ff195784e64fba8bd4b721de69e1fc6", oauth_nonce="tester", oauth_signature="AGjRS3ErOKjkF2SnWXGbpBocstc%3D", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1434442823", oauth_token="91c4df3acfc800c612a2caf493d051ce", oauth_version="1.0"' https://api.fitbit.com/1/user/-/activities/steps/date/2015-06-16/1d.json


