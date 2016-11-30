//
//  TaskNotification.m
//  BFTask-Extras
//
//  Created by Felix Dumit on 11/30/16.
//  Copyright © 2016 Felix Dumit. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <Specta/Specta.h>
#import <BFTask_Extras/BFTask+Notification.h>

SpecBegin(TaskNotification)

describe(@"wait for notification", ^{
    NSString* notificationName = @"NAME_NOTIFICATION";
    NSDictionary* userInfo = @{@"temp": @123};
    it(@"should wait for notification to fire", ^{
        waitUntil(^(DoneCallback done) {
            [[BFTask waitForNotificationNamed:notificationName] continueWithBlock:^id _Nullable(BFTask * _Nonnull t) {
                expect(t.result).to.equal(userInfo);
                expect(t.error).to.beNil();
                expect(t.cancelled).to.beFalsy();
                done();
                return t;
            }];
            [[BFTask taskWithDelay:100] continueWithSuccessBlock:^id _Nullable(BFTask * _Nonnull t) {
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil userInfo:userInfo];
                return t;
            }];
        });
        
    });
});

SpecEnd


