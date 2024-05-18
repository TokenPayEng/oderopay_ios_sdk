//
//  ViewController.m
//  SampleObjCProject
//
//  Created by Kadir Guzel on 18.05.2024.
//

#import "ViewController.h"
#import <OderoPaySDK/OderoPaySDK.h>
#import "ErrorUtil.h"

@interface ViewController () <OderoPayResultListener>

@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) BOOL forceLanguage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Delete this line, the payment token will be given on every transaction by OderoPay after the merchant integration
    self.token = @"your_merchant_token";
}

- (IBAction)startPaymentButtonTapped:(id)sender {
    [self startPaymentViaOderoPaySDKWithToken:self.token];
}

// Starting payment via OderoPay sdk
- (void)startPaymentViaOderoPaySDKWithToken:(NSString *)token {
    @try {
        // Get odero library
        NSError *error = nil;
        id<OderoPayLibrary> oderoPayLibrary = [[OderoPayFactory getInstance] getOderoPayAndReturnError:&error];
        [ErrorUtil.sharedInstance errorToThrowException:error];
        
        // Start payment
        [oderoPayLibrary startPaymentWithNavigationController:self.navigationController token:token delegate:self error:&error];
        [ErrorUtil.sharedInstance errorToThrowException:error];
    }@catch (OderoExceptionInvalidInput *e) {
        NSLog(@"Reason: %@", [e reason]);
        [self showAlert:[e reason]];
    }@catch (OderoExceptionSDKAlreadyInitialized *e) {
        NSLog(@"Reason: %@", [e reason]);
        [self showAlert:[e reason]];
    }@catch (NSException *e) {
        NSLog(@"An unexpected error occurred. Reason: %@", [e reason]);
        [self showAlert:[e reason]];
    }
}

// OderoPay sdk callbacks
#pragma mark - OderoPayResultListener

- (void)onOderoPaySuccessWithResult:(id <OderoResult> _Nonnull)result{
    NSLog(@"onOderoPaySuccess, payment type is = %@ and payment id is = %@", [result getPaymentType], [[result getPaymentIdList] componentsJoinedByString:@", "]);
    [self showAlert:@"Success"];
}

- (void)onOderoPayCancelled {
    NSLog(@"onOderoPayCancelled");
    [self showAlert:@"Cancelled"];
}

- (void)onOderoPayFailureWithErrorId:(NSInteger)errorId errorMsg:(NSString *)errorMsg {
    NSLog(@"onOderoPayFailure, errorMsg: %@ and errorId: %ld", errorMsg, (long)errorId);
    [self showAlert:errorMsg];
}

- (void)showAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
