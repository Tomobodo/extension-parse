//
//  ParseWrapper.m
//  OpenFLParse
//
//  Created by thomas baudon on 19/03/2015.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#include "ParseWrapper.h"
#include "PushNotification.h"

@implementation ParseWrapper

UIApplication * mApplication;
PushNotification * mPushNotification;
NMEAppDelegate * mNMEDelegate;

-(id)initWithAppId:(const char*)appId clientKey:(const char*)clientKey{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onApplicationDidLaunchWithOptions:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    
    NSString* strAppId = [NSString stringWithUTF8String:appId];
    NSString* strClientKey = [NSString stringWithUTF8String:clientKey];
    
    [Parse setApplicationId:strAppId clientKey: strClientKey];
    
    mApplication = [UIApplication sharedApplication];
    
    //NSLog(@"Parse inited with %@ %@", strAppId, strClientKey);
    
    return self;
}

-(void)onApplicationDidLaunchWithOptions:(NSNotification *)notification {
    
    if(notification){
        NSDictionary* launchOptions = [notification userInfo];
        if(launchOptions) {
            
            if (mApplication.applicationState != UIApplicationStateBackground) {
            
                BOOL preBackgroundPush = ![mApplication respondsToSelector:@selector(backgroundRefreshStatus)];
                BOOL oldPushHandlerOnly = ![mNMEDelegate respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)];
                BOOL noPushPayload = ![launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
                
                if (preBackgroundPush || oldPushHandlerOnly || noPushPayload)
                    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
                
            }
            
        }
    }
}

-(void)registerForNotification {
    
    mPushNotification = [[PushNotification alloc] init];
    mNMEDelegate = [mApplication delegate];
    [mNMEDelegate setPushNotif:mPushNotification];
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: userNotificationTypes
                                                                             categories: nil];
    
    [mApplication registerUserNotificationSettings: settings];
    [mApplication registerForRemoteNotifications];
    
}

@end
