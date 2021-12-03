import UIKit
import AWSCore
import AWSCognitoIdentityProvider
import AWSKinesisVideo
import AWSKinesisVideoSignaling
import AWSMobileClient
import Foundation
import WebRTC
import MBProgressHUD

class VideoViewController: UIViewController {
    
    
    @IBOutlet weak var btnBack: UIButton!
    var userListDevicesResponse: AWSCognitoIdentityUserListDevicesResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    var userDetailsResponse: AWSCognitoIdentityUserGetDetailsResponse?
    var userSessionResponse: AWSCognitoIdentityUserSession?
    var AWSCredentials: AWSCredentials?
    var wssURL: URL?
    var signalingClient: SignalingClient?
    var channelARN: String?
    var isMaster: Bool?
    var webRTCClient: WebRTCClient?
    var iceServerList: [AWSKinesisVideoSignalingIceServer]?
    var awsRegionType: AWSRegionType = .Unknown
    var signalingConnected: Bool = false
    var sendAudioEnabled: Bool = true
    var remoteSenderClientId: String?
    lazy var localSenderId: String = {
        return connectAsViewClientId
    }()
    
    @IBOutlet weak var bottomInfoView: UIView!
    var isPlay = false
    @IBOutlet weak var lblState: UILabel!
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var btnteam: UIButton!
    @IBOutlet weak var lblTeam: UILabel!
    @IBOutlet weak var lblCourt: UILabel!
    @IBOutlet var localVideoView: UIView?
    @IBOutlet var previewView: UIView?
    @IBOutlet weak var btnPlay: UIButton!
    var channelNameValue = ""

    private let localSenderClientID: String = ""
    let df = DateFormatter()
    let calendar = Calendar.current
    var strStartDate = ""
    var strEndDate = ""
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // self.updateDevice()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signalingConnected = false
        updateConnectionLabel()
        isMaster = true
        self.channelNameValue = randomString(length: 8)
        connectAsRole(role: masterRole, connectAsUser: (connectAsMasterKey))
        df.dateFormat = "yyyy-MM-dd hh:mm a"
        let startDate = Date()
        let endDate = calendar.date(byAdding: .minute, value: 15, to: startDate)
        strStartDate = df.string(from: startDate)
        strEndDate = df.string(from: endDate!)
        
        let params = ["videoId":self.channelNameValue,
                      "startTime":strStartDate,
                      "endTime":strEndDate,
                      "gameId":Constants.gameId] as [String : Any]
        
