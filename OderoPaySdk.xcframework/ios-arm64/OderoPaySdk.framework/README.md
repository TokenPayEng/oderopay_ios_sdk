# OderoPay kaldır bunu githuba koy

OderoPay is a Swift Package that lets you integrate your iOS application with the Odero Payment Ecosystem.

## Installation

In Xcode open `File` => `Add Packages...` => enter this Github repository. Use up to latest minor version to get the latest stable version.

## Support

OderoPay supports `Visa`, `Visa Electron`, `MasterCard`, `Maestro` and `American Express` card associations.

OderoPay supports following payment: `Single Card`, `Multiple Cards`, `TokenFlex`

OderoPay supports 3DS Secure Payment

OderoPay supports Card Storage feature

## Usage

If you are in possesion of _API_KEY_ and _SECRET_KEY_ then you can proceed further. Otherwise visit Merchant Panel and retrieve _API_KEY_ and _SECRET_KEY_.

In your project's `AppDelegate` file add the following code inside the application(didFinishLaunchingWithOptions) function. You can copy the code as follows:

```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        OderoPay.setEnvironment(to: .SANDBOX)
        OderoPay.authorizeWithKeys(apiKey: "QqLEuyZcztlikVSfLJZNLwBCFYtphFzk", secretKey: "cONMqzNoYFvOshYuSjybwqJrbjJygian")
        return true
    }
```

`OderoPay.setEnvironment(to: _)` function lets you choose between three environments: `SANDBOX`, `PROD_TR` and `PROD_AZ`

`OderoPay.authorizeWithKeys(apiKey: _, secretKey: _)` function lets you set your specific keys.

Add `View` to your .storyboard file, place it where you would like payment button to appear. In the
IdentityInspector select `OderoButtonView` class for your newly added `View`. Connect IBOutlet
to the related ViewController class.
 
```swift
    @IBOutlet weak var oderoPayButtonView: OderoPayButtonView!
```
In order to be able to navigate to the Payment Page you need to do the following:

1. Instantiate navigation controller for the OderoPay Button
2. Set desired `CheckoutForm` and pass it to the OderoPay Button.
3. Set desired size and color to the View that represents the OderoPay Button (Optional)

If you want to display the Payment Page in Native View you can omit the following part.

4. You can display the Payment Page either in Native View or Web View (Optional)

Code example:

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.        
        oderoPayButtonView.addOderoPayButtonOutline(colored: .black)
        oderoPayButtonView.setOderoPayImageSize(height: 40, width: 80)
        oderoPayButtonView.initNavigationController(named: self.navigationController!)
        
        // to display Payment Page (Common Payment Page) as WebView
        // OderoPay.changeToWebView(true)
        
        OderoPay.setCheckoutForm(
            to: CheckoutForm(
                orderNumber: "from_iOS_Package_#2",
                ofProducts: products.map { product in PaymentItem(named: product.name, for: product.totalPrice)},
                ofType: .PRODUCT,
                priceToPayInitial: totalPrice,
                priceToPayAfterDiscounts: totalPrice,
                in: .TRY
            )
        )
    }
```

## Functionality and Customizability

OderoPay Swift Package comes with UI customizability and detailed description of functionality. First comes customizability of the Common Payment Page, next functionality description.

## Using Custom or Pre-defined End Screens

OderoPay Swift Package comes with built in, pre-defined `success` and `error` payment result screens. However if you want to use your own such screens, you have a couple of options of how to integrate your screens to the overall payment flow. 

Hint: Instantiate them all at the same place, during the initial setup. You can set custom screen right after setting the checkout form.

Requirements:
1. You have to call function that enables the usage of custom screens.
2. Next, you have to instantiate two screens: one for `success` scenario and one for the `error`/`failure` scenario.
3. Lastly, you either pass these screens as ViewControllers or Storyboards with ViewController Identifier.

Functions headers:

```swift
    OderoPay.useCustomEndScreens(_ value: Bool)
```

```swift    
    // success screen which requires your custom Success Screen's ViewController
    OderoPay.instantiateCustomSuccessScreenWith(viewController: UIViewController)
```
    
```swift    
    // success screen which requires your custom Success Screen's Storyboard with ViewControllers Identified (ID)
    OderoPay.instantiateCustomSuccessScreenWith(storyboard: UIStoryboard, identifiedBy: String)
