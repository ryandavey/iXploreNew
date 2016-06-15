//
//  UserPersistence.swift
//  FastNet
//
//  Created by Julian Hulme on 2016/02/21.
//  Copyright © 2016 ArcadeSoftware. All rights reserved.
//

import Foundation


class User: NSObject, NSCoding {
    
    var firstName:String?
    
    var email:String?
    
    required init(firstName:String?, email:String?) {
        self.firstName = firstName
        self.email = email
    }
    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.firstName, forKey: "firstName")
        aCoder.encodeObject(self.email, forKey: "email")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let firstName = aDecoder.decodeObjectForKey("firstName") as? String
        let email = aDecoder.decodeObjectForKey("email") as? String
        
        self.init(firstName:firstName, email:email)
    }
}
