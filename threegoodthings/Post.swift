//
//  Post.swift
//  threegoodthings
//
//  Created by Steven Buchko on 7/29/17.
//  Copyright © 2017 Steven Buchko. All rights reserved.
//

import Foundation

class Post {
    private var _goodThing: String!
    private var _year: String!
    private var _month: String!
    private var _day: String!
    private var _postID: String!
    
    var goodThing: String {
        return _goodThing
    }
    
    var year: String {
        return _year
    }
    
    var month: String {
        return _month
    }
    
    var day: String {
        return _day
    }
    
    var postID: String {
        return _postID
    }
    
    init(goodThing: String, date: Date) {
        self._goodThing = goodThing
        self._year = year
        self._month = month
        self._day = day
    }
    
    init(postID: String, postData: Dictionary<String, AnyObject>) {
        self._postID = postID
        
        if let goodThing = postData["goodThing"] as? String {
            self._goodThing = goodThing
        }
        
        if let year = postData["year"] as? String {
            self._year = year
        }
        
        if let month = postData["month"] as? String {
            self._month = month
        }
        
        if let day = postData["day"] as? String {
            self._day = day
        }
        
    }
}
