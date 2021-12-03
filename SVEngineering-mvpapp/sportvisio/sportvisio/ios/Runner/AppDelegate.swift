

import UIKit
import Flutter
import AWSCognitoIdentityProvider
import AWSMobileClient

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var signInViewController: SignInViewController?
    var channelConfigViewController: ChannelConfigurationViewController?
    var navigationController: UINavigationController?
    var storyboard: UIStoryboard?
    var rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>?
    var isLogin = false
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        // setup logging
        AWSDDLog.sharedInstance.logLevel = .debug
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance)

        // setup service configuration
        let serviceConfiguration = AWSServiceConfiguration(region: cognitoIdentityUserPoolRegion, credentialsProvider: nil)

        // create pool configuration
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: cognitoIdentityUserPoolAppClientId, clientSecret: nil, poolId: cognitoIdentityUserPoolId)

        // initialize user pool client
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: poolConfiguration, forKey: awsCognitoUserPoolsSignInProviderKey)

        AWSMobileClient.default().initialize { (userState, error) in
            if let error = error {
                print("error: \(error.localizedDescription)")

                return
            }

            guard let userState = userState else {
                return
            }
            print("The user is \(userState.rawValue).")
            self.storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            AWSMobileClient.default().clearKeychain()
            AWSMobileClient.default().clearCredentials()
            AWSMobileClient.default().invalidateCachedTemporaryCredentials()
//            let username = "tanzzeemm"
//            let password = "TT203454560tt#"
          
        }
        
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let tokensChannel = FlutterMethodChannel(name: "sports/stream",
                                                  binaryMessenger: controller.binaryMessenger)
        
        tokensChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            
            // Note: this method is invoked on the UI thread.
            guard call.method == "sendToken" else {
                result(FlutterMethodNotImplemented)
                return
            }
            
           
            self?.receiveTokens(call: call)
        })
        
        GeneratedPluginRegistrant.register(with: self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func setupAWS(username : String ,password : String ){
       
        if isLogin == false {
            AWSMobileClient.default().signOut()
            AWSMobileClient.default().signIn(username: username, password: password) { (signInResult, error) in

                DispatchQueue.main.async {
                    if let error = error {
                        print(error.localizedDescription)
                        if let error = error as? AWSMobileClientError {
                            let printableMessage: String
                            switch error {
                            case .aliasExists(let message): printableMessage = message
                            case .codeDeliveryFailure(let message): printableMessage = message
                            case .codeMismatch(let message): printableMessage = message
                            case .expiredCode(let message): printableMessage = message
                            case .groupExists(let message): printableMessage = message
                            case .internalError(let message): printableMessage = message
                            case .invalidLambdaResponse(let message): printableMessage = message
                            case .invalidOAuthFlow(let message): printableMessage = message
                            case .invalidParameter(let message): printableMessage = message
                            case .invalidPassword(let message): printableMessage = message
                            case .invalidUserPoolConfiguration(let message): printableMessage = message
                            case .limitExceeded(let message): printableMessage = message
                            case .mfaMethodNotFound(let message): printableMessage = message
                            case .notAuthorized(let message): printableMessage = message
                            case .passwordResetRequired(let message): printableMessage = message
                            case .resourceNotFound(let message): printableMessage = message
                            case .scopeDoesNotExist(let message): printableMessage = message
                            case .softwareTokenMFANotFound(let message): printableMessage = message
                            case .tooManyFailedAttempts(let message): printableMessage = message
                            case .tooManyRequests(let message): printableMessage = message
                            case .unexpectedLambda(let message): printableMessage = message
                            case .userLambdaValidation(let message): printableMessage = message
                            case .userNotConfirmed(let message): printableMessage = message
                            case .userNotFound(let message): printableMessage = message
                            case .usernameExists(let message): printableMessage = message
                            case .unknown(let message): printableMessage = message
                            case .notSignedIn(let message): printableMessage = message
                            case .identityIdUnavailable(let message): printableMessage = message
                            case .guestAccessNotAllowed(let message): printableMessage = message
                            case .federationProviderExists(let message): printableMessage = message
                            case .cognitoIdentityPoolNotConfigured(let message): printableMessage = message
                            case .unableToSignIn(let message): printableMessage = message
                            case .invalidState(let message): printableMessage = message
                            case .userPoolNotConfigured(let message): printableMessage = message
                            case .userCancelledSignIn(let message): printableMessage = message
                            case .badRequest(let message): printableMessage = message
                            case .expiredRefreshToken(let message): printableMessage = message
                            case .errorLoadingPage(let message): printableMessage = message
                            case .securityFailed(let message): printableMessage = message
                            case .idTokenNotIssued(let message): printableMessage = message
                            case .idTokenAndAcceessTokenNotIssued(let message): printableMessage = message
                            case .invalidConfiguration(let message): printableMessage = message
                            case .deviceNotRemembered(let message): printableMessage = message
                            }
                            print("error: \(error); message: \(printableMessage)")
                        }
                      //  self.showError(error: error)
                    } else if let signInResult = signInResult {
                        switch (signInResult.signInState) {
                        case .signedIn:
                            print("Signed In")
                            self.isLogin = true
                            let vc = VideoViewController()
                            vc.modalPresentationStyle = .fullScreen
                            let navController = UINavigationController(rootViewController: vc)
                            navController.setNavigationBarHidden(true, animated: true)
                            navController.modalPresentationStyle = .overFullScreen
                            DispatchQueue.main.async {
                                if let topVC = UIApplication.topViewController() {
                                    topVC.present(navController, animated: false, completion: nil)
                                }
                            }
                            break

                        default:
                           // self.showSignInError(signInResult: signInResult)
                            self.navigationController = self.storyboard?.instantiateViewController(withIdentifier: "channelConfig") as? UINavigationController
                            self.channelConfigViewController = self.navigationController?.viewControllers[0] as? ChannelConfigurationViewController
                            DispatchQueue.main.async {
                                self.navigationController!.popToRootViewController(animated: true)
                                if (!self.navigationController!.isViewLoaded
                                        || self.navigationController!.view.window == nil) {
                                    self.navigationController?.modalPresentationStyle = .fullScreen
                                    self.window?.rootViewController?.present(self.navigationController!,
                                                                             animated: true,
                                                                             completion: nil)
                                }
                            }
                            print("Default")
                        break
                        }
                    }
                }
            }
        }else{
            let vc = VideoViewController()
            vc.modalPresentationStyle = .fullScreen
            let navController = UINavigationController(rootViewController: vc)
            navController.setNavigationBarHidden(true, animated: true)
            navController.modalPresentationStyle = .overFullScreen
            if let topVC = UIApplication.topViewController() {
                topVC.present(navController, animated: false, completion: nil)
            }
        }
    }

    private func receiveTokens(call: FlutterMethodCall) {
        //setupAWS()
        print(call.arguments ?? "Error in printing arguments")
        if let args = call.arguments as? Dictionary<String, Any>,
           let idToken = args["token"] as? String {
            print("id: ",idToken)
            let gameId = args["gameId"] as? String ?? ""
            let userId = args["id"] as? String ?? ""
            let streamId = args["streamId"] as? String ?? ""
            Constants.gameId = gameId
            Constants.userId = userId
            Constants.streamId = streamId
            Constants.idToken = idToken
            
            let username = "tester"//args["username"] as? String
            let password = "Test@123"//args["password"] as? String
            setupAWS(username: username, password: password)
            
        }
    }
    
    var orientationLock = UIInterfaceOrientationMask.all

    override func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    struct AppUtility {
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }

        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIInterfaceOrientation) {
            self.lockOrientation(orientation)
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        }
    }
}

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
