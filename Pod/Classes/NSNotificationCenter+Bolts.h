//
//  BFTask+Notification.h
//  Pods
//
//  Created by Felix Dumit on 11/30/16.
//
//

#import <Bolts/BFTask.h>

@interface NSNotificationCenter (Bolts)

/**
 Waits for NSNotification to post notification named
 
 @param notificationName notificationName name of the notification to be waited on
 @param object to observe the notification
 @return a task that completes when the notification is posted, the result contains the userInfo of the notification
 */
-(BFTask*)waitForNotificationNamed:(NSString*)notificationName object:(id)object;

-(BFTask<NSNotification*>*)waitForNotificationNamed:(NSString*)notificationName;

@end
