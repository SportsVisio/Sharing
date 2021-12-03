import Foundation
import AWSCognitoIdentityProvider

// Cognito constants
let awsCognitoUserPoolsSignInProviderKey = "UserPool"

let cognitoIdentityUserPoolRegion = AWSRegionType.USEast1 //  <- REPLACE ME!
let cognitoIdentityUserPoolId = "us-east-1_sfnpzmPip"
let cognitoIdentityUserPoolAppClientId = "7183ef8rrdlotcqmh1g180n86h"
let cognitoIdentityUserPoolAppClientSecret = "dlee2g8ucravc1fambpbn747b8k6ibjru7ush63ok595u2dj3lo"
let cognitoIdentityPoolId = "us-east-1:0f97f289-6a2e-4ecb-b34e-bb8a51028b0c"

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

