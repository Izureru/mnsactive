//
//  FitbitOAuth.swift
//  MNSACTIVE
//
//  Created by Izureru on 12/06/2015.
//  Copyright (c) 2015 Marks and Spencer. All rights reserved.
//

import Foundation
import OAuthSwift


let oauthswift = OAuth1Swift(
  consumerKey:    "********",
  consumerSecret: "********",
  requestTokenUrl: "https://api.twitter.com/oauth/request_token",
  authorizeUrl:    "https://api.twitter.com/oauth/authorize",
  accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
)
oauthswift.authorizeWithCallbackURL( NSURL(string: "oauth-swift://oauth-callback/twitter"), success: {
  credential, response in
  println(credential.oauth_token)
  println(credential.oauth_token_secret)
  }, failure: failureHandler)