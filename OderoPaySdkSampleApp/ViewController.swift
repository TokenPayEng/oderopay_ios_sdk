//
//  ViewController.swift
//  OderoPaySdkSampleApp
//
//  Created by OderoPay on 12.05.2023.
//

import UIKit
import OderoPaySdk

class ViewController: UIViewController {
    
    // The payment token will be given on every transaction by OderoPay after the merchant integration
    private let token: String = "9d22e7dd-5567-4ea1-ac19-11395772ac34"
    
    // Optionally change the language of the OderoPay sdk
    private let forceLanguage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startPaymentButtonTapped(_ sender: Any) {
        self.startPaymentViaOderoPaySDK(withToken: token)
    }
    
    // Starting payment via OderoPay sdk
    private func startPaymentViaOderoPaySDK(withToken token: String){
        do {
            // Language can be forced, this feature is optinoal.
            try self.forceOderoSdkLanguage()
                        
            // Start payment
            try OderoPayFactory.getInstance().getOderoPay().startPayment(
                navigationController:self.navigationController!,
                token: token,
                delegate: self)
        } catch OderoException.InvalidInput(let errorMessage) {
            print(errorMessage)
        } catch OderoException.SDKAlreadyInitialized(let errorMessage) {
            print(errorMessage)
        } catch {
            print("An unexpected error occurred.")
        }
    }
    
    // Four different languages available.
    private func forceOderoSdkLanguage() throws{
        if forceLanguage{
            try OderoPayFactory.getInstance().getOderoPay().forceLanguage(language: Language.RUSSIAN)
        }
    }
}

// OderoPay sdk callbacks
extension ViewController : OderoPayResultListener {
    func onOderoPaySuccess(result: OderoPaySdk.OderoResult) {
        print("onOderoPaySuccess, payment type is = \(result.getPaymentType()) and payment id is = \(String(describing: result.getPaymentIdList()))")
    }
    
    func onOderoPayCancelled() {
        print("onOderoPayCancelled")
    }
    
    func onOderoPayFailure(errorId: Int, errorMsg: String?) {
        print("onOderoPayFailure, errorMsg: \(String(describing: errorMsg)) and errorId: \(errorId)")
    }
}


