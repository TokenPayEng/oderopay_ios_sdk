//
//  ErrorUtil.m
//
//  Created by Kadir Guzel on 16.05.2024.
//

#import "ErrorUtil.h"

// A static instance of the ErrorUtil
static ErrorUtil *sharedInstance = nil;

@implementation ErrorUtil
 
- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (ErrorUtil *)sharedInstance {
    @synchronized (self) {
        if (sharedInstance == nil)
            sharedInstance = [[ErrorUtil alloc] init];
    }
    return sharedInstance;
}


// OderoPaySdk.OderoException.InvalidInput(errorMessage: "Invalid input paremeter. Token can not be nil or empty.")
- (void)errorToThrowException:(NSError *)error{
        
    if(error == nil) {
        return;
    }
    
    NSLog(@"Error description : %@",error.description);
    
    NSString *errorClassName = @"OderoPaySdk.OderoException.";
    if ([error.description rangeOfString:errorClassName].location == NSNotFound) {
        @throw [NSException exceptionWithName:@"Unexpected Exception" reason:error.description userInfo:nil];
    }

    PlainError *plainError = [self parseString:error.description];
   
    if([plainError.errorName isEqual:kSDKAlreadyInitialized]){
        @throw [OderoExceptionSDKAlreadyInitialized exceptionWithName:plainError.errorName reason:plainError.errorMessage userInfo:nil];
    }else if([plainError.errorName isEqual:kInvalidInput]){
        @throw [OderoExceptionInvalidInput exceptionWithName:plainError.errorName reason:plainError.errorMessage userInfo:nil];
    }else if([plainError.errorName isEqual:kSDKNotInitialized]){
        @throw [OderoExceptionSDKNotInitialized exceptionWithName:plainError.errorName reason:plainError.errorMessage userInfo:nil];
    }else{
        @throw [NSException exceptionWithName:@"Unexpected Exception" reason:error.description userInfo:nil];
    }
}

// Parsing error for convert to exception object
- (PlainError *)parseString:(NSString *)errorDescription{
    
    // An object that will be returning
    PlainError *plainError = [PlainError new];
    
    // Replacing and split operations
    NSString *errorClassName = @"OderoPaySdk.OderoException.";
    NSString *stringWithoutClassName = [errorDescription stringByReplacingOccurrencesOfString:errorClassName withString:@""];
    NSArray *elements = [stringWithoutClassName componentsSeparatedByString:@"("];
    
    // Custom parsing
    if([elements count] > 1){
        plainError.errorName = elements[0];
        NSString *stringWithoutDoubleQuotes = [elements[1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString *stringWithoutBrackets = [stringWithoutDoubleQuotes stringByReplacingOccurrencesOfString:@")" withString:@""];
        elements = [stringWithoutBrackets componentsSeparatedByString:@","];
        
        if([elements count] > 0){
            NSArray *errorMessageElements = [elements[0] componentsSeparatedByString:@":"];
            if([errorMessageElements count] > 1 && [errorMessageElements[1] length] > 1){
                plainError.errorMessage = [errorMessageElements[1] substringFromIndex:1];
            }
        }
        
        if([elements count] > 1){
            NSArray *errorCodeElements = [elements[1] componentsSeparatedByString:@":"];
            if([errorCodeElements count] > 1){
                plainError.errorCode = [errorCodeElements[1] stringByReplacingOccurrencesOfString:@" " withString:@""];
            }
        }
    }
    return plainError;
}
        
@end

@implementation OderoExceptionSDKAlreadyInitialized
@end

@implementation OderoExceptionInvalidInput
@end

@implementation OderoExceptionSDKNotInitialized
@end

@implementation PlainError
@end

