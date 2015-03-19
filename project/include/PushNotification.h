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

@interface NMEAppDelegate : NSObject <UIApplicationDelegate>
@end

@interface NMEAppDelegate (PushNotification)

@property (nonatomic, retain) id pushNotif;

@end

static char const * const PushNotifKey = "pushnotification";

#endif
