
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
    
    // MARK:  getAllINDStates Api
    class func getAllINDStates(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ stateData: [StateData]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.getAllINDStates, method: .get, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    if let result = responseValue[WebConstants.RESPONSE] as? [[String: Any]], let stateDataDetails = Mapper<StateData>().mapArray(JSONArray: result) as [StateData]? {
                        completion(true, "", stateDataDetails, userStatus)
                        
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
    
    // MARK:  getStateDistrict Api params state_id
    class func getDistrictState(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ stateData: [StateData]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.getStateDistrict, method: .get, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    if let result = responseValue[WebConstants.RESPONSE] as? [[String: Any]], let stateDataDetails = Mapper<StateData>().mapArray(JSONArray: result) as [StateData]? {
                        completion(true, "", stateDataDetails, userStatus)
                        
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
    
    // MARK: //getDistrictCity //district_id
    
    class func getDistrictCity(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ stateData: [StateData]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.getDistrictCity, method: .get, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    if let result = responseValue[WebConstants.RESPONSE] as? [[String: Any]], let stateDataDetails = Mapper<StateData>().mapArray(JSONArray: result) as [StateData]? {
                        completion(true, "", stateDataDetails, userStatus)
                        
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
    
    //MARK: // getAllSampleBooks
    
    class func getAllSampleBooks(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ bookData: [PrimarySchoolData]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.getAllSampleBooks, method: .get, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    if let result = responseValue[WebConstants.RESPONSE] as? [[String: Any]], let bookDataDetails = Mapper<PrimarySchoolData>().mapArray(JSONArray: result) as [PrimarySchoolData]? {
                        completion(true, "", bookDataDetails, userStatus)
                        
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
    
    //MARK: // getPrimarySampleBooks
    
    class func getPrimarySampleBooks(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ bookData: [PrimarySchoolData]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.getPrimarySampleBooks, method: .get, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    if let result = responseValue[WebConstants.RESPONSE] as? [[String: Any]], let bookDataDetails = Mapper<PrimarySchoolData>().mapArray(JSONArray: result) as [PrimarySchoolData]? {
                        completion(true, "", bookDataDetails, userStatus)
                        
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
    
    //MARK: // getGroupSampleBooks
    class func getGroupSampleBooks(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ groupBookData: [GroupBookData]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.getGroupSampleBooks, method: .get, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    if let result = responseValue[WebConstants.RESPONSE] as? [[String: Any]], let groupBookData = Mapper<GroupBookData>().mapArray(JSONArray: result) as [GroupBookData]? {
                        completion(true, "", groupBookData, userStatus)
                        
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
    
    //MARK: - getAllSearchedSchools
    class func getAllSearchedSchools(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ schoolData: [SearchSchoolData]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.getAllSearchedSchools, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    if let result = responseValue[WebConstants.RESPONSE] as? [[String: Any]], let schoolData = Mapper<SearchSchoolData>().mapArray(JSONArray: result) as [SearchSchoolData]? {
                        completion(true, "", schoolData, userStatus)
                        
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
    
    //MARK: - getSearchedParty
    class func getSearchedParty(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ partyData: [PartyData]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.getSearchedParty, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    if let result = responseValue[WebConstants.RESPONSE] as? [[String: Any]], let partyData = Mapper<PartyData>().mapArray(JSONArray: result) as [PartyData]? {
                        completion(true, "", partyData, userStatus)
                        
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
    
    //MARK: - Send_otp_toMerchant
    class func send_otp_toMerchant(_ requestParams: [String: AnyObject],sellerID:String,amount:String,name:String, completion:@escaping (_ isSuccess: Bool, _ message: String, _ otpResponse: String?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.Send_otp_toMerchant+"/"+sellerID+"/"+amount+"/"+name, method: .get, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    print(responseValue)
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    if let result = responseValue[WebConstants.RESPONSE] as? [String: AnyObject]{
                        print(result)
                        print(result["otp"] as? String ?? "")
                        print(result["otp"] as? Int ?? 0)
                        let otp = "\(result["otp"] as? Int ?? 0)"
                        completion(true, error_message,otp,userStatus)
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
    
     //MARK: - tracking_loggin
    class func trackingLogin(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ response: [[String:AnyObject]]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.tracking_loggin, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    print(responseValue)
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    if let result = responseValue[WebConstants.RESPONSE] as? [[String: AnyObject]]{
                        print(result)
                        completion(true, error_message,result,userStatus)
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
    
    //MARK: - tracking_info
    class func trackingInfo(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ response: [[String:AnyObject]]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.tracking_info, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    print(responseValue)
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    completion(true, error_message,nil,userStatus)
                }
                else {
                    completion(false, responseData.error?.localizedDescription ?? "", nil, false)
                }
            case .failure(let error):
                completion(false, error.localizedDescription, nil, false)
            }
        })
    }
    
    
      //MARK: - tracking_loggOut
    class func trackingLogout(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ response: [String:AnyObject]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.tracking_loggOut, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    print(responseValue)
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    completion(userStatus, error_message,nil,userStatus)
                    
                }
                else {
                    completion(false, responseData.error?.localizedDescription ?? "", nil, false)
                }
            case .failure(let error):
                completion(false, error.localizedDescription, nil, false)
            }
        })
    }
    
    //MARK: - check_tracking
    class func checktracking(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ response: [String:AnyObject]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.check_tracking, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    print(responseValue)
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    completion(userStatus, error_message,nil,userStatus)
                    
                }
                else {
                    completion(false, responseData.error?.localizedDescription ?? "", nil, false)
                }
            case .failure(let error):
                completion(false, error.localizedDescription, nil, false)
            }
        })
    }
    
     //MARK: - check_TADAFundsByDate
    class func checkTADAFundsByDate(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ status: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.check_TADAFundsByDate, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    print(responseValue)
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    
                    completion(true, error_message,userStatus)
//                    if let result = responseValue[WebConstants.RESPONSE] as? [String: AnyObject]{
//
//
//                    }
//                    else {
//                        var message = ""
//
//                        message = error_message
//
//                        completion(false, message,false)
//                    }
                }
                else {
                    completion(false, responseData.error?.localizedDescription ?? "", false)
                }
            case .failure(let error):
                completion(false, error.localizedDescription, false)
            }
        })
    }
    
    //MARK: - reporting_sellerByDate
    
    class func getReportingSellerByDate(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ schoolData: [SearchSchoolData]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.reporting_sellerByDate, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    if let result = responseValue[WebConstants.RESPONSE] as? [String: Any] {
                        
                        if let schoolData = result[WebConstants.SCHOOL_DATA] as? [[String: Any]], let schoolData = Mapper<SearchSchoolData>().mapArray(JSONArray: schoolData) as [SearchSchoolData]? {
                            completion(true, "", schoolData, userStatus)
                            
                        }
                        
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
    
    class func getPartyReportingSellerByDate(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ schoolData: [PartyData]?, _ userStatus: Bool)->()) {
        Alamofire.request(API_NAME.shared.base_url + API_NAME.shared.reporting_sellerByDate, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success(let data):
                if let responseValue = data as? [String: AnyObject] {
                    let userStatus = responseValue[WebConstants.STATUS] as? Bool ?? true
                    let error_message = responseValue[WebConstants.MESSAGE] as? String ?? ""
                    if let result = responseValue[WebConstants.RESPONSE] as? [String: Any] {
                        
                        if let party_data = result[WebConstants.PARTY_DATA] as? [[String: Any]], let partyData = Mapper<PartyData>().mapArray(JSONArray: party_data) as [PartyData]? {
                            completion(true, "", partyData, userStatus)
                            
                        }
                        
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
    
    
    //MARK: - upload image
    class func callsendDataImageAPI(URLName:String,param:[String: AnyObject],arrImage:[String:UIImage?], withblock:@escaping (_ response: [String:AnyObject]?, _ message: String)->Void){
        print(param)
        Alamofire.upload(multipartFormData:{ MultipartFormData in

            for (key, value) in param {
                MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }

            //if(arrImage != nil){
                for (key, value) in arrImage {
                    
                    if(value != nil){
                        guard let imgData = value?.jpegData(compressionQuality: 0.8) else { return }
                        MultipartFormData.append(imgData, withName: key, fileName: "gurukool\(Date().timeIntervalSince1970)l" + ".jpeg", mimeType: "image/jpeg")
                    }
                }
            //}
//UInt64.init()
        },usingThreshold:UInt64.init(),
          to: URLName,
            method:.post,
            headers:["Content-type": "multipart/form-data",
                     "Content-Disposition" : "form-data"], encodingCompletion: {
            encodingResult in
            switch encodingResult {
            case .success(request: let request, streamingFromDisk: _, streamFileURL: _):
                print(request)
                request.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                request.responseJSON { response in
                    print(response)
                    switch(response.result){
                        
                    case .success(let data):
                        print("callsendDataImageAPI",response.result.value as Any)
                        if let responseValue = data as? [String: AnyObject] {
                            print("callsendDataImageAPI",responseValue)
                            withblock(responseValue, responseValue["message"] as? String ?? "")
                        }
                    case .failure(let error):
                        print("api error message resonse"+error.localizedDescription)
                        withblock(nil,error.localizedDescription)
                    }
                }
            case .failure(let encodingError):
                print("api error message\(encodingError.localizedDescription)")
                withblock(nil,encodingError.localizedDescription)
            }
        })
        
    }

    
}

