
import UIKit

let Alert = "Alert"
let Alert_msg = "Are you sure you want to continue?"
let Camera = "Camera"
let Cancel = "Cancel"
let Camera_msg = "You don't have camera"
let Choose_image = "Choose Image"
let Confirmation = "Confirmation"
let Concern_person_name = "Please enter concern person name"
let Concern_person_no = "Please enter concern person mobile no."
let Date_formatter = "dd-MM-yyyy"
let Date_formatterSlash = "dd-MM-yyyy"
let Done = "Done"
let Enter_remarks = "Please enter remarks"
let Gallery = "Gallery"
let Gallery_premission = "You don't have permission to access gallery."
let Premission_msg = "You don't have permission to access gallery."
let Remarks = "Remarks"
let Resend_otp = "Resend OTP"
let NO = "NO"
let Number_of_school = "Enter no. of school"
let Number_of_party = "Enter no. of party"
let OK = "OK"
let user_pswd = "Please enter password"
let Select_concern = "Select concern"
let Select_concern_person = "Please select concern person"
let Select_date = "Please select date"
let user_name = "Please enter username"
let user_Id = "userId"
let full_Name = "full_Name"
let LOGGIN_ID = "loggin_id"
let SCHOOL_ID = "school_ids"
let PARTY_ID = "party_ids"
let Warning = "Warning"
let YES = "YES"

struct API_NAME {
    
    static let shared = API_NAME()
    let base_url = "https://gurukulpublications.org/admin/index.php/app_control/"
    let login = "userLogin"
    let getAllINDStates = "getAllINDStates"
    let getStateDistrict = "getStateDistrict"
    let getDistrictCity = "getDistrictCity"
    let getAllSampleBooks = "getAllSampleBooks"
    let getPrimarySampleBooks = "getPrimarySampleBooks"
    let getGroupSampleBooks = "getGroupSampleBooks"
    let getAllSearchedSchools = "getAllSearchedSchools"
    let getSearchedParty = "getSearchedParty"
    let addSchoolVisitInfo = "addSchoolVisitInfo"
    let addPartyInfo = "addPartyInfo"
    let Send_otp_toMerchant = "Send_otp_toMerchant"
    let addTADAFunds = "addTADAFunds"
    let check_TADAFundsByDate = "check_TADAFundsByDate"
    let reporting_sellerByDate = "reporting_sellerByDate"
    let tracking_loggOut = "tracking_loggOut"
    let tracking_loggin = "tracking_loggin"
    let tracking_info = "tracking_info"
    let check_tracking = "check_tracking"
}


struct  STORYBOARDS_ID
{
    static let ADD_PARTY_VC = "AddPartyViewController"
    static let HOME_VC = "HomeViewController"
    static let FORM_VC = "FormViewController"
    static let ORDER_VC = "OrderViewController"
    static let ORDER_PARTY_VC = "PartyOrderViewController"
    static let OTP_VC = "OTPViewController"
    static let OTP_PARTY_VC = "PartyOTPViewController"
    static let PAYMENT_VC = "PaymentViewController"
    static let PAYMENT_PARTY_VC = "PartyPaymentViewController"
    static let PURPOSE_VISIT_VC = "PurposeOfVisitViewController"
    static let PURPOSE_VISIT_PARTY_VC = "PartyPurposeOfVisitVC"
    static let REPORT_VIEW_VC = "ReportViewController"
    static let SAMPLE_LIST_VC = "SampleListViewController"
    static let SAMPLE_LIST_PARTY_VC = "PartySampleListVC"
    static let SELECTION_COMMITTEE_VC = "SelectionCommitteeViewController"
    static let SIGNIN_VC = "SignInViewController"
    static let SELECTION_COMMITTEE_PARTY_VC = "SelectionCommitteePartyViewController"
}

struct CELLINDENTIFIRES_ID
{
    static let GROUP_VIEW_CELL = "GroupViewControllerCell"
    static let INDIVIDUAL_VIEW_CELL = "IndividualViewControllerCell"
    static let PRIMARY_VIEW_CEll = "PrimaryViewControllerCell"
    
}

struct WebConstants {
    static let EMAIL = "email"
    static let FULL_NAME = "fullname"
    static let ID = "id"
    static let MESSAGE = "message"
    static let NAME = "name"
    static let PHONE = "phone"
    static let RESPONSE = "response"
    static let PARTY_DATA = "party_data"
    static let SCHOOL_DATA = "school_data"
    static let ROLE = "role"
    static let USER_TYPE = "user_type"
    static let STATUS = "status"
    static let LOCATION_TYPE = "location_type"
    static let PARENT_ID = "parent_id"
    
    
    
}
