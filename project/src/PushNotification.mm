//
//  PushNotification.m
//  OpenFLParse
//
//  Created by thomas baudon on 19/03/2015.
//
//  Big thanks to hcwdikk : https://github.com/hcwdikk/Haxe-PushNotifications-ios/blob/master/PushNotifications/project/common/PushNotifications.mm

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <objc/runtime.h>

#include "OpenFLParse.h"
#include "PushNotification.h"

@implementation PushNotification

-(id)init {
    return self;
}

@end

@implementation NMEAppDelegate (PushNotification)

@dynamic pushNotif;

-(id)pushNotif {
    return objc_getAssociatedObject(self, PushNotifKey);
}

-(void)setPushNotif:(id)newPushNotif {
    objc_setAssociatedObject(self, PushNotifKey, newPushNotif, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[@"global"];
    [currentInstallation saveInBackground];
    
    const char * installId = [[currentInstallation objectId] UTF8String];
    
    parse::registerSuccess(installId);
}

-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    NSLog(@"Failed to get token, error: %@", error);
}

-(void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    if (application.applicationState == UIApplicationStateInactive)
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    
    [PFPush handlePush:userInfo];

}

-(void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (application.applicationState == UIApplicationStateInactive)
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    
    [PFPush handlePush:userInfo];
}

@end