        self.attachDevice(params: params)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bottomInfoView.backgroundColor = .white
        self.lblTeam.textColor = .black
        self.lblState.textColor = .black
        self.lblCourt.textColor = .black
        self.renderView()
        
    }
    @IBAction func btnBackAction(_ sender: Any) {
        stopRecordingAndGoBack()
    }
    
    func stopRecordingAndGoBack(){
        DispatchQueue.main.async {
            if self.isPlay {
                self.stopStreaming()
            }
            self.isPlay = false
            self.webRTCClient?.shutdown()
            self.signalingClient?.disconnect()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func stopRecording(){
        btnPlay.setImage(#imageLiteral(resourceName: "btnPlay"), for:.normal)
        self.stopStreaming()
        isPlay = false
        webRTCClient?.shutdown()
        signalingClient?.disconnect()
        self.view.bringSubviewToFront(btnPlay)
    }
    
    func startRecording(){
        btnPlay.setImage(#imageLiteral(resourceName: "btnStop"), for:.normal)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        signalingClient!.connect()
        self.startStreaming()
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.updateConnectionLabel()
            self.isPlay = true
        }
    }
    
    @IBAction func btnPlay(_ sender : UIButton){
        //sender.isSelected = !sender.isSelected
        let vc = ConfirmRecordingViewController()
        vc.delegate = self
        vc.isPlay = self.isPlay
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnEditAction(_ sender: Any) {
        
    }
    
    func renderView(){
        
        self.previewView?.isHidden = false
        #if arch(arm64)
        // Using metal (arm64 only)
        let localRenderer = RTCMTLVideoView(frame: videoView.frame )
        //  let remoteRenderer = RTCMTLVideoView(frame: videoView.frame)
        localRenderer.videoContentMode = .scaleAspectFill
        //   remoteRenderer.videoContentMode = .scaleAspectFill
        webRTCClient?.startCaptureLocalVideo(renderer: localRenderer)
        //    webRTCClient?.renderRemoteVideo(to: remoteRenderer)
        
        embedView(localRenderer, into: videoView)
       
        #else
        //Hanle Other Arch Here
        #endif
      
    }
    
    private func embedView(_ view: UIView, into containerView: UIView) {
        containerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["view": view]))
        
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["view": view]))
        containerView.layoutIfNeeded()
    }
    
    
    func sendAnswer(recipientClientID: String) {
        webRTCClient?.answer { localSdp in
            self.signalingClient?.sendAnswer(rtcSdp: localSdp, recipientClientId: recipientClientID)
            print("Sent answer. Update peer connection map and handle pending ice candidates")
            self.webRTCClient?.updatePeerConnectionAndHandleIceCandidates(clientId: recipientClientID)
        }
    }
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func connectAsRole(role: String, connectAsUser: String) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let awsRegionValue = strRegion
        
        self.awsRegionType = awsRegionValue.aws_regionTypeValue()
        if (self.awsRegionType == .Unknown) {
            let alertController = UIAlertController(title: "Invalid Region Field",
                                                    message: "Enter a valid AWS region name",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        self.localSenderId = NSUUID().uuidString.lowercased()
        
        // Kinesis Video Client Configuration
        
        let configuration = AWSServiceConfiguration(region: self.awsRegionType, credentialsProvider: AWSMobileClient.default())
        AWSKinesisVideo.register(with: configuration!, forKey: awsKinesisVideoKey)
        
        retrieveChannelARN(channelName: channelNameValue)
        if self.channelARN == nil {
            createChannel(channelName: channelNameValue)
        }
        getSignedWSSUrl(channelARN: self.channelARN!, role: role, connectAs: connectAsUser, region: awsRegionValue)
        print("WSS URL :", wssURL?.absoluteString as Any)
        
        var RTCIceServersList = [RTCIceServer]()
        
        for iceServers in self.iceServerList! {
            RTCIceServersList.append(RTCIceServer.init(urlStrings: iceServers.uris!, username: iceServers.username, credential: iceServers.password))
        }
        
        RTCIceServersList.append(RTCIceServer.init(urlStrings: ["stun:stun.kinesisvideo." + strRegion + ".amazonaws.com:443"]))
        webRTCClient = WebRTCClient(iceServers: RTCIceServersList, isAudioOn: sendAudioEnabled)
        webRTCClient!.delegate = self
        
        print("Connecting to web socket from channel config")
        signalingClient = SignalingClient(serverUrl: wssURL!)
        signalingClient!.delegate = self
        self.previewView?.isHidden = false
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func updateConnectionLabel() {
        if signalingConnected {
            
        } else {
            
        }
    }
    
    
    func createChannel(channelName: String) {
        let kvsClient = AWSKinesisVideo(forKey: awsKinesisVideoKey)
        let createSigalingChannelInput = AWSKinesisVideoCreateSignalingChannelInput.init()
        createSigalingChannelInput?.channelName = channelName
        kvsClient.createSignalingChannel(createSigalingChannelInput!).continueWith(block: { (task) -> Void in
            if let error = task.error {
                print("Error creating channel \(error)")
                return
            } else {
                self.channelARN = task.result?.channelARN
                print("Channel ARN : ", task.result?.channelARN as Any)
            }
        }).waitUntilFinished()
        if (self.channelARN == nil) {
            let alertController = UIAlertController(title: "Unable to create channel",
                                                    message: "Please validate all the input fields",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
    }
    
    func retrieveChannelARN(channelName: String) {
        if !channelName.isEmpty {
            let describeInput = AWSKinesisVideoDescribeSignalingChannelInput()
            describeInput?.channelName = channelName
            let kvsClient = AWSKinesisVideo(forKey: awsKinesisVideoKey)
            kvsClient.describeSignalingChannel(describeInput!).continueWith(block: { (task) -> Void in
                if let error = task.error {
                    print("Error describing channel: \(error)")
                } else {
                    self.channelARN = task.result?.channelInfo?.channelARN
                    print("Channel ARN : ", task.result!.channelInfo!.channelARN ?? "Channel ARN empty.")
                }
            }).waitUntilFinished()
        } else {
            let alertController = UIAlertController(title: "Channel Name is Empty",
                                                    message: "Valid Channel Name is required.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
    }
    
    func getSingleMasterChannelEndpointRole() -> AWSKinesisVideoChannelRole {
        if isMaster! {
            return .master
        }
        return .viewer
    }
    
    func getSignedWSSUrl(channelARN: String, role: String, connectAs: String, region: String) {
        let singleMasterChannelEndpointConfiguration = AWSKinesisVideoSingleMasterChannelEndpointConfiguration()
        singleMasterChannelEndpointConfiguration?.protocols = videoProtocols
        singleMasterChannelEndpointConfiguration?.role = getSingleMasterChannelEndpointRole()
        
        var httpResourceEndpointItem = AWSKinesisVideoResourceEndpointListItem()
        var wssResourceEndpointItem = AWSKinesisVideoResourceEndpointListItem()
        let kvsClient = AWSKinesisVideo(forKey: awsKinesisVideoKey)
        
        let signalingEndpointInput = AWSKinesisVideoGetSignalingChannelEndpointInput()
        signalingEndpointInput?.channelARN = channelARN
        signalingEndpointInput?.singleMasterChannelEndpointConfiguration = singleMasterChannelEndpointConfiguration
        
        kvsClient.getSignalingChannelEndpoint(signalingEndpointInput!).continueWith(block: { (task) -> Void in
            if let error = task.error {
                print("Error to get channel endpoint: \(error)")
            } else {
                print("Resource Endpoint List : ", task.result!.resourceEndpointList!)
            }
            
            guard (task.result?.resourceEndpointList) != nil else {
                let alertController = UIAlertController(title: "Invalid Region Field",
                                                        message: "No endpoints found",
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
                return
            }
            for endpoint in task.result!.resourceEndpointList! {
                switch endpoint.protocols {
                case .https:
                    httpResourceEndpointItem = endpoint
                case .wss:
                    wssResourceEndpointItem = endpoint
                case .unknown:
                    print("Error: Unknown endpoint protocol ", endpoint.protocols, "for endpoint" + endpoint.description())
                }
            }
            AWSMobileClient.default().getAWSCredentials { credentials, _ in
                self.AWSCredentials = credentials
            }
            
            var httpURlString = (wssResourceEndpointItem?.resourceEndpoint!)!
                + "?X-Amz-ChannelARN=" + self.channelARN!
            if !self.isMaster! {
                httpURlString += "&X-Amz-ClientId=" + self.localSenderId
            }
            let httpRequestURL = URL(string: httpURlString)
            let wssRequestURL = URL(string: (wssResourceEndpointItem?.resourceEndpoint!)!)
            usleep(5)
            if self.AWSCredentials != nil {
                
            }
            self.wssURL = KVSSigner
                .sign(signRequest: httpRequestURL!,
                      secretKey: (self.AWSCredentials?.secretKey) ?? "",
                      accessKey: (self.AWSCredentials?.accessKey) ?? "",
                      sessionToken: (self.AWSCredentials?.sessionKey) ?? "",
                      wssRequest: wssRequestURL!,
                      region: region)
            
            // Get the List of Ice Server Config and store it in the self.iceServerList.
            
            let endpoint =
                AWSEndpoint(region: self.awsRegionType,
                            service: .KinesisVideo,
                            url: URL(string: httpResourceEndpointItem!.resourceEndpoint!))
            let configuration =
                AWSServiceConfiguration(region: self.awsRegionType,
                                        endpoint: endpoint,
                                        credentialsProvider: AWSMobileClient.default())
            AWSKinesisVideoSignaling.register(with: configuration!, forKey: awsKinesisVideoKey)
            let kvsSignalingClient = AWSKinesisVideoSignaling(forKey: awsKinesisVideoKey)
            
            let iceServerConfigRequest = AWSKinesisVideoSignalingGetIceServerConfigRequest.init()
            
            iceServerConfigRequest?.channelARN = channelARN
            iceServerConfigRequest?.clientId = self.localSenderId
            kvsSignalingClient.getIceServerConfig(iceServerConfigRequest!).continueWith(block: { (task) -> Void in
                if let error = task.error {
                    print("Error to get ice server config: \(error)")
                } else {
                    self.iceServerList = task.result!.iceServerList
                    print("ICE Server List : ", task.result!.iceServerList!)
                }
            }).waitUntilFinished()
            
        }).waitUntilFinished()
    }
}

extension VideoViewController: SignalClientDelegate {
    func signalClientDidConnect(_: SignalingClient) {
        signalingConnected = true
    }
    
    func signalClientDidDisconnect(_: SignalingClient) {
        signalingConnected = false
    }
    
    func setRemoteSenderClientId() {
        if self.remoteSenderClientId == nil {
            remoteSenderClientId = connectAsViewClientId
        }
    }
    
    func signalClient(_: SignalingClient, senderClientId: String, didReceiveRemoteSdp sdp: RTCSessionDescription) {
        print("Received remote sdp from [\(senderClientId)]")
        if !senderClientId.isEmpty {
            remoteSenderClientId = senderClientId
        }
        setRemoteSenderClientId()
        webRTCClient!.set(remoteSdp: sdp, clientId: senderClientId) { _ in
            print("Setting remote sdp and sending answer.")
            self.sendAnswer(recipientClientID: self.remoteSenderClientId!)
            
        }
    }
    
    func signalClient(_: SignalingClient, senderClientId: String, didReceiveCandidate candidate: RTCIceCandidate) {
        print("Received remote candidate from [\(senderClientId)]")
        if !senderClientId.isEmpty {
            remoteSenderClientId = senderClientId
        }
        setRemoteSenderClientId()
        webRTCClient!.set(remoteCandidate: candidate, clientId: senderClientId)
    }
}

extension VideoViewController: WebRTCClientDelegate {
    func webRTCClient(_: WebRTCClient, didGenerate candidate: RTCIceCandidate) {
        print("Generated local candidate")
        setRemoteSenderClientId()
        signalingClient?.sendIceCandidate(rtcIceCandidate: candidate, master: isMaster!,
                                          recipientClientId: remoteSenderClientId!,
                                          senderClientId: self.localSenderId)
    }
    
    func webRTCClient(_: WebRTCClient, didChangeConnectionState state: RTCIceConnectionState) {
        switch state {
        case .connected, .completed:
            print("WebRTC connected/completed state")
        case .disconnected:
            print("WebRTC disconnected state")
        case .new:
            print("WebRTC new state")
        case .checking:
            print("WebRTC checking state")
        case .failed:
            print("WebRTC failed state")
        case .closed:
            print("WebRTC closed state")
        case .count:
            print("WebRTC count state")
        @unknown default:
            print("WebRTC unknown state")
        }
    }
    
    func webRTCClient(_: WebRTCClient, didReceiveData _: Data) {
        print("Received local data")
    }
}
