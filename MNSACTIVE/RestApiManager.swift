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
  let baseURL = "http://private-25b0c4-schnap.apiary-mock.com/users"
  
  func getRandomUser(onCompletion: (JSON) -> Void) {
    let route = baseURL
    makeHTTPGetRequest(route, onCompletion: { json, err in
      onCompletion(json as JSON)
    })
  }
  
  func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
    let request = NSMutableURLRequest(URL: NSURL(string: path)!)
    
    let session = NSURLSession.sharedSession()
    
    let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
      let json:JSON = JSON(data: data)
      onCompletion(json, error)
    })
    task.resume()
  }
}