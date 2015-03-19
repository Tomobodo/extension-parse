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
#include <hx/CFFI.h>

#include "ParseWrapper.h"

namespace parse {
    
    ParseWrapper * wrapper;
    
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