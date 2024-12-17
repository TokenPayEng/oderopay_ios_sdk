# OderoPay Payment SDK

## 1. Overview

The OderoPay SDK is a software development kit that allows developers to integrate payment functionality into their applications.
With this SDK, users can securely and easily make payments within the app.
The OderoPay SDK is compatible with iOS 13 above.

## 2. Support
OderoPay supports **Visa, Visa Electron, MasterCard, Maestro and American Express** card associations.

OderoPay supports following payment: **Single Card, Multiple Cards**

OderoPay supports **3DS Secure** Payment

OderoPay supports **Card Storage** feature
## 3. Getting Started

### 3.1 Installation

In Xcode open `File` => `Add Packages...` => enter this Github repository. Use up to latest minor version to get the latest stable version.

**Add the repository to your project:**

```java
https://gitlab.com/kafatech/oderopayframework
```

## 4. SDK Initialization
To initialize the SDK, add the following code in your AppDelegate class :

```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do {
           try OderoPayFactory.getInstance().initSDK(environment:.SANDBOX_TR)
        } catch OderoException.InvalidInput(let errorMessage) {
           print(errorMessage)
        } catch OderoException.SDKAlreadyInitialized(let errorMessage) {
           print(errorMessage)
        } catch {
           print("An unexpected error occurred.")
        }
        return true
    }
```

## 5. Usage

### 5.1 Init Service
The init service is used to initialize the OderoPay SDK with the payment token obtained from our backend. You should call this function before calling the startPayment() function.

##### 5.1.1 Example
To obtain the initialization token required for starting the SDK, you should make a request to the initialization service provided by our backend. Once you have obtained the initialization token, you can pass it to the startPayment() function to initialize the OderoPay SDK.
###### Request
```swift
var call = requestInitToken(
    InitRequest(
        paymentGroup = "PRODUCT",
        callbackUrl = "NO_CALLBACK_URL",
        paidPrice = 100,
        price = 100,
        conversationId = "conversationid", //ForMultiPayment
        currency = "TRY",//Currency
        cardUserKey = "card-user-key", //For StoredCard Feature
        items = listOf(
            Item("Product", 100)
        )
    )
)
```
###### Response
```swift
class InitTokenResponse {
    var data : InitTokenData?
}

class InitTokenData {
    var token : String? // Start SDK with this token
    var pageUrl: String?
}
```

### 5.2 Start Payment
The startPayment() function is used to start the payment process in the OderoPay SDK. You should call this function when the user initiates a payment in your application.

##### 5.2.1 Function Parameters
The startPayment() function takes the following mandatory parameters:

- **navigationController**: To navigate to the common payment page you need to add navigation controller
- **token**: the token required to initiate the payment process.
- **delegate**: an instance of OderoPayResultListener to receive callbacks from the SDK

##### 5.2.2 Example
Here's an example of how to use the startPayment() function in your application:

```swift
 let token = "your-payment-token"
 
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
```
##### 5.2.3 Payment Callbacks
The results of the payment is listened to with the following methods:

```swift
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
```
## 6. Handling Exception
The SDK provides the following exception classes that you can use to handle errors in your application:

##### SDKAlreadyInitialized
This exception is thrown when you try to initialize the SDK more than once. It indicates that the SDK has already been initialized and further attempts to initialize it are unnecessary.

##### InvalidInput
This exception is thrown when the SDK receives invalid input from your application. It indicates that the input provided to the SDK is incorrect and needs to be corrected before proceeding.

##### SDKNotInitialized
This exception is thrown when you try to use the SDK before it has been initialized. It indicates that the SDK has not yet been properly set up and cannot be used until it has been initialized.

## 7. Customization Interfaces
##### OderoPayLibrary
```swift
    func startPayment(navigationController: UINavigationController?, token : String?, delegate : OderoPayResultListener?) throws
    func isInitialized() -> Bool
    func forceLanguage(language: Language)
    func paymenButtonColor(colored: color)
```

```swift
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
```

## 8. Environments
The Environment enum is used to specify the environment that the OderoPay SDK should be initialized with. You can choose between the following environments:

- **SANDBOX_TR**: the sandbox environment for Turkey
- **SANDBOX_AZ**: the sandbox environment for Azerbaijan
- **PROD_TR**: the production environment for Turkey
- **PROD_AZ**: the production environment for Azerbaijan

## 9. Known Warnings

Since iOS 16 WKWebKit causes a `@main This method should not be called on main thread warning`. Can be ignored.

Some of the textfield allegedly cause a constraint break. Can be ignored.

## 10. License
Copyright © 2023 Token Payment Services and Electronic Money Inc. All rights reserved.

[![N|Solid](http://kftech.co/poweredby.png)](http://kftech.co/)



