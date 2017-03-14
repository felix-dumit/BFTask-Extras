//
//  BFTask+Notification.m
//  Pods
//
//  Created by Felix Dumit on 11/30/16.
//
//

#import <Bolts/BFTaskCompletionSource.h>
#import "NSNotificationCenter+Bolts.h"

@implementation NSNotificationCenter (Bolts)

-(BFTask*)waitForNotificationNamed:(NSString*)notificationName object:(id)object {
    BFTaskCompletionSource *tsk = [BFTaskCompletionSource taskCompletionSource];
    
    __weak typeof(self) weakSelf = self;
    __block __weak id notificationObserver = [self addObserverForName:notificationName object:object queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [tsk trySetResult:note];
        [weakSelf removeObserver:notificationObserver];
    }];
    return tsk.task;
}

-(BFTask*)waitForNotificationNamed:(NSString*)notificationName {
    return [self waitForNotificationNamed:notificationName object:nil];
}

@end
