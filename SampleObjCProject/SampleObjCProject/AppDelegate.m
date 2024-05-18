//
//  AppDelegate.m
//  SampleObjCProject
//
//  Created by Kadir Guzel on 18.05.2024.
//

#import "AppDelegate.h"
#import <OderoPaySDK/OderoPaySDK.h>
#import "ErrorUtil.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSError *error = nil;
    @try {
        [[OderoPayFactory getInstance] initSDKWithEnvironment:EnvironmentSANDBOX_TR error:&error];
        [ErrorUtil.sharedInstance errorToThrowException:error];
    }@catch (OderoExceptionInvalidInput *e) {
        NSLog(@"Reason: %@", [e reason]);
    }@catch (OderoExceptionSDKAlreadyInitialized *e) {
        NSLog(@"Reason: %@", [e reason]);
    }@catch (NSException *e) {
        NSLog(@"An unexpected error occurred. Reason: %@", [e reason]);
    }
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
