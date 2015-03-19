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

#include <hx/CFFI.h>

//#include "Utils.h"
#include "ParseWrapper.h"

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
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[@"global"];
    [currentInstallation saveInBackground];
}

-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    NSLog(@"Failed to get token, error: %@", error);
}

-(void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

@end


namespace parse {
    
    ParseWrapper * wrapper;
    
    /*void initialize(const char* appId, const char* clientKey){
        
        wrapper = [[ParseWrapper alloc] initWithAppId: appId clientKey: clientKey];
        
    }
    
    void subscribe(const char * channel){
        
        [wrapper registerForNotification];
     
    }*/
    
    static void initialize(value appId, value clientKey){
        wrapper = [[ParseWrapper alloc] initWithAppId: val_string(appId) clientKey: val_string(clientKey)];
    }
    DEFINE_PRIM(initialize, 2);
    
    static void subscribe(value channel){
        [wrapper registerForNotification];
    }
    DEFINE_PRIM(subscribe, 1);
    
}

extern "C" void parse_main () {
    
    val_int(0); // Fix Neko init
    
    NSLog(@"Parse entry point");
}
DEFINE_ENTRY_POINT (parse_main);

extern "C" int parse_register_prims () { return 0; }