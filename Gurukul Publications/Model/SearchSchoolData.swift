//
//  SearchSchoolData.swift
//  Gurukul Publications
//
//  Created by Ramakant on 27/09/23.
//

import Foundation
import ObjectMapper

class SearchSchoolData: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    //{"id":"1","name":"Andaman & Nicobar Islands","parent_id":null,"location_type":"STATE"},
    func mapping(map: Map) {
        
        
        schMobile <- map["sch_mobile"]
        visitNo <- map["visit_no"]
        pDistrict <- map["p_district"]
        teacherMobiles <- map["teacher_mobiles"]
        schUpto <- map["sch_upto"]
        city <- map["city"]
        schEmail <- map["sch_email"]
        samplingMonth <- map["sampling_month"]
        pCity <- map["p_city"]
        partyName <- map["party_name"]
        schPhone <- map["sch_phone"]
        partyEmail <- map["party_email"]
        state <- map["state"]
        id <- map["id"]
        sellerId <- map["seller_id"]
        visitPurpose <- map["visit_purpose"]
        visitCount <- map["visit_count"]
        address <- map["address"]
        pState <- map["p_state"]
        pCategory <- map["p_category"]
        sampling <- map["sampling"]
        formId <- map["form_id"]
        purchase <- map["purchase"]
        concernName <- map["concern_name"]
        schoolName <- map["school_name"]
        partyM <- map["party_m"]
        pRemarks <- map["p_remarks"]
        visitedArea <- map["visited_area"]
        teacherNames <- map["teacher_names"]
        bose <- map["bose"]
        pAddress <- map["p_address"]
        otherPerson <- map["other_person"]
        concernM <- map["concern_m"]
        concernPerson <- map["concern_person"]
        district <- map["district"]
        partyId <- map["party_id"]
        partyPhone <- map["party_phone"]
        schCategory <- map["sch_category"]
        schStg <- map["sch_stg"]
        remarks <- map["remarks"]
        visitDate <- map["visit_date"]
        sch_branches <- map["sch_branches"]
        pincode <- map["pincode"]
        otp_email <- map["otp_email"]
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
    
         lazy var  schMobile = String()
         lazy var  visitNo = String()
         lazy var  pDistrict = String()
         lazy var  teacherMobiles = String()
         lazy var  schUpto = String()
         lazy var  city = String()
         lazy var  schEmail = String()
         lazy var  samplingMonth = String()
         lazy var  pCity = String()
         lazy var  partyName = String()
         lazy var  schPhone = String()
         lazy var  partyEmail = String()
         lazy var  state = String()
         lazy var  id = String()
         lazy var  sellerId = String()
         lazy var  visitPurpose = String()
         lazy var  visitCount = String()
         lazy var  address = String()
         lazy var  pState = String()
         lazy var  pCategory = String()
         lazy var  sampling = String()
         lazy var  formId = String()
         lazy var  purchase = String()
         lazy var  concernName = String()
         lazy var  schoolName = String()
         lazy var  partyM = String()
         lazy var  pRemarks = String()
         lazy var  visitedArea = String()
         lazy var  teacherNames = String()
         lazy var  bose = String()
         lazy var  pAddress = String()
         lazy var otherPerson = String()
         lazy var  concernM = String()
         lazy var  concernPerson = String()
         lazy var  district = String()
         lazy var  partyId = String()
         lazy var  partyPhone = String()
         lazy var  schCategory = String()
         lazy var  schStg = String()
         lazy var  remarks = String()
         lazy var  visitDate = String()
         lazy var  sch_branches = String()
         lazy var  pincode = String()
         lazy var  otp_email = String()
    
}

