
import Foundation
import Alamofire
import ObjectMapper
import Foundation

class WebServices {
    // MARK:  login Api
    class func wsCallLoginApi(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ login: [Login]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.login, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    if let result = responseValue[WebConstants.RESPONSE] as? [[String: Any]], let userDetails = Mapper<Login>().mapArray(JSONArray: result) as [Login]? {
                        completion(true, "", userDetails, userStatus)
                        
                    }
                    else {
                        var message = ""
                       
                        message = error_message

                        completion(false, message, nil,false)
                    }
                }
                else {
                    completion(false, responseData.error?.localizedDescription ?? "", nil, false)
                }
            case .failure(let error):
                completion(false, error.localizedDescription, nil, false)
            }
        })
    }
}
