

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
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        
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
    
    func setupAWS(){
        // setup logging
        AWSDDLog.sharedInstance.logLevel = .debug
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance)

        // setup service configuration
        let serviceConfiguration = AWSServiceConfiguration(region: cognitoIdentityUserPoolRegion, credentialsProvider: nil)

        // create pool configuration
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: cognitoIdentityUserPoolAppClientId,
                                                                        clientSecret: cognitoIdentityUserPoolAppClientSecret,
                                                                        poolId: cognitoIdentityUserPoolId)

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

            switch userState {
            case .signedIn:
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
                break
            default:
                self.navigationController = self.storyboard?.instantiateViewController(withIdentifier: "signinController") as? UINavigationController
                self.signInViewController = self.navigationController?.viewControllers[0] as? SignInViewController
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
            }
        }
    }

    private func receiveTokens(call: FlutterMethodCall) {
        setupAWS()
        if let args = call.arguments as? Dictionary<String, Any>,
           let idToken = args["idToken"] as? String , let accessToken = args["accessToken"] as? String  {
            print("id: ",idToken)
            print("access: ",accessToken)
            
//            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "channelvc") as! ChannelConfigurationViewController
//            vc.modalPresentationStyle = .fullScreen
//            if let topVC = UIApplication.topViewController() {
//
//                topVC.present(vc, animated: true, completion: nil)
//            }
            
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
