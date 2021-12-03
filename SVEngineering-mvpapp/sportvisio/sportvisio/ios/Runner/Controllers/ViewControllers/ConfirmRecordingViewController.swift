//
//  ConfirmRecordingViewController.swift
//  Runner
//
//  Created by Jahan on 24/08/2021.
//

import UIKit
protocol ConfirmRecordingDelegate {
    func btnYesAction(isPlay:Bool)
    func btnNoAction(isPlay:Bool)
    func btnEditGameAction(isPlay:Bool)
    func btnCancelRecordAction(isPlay:Bool)

}
class ConfirmRecordingViewController: UIViewController {

    @IBOutlet weak var lblCorrect: UILabel!
    @IBOutlet weak var lblCaption: UILabel!
    @IBOutlet weak var BottomViewHeight: NSLayoutConstraint! // 136
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var lblTeams: UILabel!
    @IBOutlet weak var lblLeagueName: UILabel!
    @IBOutlet weak var lblCourtName: UILabel!
    @IBOutlet weak var lblGameName: UILabel!
    @IBOutlet weak var lblGameTime: UILabel!
    
    var delegate : ConfirmRecordingDelegate?
    var isPlay = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        BottomViewHeight.constant = 0
        bottomView.isHidden = true
    }


    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnYesAction(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.btnYesAction(isPlay: self.isPlay)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnNoAction(_ sender: Any) {
        if !isPlay {
            self.bottomView.isHidden = false
            self.BottomViewHeight.constant = 136
            UIView.animate(withDuration: 1) {
                self.view.layoutSubviews()
                
            }
            if let delegate = self.delegate {
                delegate.btnNoAction(isPlay: self.isPlay)
            }
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func btnEditGameAction(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.btnEditGameAction(isPlay: self.isPlay)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnCancelRecordAction(_ sender: Any) {
        if let delegate = self.delegate {
            self.navigationController?.popViewController(animated: true)
            delegate.btnCancelRecordAction(isPlay: self.isPlay)
        }
    }
    
}
