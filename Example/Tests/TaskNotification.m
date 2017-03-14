//
//  TaskNotification.m
//  BFTask-Extras
//
//  Created by Felix Dumit on 11/30/16.
//  Copyright © 2016 Felix Dumit. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <Specta/Specta.h>
#import <BFTask_Extras/NSNotificationCenter+Bolts.h>

SpecBegin(TaskNotification)

describe(@"wait for notification", ^{
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    NSString* notificationName = @"NAME_NOTIFICATION";
    NSDictionary* userInfo = @{@"temp": @123};
    it(@"should wait for notification to fire", ^{
        waitUntil(^(DoneCallback done) {
            [[notificationCenter waitForNotificationNamed:notificationName] continueWithBlock:^id _Nullable(BFTask<NSNotification *> * _Nonnull t) {
                expect(t.result.userInfo).to.equal(userInfo);
                expect(t.result.name).to.equal(notificationName);
                expect(t.error).to.beNil();
                expect(t.cancelled).to.beFalsy();
                done();
                return t;
            }];
            [[BFTask taskWithDelay:100] continueWithSuccessBlock:^id _Nullable(BFTask * _Nonnull t) {
                [notificationCenter postNotificationName:notificationName object:nil userInfo:userInfo];
                return t;
            }];
        });
        
    });
});

SpecEnd


