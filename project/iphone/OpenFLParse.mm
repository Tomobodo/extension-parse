//
//  OpenFLParse.mm
//  OpenFLParse
//
//  Thanks to hcwdikk for AppDelegate Overriding tips : https://github.com/hcwdikk/Haxe-PushNotifications-ios/blob/master/PushNotifications/project/common/PushNotifications.mm
//
//  Created by thomas baudon on 16/03/2015.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#include "Utils.h"

@interface PushNotification : NSObject
@end

@interface NMEAppDelegate : NSObject <UIApplicationDelegate>
@end

@interface NMEAppDelegate (PushNotification)
@property (nonatomic, retain) id pushNotif;
@end
static char const * const PushNotifKey = "pushnotification";

@implementation NMEAppDelegate (PushNotification)
@dynamic pushNotif;
-(id)pushNotif {
    return objc_getAssociatedObject(self, PushNotifKey);
}

-(void)setPushNotif:(id)newPushNotif {
    objc_setAssociatedObject(self, PushNotifKey, newPushNotif, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    NSLog(@"Push register success");
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[@"global"];
    [currentInstallation saveInBackground];
}

-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    NSLog(@"Failed to get token, error: %@", error);
}

-(void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Notification received!");
    [PFPush handlePush:userInfo];
}

@end

namespace parse {
    
    void initialize(const char* appId, const char* clientKey){
        
        NSString* strAppId = [NSString stringWithUTF8String:appId];
        NSString* strClientKey = [NSString stringWithUTF8String:clientKey];
        
        [Parse setApplicationId:strAppId clientKey:strClientKey];

        NSLog(@"Initialize %@ %@", strAppId, strClientKey);
    }
    
    void subscribe(const char * channel){
        
        NSLog(@"Subscribing.");
        
        UIApplication* application = [UIApplication sharedApplication];
        
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
        
    }
    
}

