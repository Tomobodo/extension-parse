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

@implementation SDLUIKitDelegate (PushNotification)

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
    
    if(installId != NULL)
        parse::registerSuccess(installId);
    else
        parse::registerFail();
}

-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    NSLog(@"Failed to get token, error: %@", error);
    parse::registerFail();
}

-(void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    if (application.applicationState == UIApplicationStateBackground) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
        NSLog(@"TRACKED didReceviceNotitification");
    }

}

-(void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (application.applicationState == UIApplicationStateBackground) {
        completionHandler(UIBackgroundFetchResultNewData);
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
        NSLog(@"TRACKED didReceviceNotitification with ocmpletion handler");
    }
}

@end
