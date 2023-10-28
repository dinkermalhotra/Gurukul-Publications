
import ObjectMapper

class StateData: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    //{"id":"1","name":"Andaman & Nicobar Islands","parent_id":null,"location_type":"STATE"},
    func mapping(map: Map) {
        id <- map[WebConstants.ID]
        name <- map[WebConstants.NAME]
        parent_id <- map[WebConstants.PARENT_ID]
        location_type <- map[WebConstants.LOCATION_TYPE]
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
    
    lazy var id = String()
    lazy var name = String()
    lazy var parent_id = String()
    lazy var location_type = String()
    
}
