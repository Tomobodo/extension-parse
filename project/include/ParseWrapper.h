//
//  ParseWrapper.h
//  OpenFLParse
//
//  Created by thomas baudon on 19/03/2015.
//
//

#ifndef OpenFLParse_ParseWrapper_h
#define OpenFLParse_ParseWrapper_h

@interface ParseWrapper : NSObject

-(id)initWithAppId:(const char*)appId clientKey:(const char*)clientKey;

-(void)onApplicationDidLaunchWithOptions:(NSNotification *)notification;

-(void)registerForNotification;

@end

#endif
