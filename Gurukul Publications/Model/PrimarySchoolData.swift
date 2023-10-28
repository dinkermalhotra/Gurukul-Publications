import ObjectMapper

class PrimarySchoolData: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    //{"id":"1","name":"Andaman & Nicobar Islands","parent_id":null,"location_type":"STATE"},
    func mapping(map: Map) {
        Book_Name <- map["Book_Name"]
        RATE <- map["RATE"]
        QTY <- map["QTY"]
        Group_type <- map["Group_type"]
        book_id <- map["book_id"]
        BC_No <- map["BC_No"]
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
    
    lazy var Book_Name = String()
    lazy var RATE = String()
    lazy var QTY = String()
    lazy var Group_type = String()
    lazy var book_id = String()
    lazy var BC_No = String()
    
}

