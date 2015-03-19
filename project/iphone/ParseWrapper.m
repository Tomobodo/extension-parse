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

@implementation ParseWrapper

UIApplication * mApplication;

-(id)initWithAppId:(const char*)appId clientKey:(const char*)clientKey{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onApplicationDidLaunchWithOptions:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    
    NSString* strAppId = [NSString stringWithUTF8String:appId];
    NSString* strClientKey = [NSString stringWithUTF8String:clientKey];
    
    [Parse setApplicationId:strAppId clientKey: strClientKey];
    
    mApplication = [UIApplication sharedApplication];
    
    return self;
}

-(void)onApplicationDidLaunchWithOptions:(NSNotification *)notification {
    
    if(notification){
        NSDictionary* launchOptions = [notification userInfo];
        if(launchOptions) {
            
            NSLog(@"LaunchOptions not null");
            
            
            
        }
    }
}

-(void)registerForNotification {
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: userNotificationTypes
                                                                             categories: nil];
    
    [mApplication registerUserNotificationSettings: settings];
    [mApplication registerForRemoteNotifications];
    
}

@end
