//
//  OTPResponse.swift
//  Gurukul Publications
//
//  Created by Ramakant on 29/09/23.
//

import Foundation
import ObjectMapper

class OTPResponse: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        otp <- map["otp"]
        authToken <- map["authToken"]
    }
    
    var description: String {
        get {
            return Mapper().toJSONString(self, prettyPrint: false)!
        }
    }
    
    let transform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
        // transform value from String? to Int?
        return Int(value!)
    }, toJSON: { (value: Int?) -> String? in
        // transform value from Int? to String?
        if let value = value {
            return String(value)
        }
        return nil
    })
    
    lazy var otp = String()
    lazy var authToken = String()
    
}
