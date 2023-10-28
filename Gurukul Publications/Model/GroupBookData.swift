import ObjectMapper

class GroupBookData: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    //{"id":"1","name":"Andaman & Nicobar Islands","parent_id":null,"location_type":"STATE"},
    func mapping(map: Map) {
        book_name <- map["book_name"]
        data <- map["data"]
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
    
    lazy var book_name = String()
    lazy var data = [DataItem]()
    
}

