
import ObjectMapper

class Login: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        id <- map[WebConstants.ID]
        name <- map[WebConstants.NAME]
        email <- map[WebConstants.EMAIL]
        phone <- map[WebConstants.PHONE]
        role <- map[WebConstants.ROLE]
        fullname <- map[WebConstants.FULL_NAME]
        user_type <- map[WebConstants.USER_TYPE]
        
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
    lazy var email = String()
    lazy var phone = String()
    lazy var role = String()
    lazy var fullname = String()
    lazy var user_type = String()
    
}
