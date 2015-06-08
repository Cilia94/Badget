//
//  Student.swift
//  SaveTheDate
//
//  Created by Frederik Jacques on 21/04/15.
//  Copyright (c) 2015 Devine. All rights reserved.
//

import UIKit

class SavedUser: NSObject, NSCoding {
    
    var id:Int
    var name:String
    var partner_id:Int
    var loc_id:Int
    
    init( id:Int, name:String, partner_id:Int, loc_id:Int ) {
        
        self.id = id
        self.name = name
        self.partner_id = partner_id
        self.loc_id = loc_id
        
        super.init()
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        println("encode object")
        aCoder.encodeObject(id, forKey:"id")
        aCoder.encodeObject(name, forKey:"name")
        aCoder.encodeObject(partner_id, forKey:"partner_id")
        aCoder.encodeObject(partner_id, forKey:"loc_id")
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObjectForKey("id") as! Int
        name = aDecoder.decodeObjectForKey("name") as! String
        partner_id = aDecoder.decodeObjectForKey("partner_id") as! Int
        loc_id = aDecoder.decodeObjectForKey("loc_id") as! Int
        super.init()
    }
    
}
