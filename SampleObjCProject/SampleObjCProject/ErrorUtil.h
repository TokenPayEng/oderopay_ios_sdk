//
//  ErrorUtil.h
//
//  Created by Kadir Guzel on 16.05.2024.
//

#import <Foundation/Foundation.h>

static NSString *kSDKAlreadyInitialized =    @"SDKAlreadyInitialized";
static NSString *kInvalidInput =             @"InvalidInput";
static NSString *kSDKNotInitialized =        @"SDKNotInitialized";

@interface ErrorUtil: NSObject
+ (ErrorUtil *)sharedInstance;
- (void)errorToThrowException:(NSError *)error;
@end

@interface OderoExceptionSDKAlreadyInitialized: NSException
@end

@interface OderoExceptionInvalidInput: NSException
@end

@interface OderoExceptionSDKNotInitialized: NSException
@end

@interface PlainError: NSObject
@property(nonatomic, strong) NSString  *errorName;
@property(nonatomic, strong) NSString  *errorMessage;
@property(nonatomic, strong) NSString  *errorCode;
@end





