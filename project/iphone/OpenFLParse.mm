//
//  OpenFLParse.m
//  OpenFLParse
//
//  Created by thomas baudon on 16/03/2015.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#include "Utils.h"

namespace parse {
    
    void initialize(const char* appId, const char* clientKey){
        
        NSString* strAppId = [NSString stringWithUTF8String:appId];
        NSString* strClientKey = [NSString stringWithUTF8String:clientKey];
        
        [Parse setApplicationId:strAppId clientKey:strClientKey];
    }
    
}

