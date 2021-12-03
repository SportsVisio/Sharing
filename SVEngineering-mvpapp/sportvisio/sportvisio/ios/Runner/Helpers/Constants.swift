import Foundation
import AWSCognitoIdentityProvider

// Cognito constants
let awsCognitoUserPoolsSignInProviderKey = "UserPool"
//      "AppClientSecret": "1vph3h429blv2sv5pedgc4cmasihn8r6uucns8qtban7f81p2s2l",

let cognitoIdentityUserPoolRegion = AWSRegionType.USEast1 //  <- REPLACE ME!
let cognitoIdentityUserPoolId = "us-east-1_66HUKi0kQ"
let cognitoIdentityUserPoolAppClientId = "3ufu0d3dvoi8ri4gva0mpgvprg"
let cognitoIdentityUserPoolAppClientSecret = "1vph3h429blv2sv5pedgc4cmasihn8r6uucns8qtban7f81p2s2l"
let cognitoIdentityPoolId = "us-east-1:e49ffe9c-e3bc-4b4f-86b3-7b4d0a04e28e"
let strRegion = "us-east-1"
// KinesisVideo constants
let awsKinesisVideoKey = "kinesisvideo"
let videoProtocols =  ["WSS", "HTTPS"]

// Connection constants
let connectAsMasterKey = "connect-as-master"
let connectAsViewerKey = "connect-as-viewer"

let masterRole = "MASTER"
let viewerRole = "VIEWER"
let connectAsViewClientId = "ConsumerViewer"

// AWSv4 signer constants
let signerAlgorithm = "AWS4-HMAC-SHA256"
let awsRequestTypeKey = "aws4_request"
let xAmzAlgorithm = "X-Amz-Algorithm"
let xAmzCredential = "X-Amz-Credential"
let xAmzDate = "X-Amz-Date"
let xAmzExpiresKey = "X-Amz-Expires"
let xAmzExpiresValue = "299"
let xAmzSecurityToken = "X-Amz-Security-Token"
let xAmzSignature = "X-Amz-Signature"
let xAmzSignedHeaders = "X-Amz-SignedHeaders"
let newlineDelimiter = "\n"
let slashDelimiter = "/"
let colonDelimiter = ":"
let plusDelimiter = "+"
let equalsDelimiter = "="
let ampersandDelimiter = "&"
let restMethod = "GET"
let utcDateFormatter = "yyyyMMdd'T'HHmmss'Z'"
let utcTimezone = "UTC"

let hostKey = "host"
let wssKey = "wss"

let plusEncoding = "%2B"
let equalsEncoding = "%3D"


struct Constants {
    
    
    
   // static let BaseUrl = "https://3m80zdhcf0.execute-api.us-east-1.amazonaws.com/dev/"
//    static let BaseUrlProd = "https://e0gcs528ad.execute-api.us-east-1.amazonaws.com/Prod/"
//    static let BaseUrl = "https://jefg6ib005.execute-api.us-east-1.amazonaws.com/qa/"

    static let BaseUrl = "https://dev.sportsvisio-api.com/"
    static let deviceType = "ios"
    static let contentType = "application/json"
    static var tokenType = "Bearer"
    static let deviceId = NSUUID().uuidString // UIDevice.current.identifierForVendor
    
    static let device = "iOS"
    
    static var idToken: String {
        get {
            return UserDefaults.standard.string(forKey: "idToken") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "idToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var gameId: String {
        get {
            return UserDefaults.standard.string(forKey: "gameId") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "gameId")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var userId: String {
        get {
            return UserDefaults.standard.string(forKey: "userId") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "userId")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var streamId: String {
        get {
            return UserDefaults.standard.string(forKey: "streamId") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "streamId")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var accessToken: String {
        get {
            return UserDefaults.standard.string(forKey: "accessToken") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "accessToken")
            UserDefaults.standard.synchronize()
        }
    }
    static var refreshToken: String {
        get {
            return UserDefaults.standard.string(forKey: "refreshToken") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "refreshToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var userType: Int {
        get {
            return UserDefaults.standard.integer(forKey: "userType")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "userType")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var deviceToken: String {
        get {
            return UserDefaults.standard.string(forKey: "deviceToken") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "deviceToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    struct Storyboards {
        static let Main = UIStoryboard(name: "Main", bundle: nil)
        
    }
   
    struct EndPonts {
        static let attachDevice = "devices/attach"
        static let updateDevice = "devices/update-attachment/"
        static let getAccount = "account"
        static let registerStream = "streams/register/"
        static let unRegisterStream = "streams/unregister/"
        static let startStream = "devices/stream/start/"
        static let stopStream = "devices/stream/stop/"
    }
    
    struct ViewControllers {
        static let SplashVC = "SplashVC"
        static let OnBoardingVC = "OnBoardingVC"
       
    }
    
   
}
