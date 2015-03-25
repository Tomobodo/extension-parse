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

#include "OpenFLParse.h"

namespace parse {
    
    static void initialize(value appId, value clientKey){
        wrapper = [[ParseWrapper alloc] initWithAppId: val_string(appId) clientKey: val_string(clientKey)];
    }
    DEFINE_PRIM(initialize, 2);
    
    static void subscribe(value onRegister, value onRegisterFail){
        if(onRegister != NULL)
            eval_RegisterSucces = new AutoGCRoot(onRegister);
        
        if(onRegisterFail != NULL)
            eval_RegisterFail = new AutoGCRoot(onRegisterFail);
        
        [wrapper registerForNotification];
    }
    DEFINE_PRIM(subscribe, 2);
    
    void registerSuccess(const char * installId){
        if(eval_RegisterSucces != 0)
            val_call1(eval_RegisterSucces->get(), alloc_string(installId));
    }
    
    void registerFail(){
        if(eval_RegisterFail != 0)
            val_call0(eval_RegisterFail->get());
    }
    
}

extern "C" {
    
    void parse_main () {
        val_int(0); // Fix Neko init
    }
    DEFINE_ENTRY_POINT (parse_main);

    int parse_register_prims () { return 0; }
    
    
}