//
//  PushCategorie.h
//  OpenFLParse
//
//  Created by thomas baudon on 19/03/2015.
//
//

#ifndef OpenFLParse_PushCategorie_h
#define OpenFLParse_PushCategorie_h

@interface PushNotification : NSObject
@end

@interface SDLUIKitDelegate : NSObject <UIApplicationDelegate>
@end

@interface SDLUIKitDelegate (PushNotification)

@property (nonatomic, retain) id pushNotif;

@end

static char const * const PushNotifKey = "pushnotification";

#endif
