//
//  BFTask+Notification.h
//  Pods
//
//  Created by Felix Dumit on 11/30/16.
//
//

#import <Bolts/BFTask.h>

@interface BFTask (Notification)

/**
 Waits for NSNotification to post notification named

 @param notificationName notificationName name of the notification to be waited on
 @param object
 @return a task that completes when the notification is posted, the result contains the userInfo of the notification
 */
+(BFTask*)waitForNotificationNamed:(NSString*)notificationName object:(id)object;

+(BFTask<NSDictionary*>*)waitForNotificationNamed:(NSString*)notificationName;

@end
