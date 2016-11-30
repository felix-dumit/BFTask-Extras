//
//  BFTask+Notification.m
//  Pods
//
//  Created by Felix Dumit on 11/30/16.
//
//

#import <Bolts/BFTaskCompletionSource.h>
#import "BFTask+Notification.h"

@implementation BFTask (Notification)

+(BFTask*)waitForNotificationNamed:(NSString*)notificationName object:(id)object {
    BFTaskCompletionSource *tsk = [BFTaskCompletionSource taskCompletionSource];
    
    __block __weak id notificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:notificationName object:object queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [tsk trySetResult:note.userInfo];
        [[NSNotificationCenter defaultCenter] removeObserver:notificationObserver];
    }];
    return tsk.task;
}

+(BFTask*)waitForNotificationNamed:(NSString*)notificationName {
    return [self waitForNotificationNamed:notificationName object:nil];
}

@end
