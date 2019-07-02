//
//  AddSceneVC.swift
//  Cultivation
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 张光富. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModels
import AVFoundation
import MBProgressHUD

class AddSceneVC: UIViewController {
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var sceneDescriptonTextField: UITextField!
    @IBOutlet weak var sceneNameTextField: UITextField!
    
    var scenePid: String!
    var industry: CultivationIndustry!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        initVM()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func initView() {
        view.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap.asDriver().drive(onNext:{ [weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
        
        qrCodeScanButton.rx.tap.asDriver().drive(onNext:{ [weak self] _ in
            if (self?.cameraPermissions())! {
                let qrCodeScanVC = self?.storyboard?.instantiateViewController(withIdentifier: "QRCodeScanVC") as! QRCodeScanVC
                qrCodeScanVC.qrCodeScanVariable.asDriver().drive(onNext:{ [weak self] qrCode in
                    self?.devicePidTextField.text = qrCode
                    self?.devicePidTextField.becomeFirstResponder()
                }).disposed(by: (self?.disposeBag)!)
                self?.navigationController?.pushViewController(qrCodeScanVC, animated: true)
            } else {
                //弹出提示框
                let sheet = UIAlertController(title: "温馨提示", message: "请在设置->隐私->相机中开启权限", preferredStyle: .alert)
                
                let tempAction = UIAlertAction(title: "确定", style: .cancel) { (action) in
                }
                sheet.addAction(tempAction)
                self?.present(sheet, animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
    }
    
    func cameraPermissions() -> Bool{
        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if(authStatus == AVAuthorizationStatus.denied || authStatus == AVAuthorizationStatus.restricted) {
            return false
        }else {
            return true
        }
        
    }
    
    func initVM() {
        let viewModel = AddDeviceViewModel(input: (
            scenePid: scenePid,
            industry: industry.rawValue,
            description: deviceDescriptonTextField.text,
            devicePid: devicePidTextField.rx.text.orEmpty.asDriver(),
            deviceName: deviceNameTextField.rx.text.orEmpty.asDriver(),
            confirmTap: confirmButton.rx.tap.asDriver()))
        
        viewModel.confirmEnabled?
            .drive(onNext: { [weak self] enable in
                self?.confirmButton.isEnabled = enable
                self?.confirmButton.alpha = enable ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)
        
        let hud = MBProgressHUD.createHUD(view: self.view)
        viewModel.loading
            .drive(hud.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.postResult.asDriver().drive(onNext: { [weak self] postResult in
            switch postResult {
            case .ok:
                self?.toast("添加成功!")
                Driver.just("").delay(1).drive(onNext:{ [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }).disposed(by: (self?.disposeBag)!)
            case .fail(let message):
                self?.toast(message)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
}
