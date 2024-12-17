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
            // Apply sdk optinal settings
            try configureSDKSettings()
                        
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
    
    // Configures the SDK settings
    private func configureSDKSettings() throws {
        // Four different languages available.
        let language = forceLanguage ? Language.RUSSIAN : Language.BASE
        try OderoPayFactory.getInstance().getOderoPay().forceLanguage(language: language)

        // Set the payment button color
        if let color = UIColor(hex: "253FC3") {
            try OderoPayFactory.getInstance().getOderoPay().paymenButtonColor(colored: color)
        } else {
            print("Invalid HEX color")
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


