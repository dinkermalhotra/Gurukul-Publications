//
//  PartyData.swift
//  Gurukul Publications
//
//  Created by Ramakant on 28/09/23.
//

import Foundation
import ObjectMapper

class PartyData: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    //{"id":"1","name":"Andaman & Nicobar Islands","parent_id":null,"location_type":"STATE"},
    func mapping(map: Map) {
        
       pSamplingMonth <- map["p_sampling_month"]
       pEtt <- map["p_ett"]
       pDistrict <- map["p_district"]
       address <- map["address"]
       pState <- map["p_state"]
       pCategory <- map["p_category"]
       visitedOn <- map["visited_on"]
       concernName <- map["concern_name"]
       partyM <- map["party_m"]
       pRemarks <- map["p_remarks"]
       createdAt <- map["created_at"]
       pVisitPurpose <- map["p_visit_purpose"]
       pSampling <- map["p_sampling"]
       pCity <- map["p_city"]
       partyName <- map["party_name"]
       concernM <- map["concern_m"]
       concernPerson <- map["concern_person"]
       partyEmail <- map["party_email"]
       partyPhone <- map["party_phone"]
       id <- map["id"]
       sellerId <- map["seller_id"]
       pOrderImages <- map["p_order_images"]
       visitDate <- map["visit_date"]
       pDiscount <- map["p_discount"]
        p_pincode <- map["p_pincode"]
        p_visit_purpose_remarks <- map["p_visit_purpose_remarks"]
        p_otp_email <- map["p_otp_email"]
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
    
         lazy var  pSamplingMonth = String()
         lazy var  pEtt = String()
         lazy var  pDistrict = String()
         lazy var  address = String()
         lazy var  pState = String()
         lazy var  pCategory = String()
         lazy var  visitedOn = String()
         lazy var  concernName = String()
         lazy var  partyM = String()
         lazy var  pRemarks = String()
         lazy var  createdAt = String()
         lazy var  pVisitPurpose = String()
         lazy var  pSampling = String()
         lazy var  pCity = String()
         lazy var  partyName = String()
         lazy var  concernM = String()
         lazy var  concernPerson = String()
         lazy var  partyEmail = String()
         lazy var  partyPhone = String()
         lazy var  id = String()
         lazy var  sellerId = String()
         lazy var  pOrderImages = String()
         lazy var  visitDate = String()
         lazy var  pDiscount = String()
    lazy var p_pincode = String()
    lazy var p_visit_purpose_remarks = String()
    lazy var p_otp_email = String()
    
}