```
 
```swift    
    // error screen which requires your custom Error/Warning Screen's ViewController
    OderoPay.instantiateCustomErrorScreenWith(viewController: UIViewController)
```
 
```swift    
    // error screen which requires your custom Error/Warning Screen's Storyboard with ViewControllers Identified (ID)
    OderoPay.instantiateCustomErrorScreenWith(storyboard: UIStoryboard, identifiedBy: String)
```

Code Example:

```swift
    OderoPay.useCustomEndScreens(true)  // enables custom screens, now you can call above methods
    OderoPay.useCustomEndScreens(false) // comes by default
```


## Enabling and Disabling Payment Methods

As it was stated OderoPay Swift Package supports following payments - `Single Card`, `Multiple Cards`, `TokenFlex`. Options which will be enabled or disabled are chosen by your company during the onboarding to the OderoPay System using the Merchant Panel.

## Navigating to Common Payment Page using OderoPay button

To navigate to the common payment page you need to add navigation controller to the OderoPay button.

Function header:

```swift
    oderoPayButtonView.initNavigationController(named: UINavigationController)
```

Code example:

```swift
    oderoPayButtonView.initNavigationController(named: self.navigationController!)
```

## Setting Checkout Form

`CheckoutForm` has the following initializers

```swift
   init(
        orderNumber: String?,
        ofProducts: [PaymentItem],
        ofType paymentType: PaymentType,
        priceToPayInitial: Double,
        priceToPayAfterDiscounts: Double,
        in currency: Currency,
        withExistingWalletBalance: Double? = nil,
        fromBuyerWithId: Double? = nil,
        withUserEmail: String? = nil,
        withUserCardKey: String? = nil
    )
```

`PaymentItem` has the following initializers

```swift
    public init(
        named name: String,
        for price: Double,
        externalId: String? = nil,
        subMerchantId: Int? = nil,
        subMerchantPrice: Double? = nil
    )
```

`PaymentType` has values of `PRODUCT`, `LISTING`, `SUBSCRIPTION`

`Currency` has values of `AZN`, `TRY`, `USD`, `EURO`

In order to set the checkout form call you can look for the following code example

Code example:

```swift
    OderoPay.setCheckoutForm(
        to: CheckoutForm(
            orderNumber: "from_iOS_Package_#2",
            ofProducts: products.map { product in PaymentItem(named: product.name, for: product.totalPrice)},
            ofType: .PRODUCT,
            priceToPayInitial: totalPrice,
            priceToPayAfterDiscounts: totalPrice,
            in: .TRY
        )
    )
```


## Changing OderoPay button color (Currently AZ Version Only)

OderoPay button color in Azerbaijan (for now) comes in two variations: black and white. You can also add button outline to the button itself. It's recommended to use black color variation or white color with black outline variation for light backgrounds, and white color variation for the dark backgrounds.

Function header:

```swift
    oderoPayButtonView.changeDefaultColor(fromWhiteToBlack: Bool)
```

Code example:

```swift
    oderoPayButtonView.changeDefaultColor(fromWhiteToBlack: true)
```

## Adding outline to OderoPay button

You can add any desired color outline to the OderoPay button. It's recommended only to add black colored outline to the white colored button.

Function header:

```swift
    oderoPayButtonView.addOderoPayButtonOutline(colored: UIColor)
```

Code example:

```swift
    oderoPayButtonView.addOderoPayButtonOutline(colored: .black)
```

## Removing outline from OderoPay button

You can remove added outline from the OderoPay button just as easy as adding it.

Function header:

```swift
    oderoPayButtonView.removeOderoPayButtonOutline()
```

Code example:

```swift
    oderoPayButtonView.removeOderoPayButtonOutline()
```
      
## Change OderoPay image size

You can change the size of the OderoPay sign/image inside the OderoPay button as you see fit depending on the size of your OderoPay button itself.

Function header:

```swift
    oderoPayButtonView.setOderoPayImageSize(height: CGFloat, width: CGFloat)
```

Code example:

```swift
    oderoPayButtonView.setOderoPayImageSize(height: 40, width: 80)
```

## Known Warnings

Since iOS 16 WKWebKit causes a `@main This method should not be called on main thread warning`. Can be ignored.

Some of the textfield allegedly cause a constraint break. Can be ignored.

## License

Copyright © 2022 Token Payment Services and Electronic Money Inc. All rights reserved.
