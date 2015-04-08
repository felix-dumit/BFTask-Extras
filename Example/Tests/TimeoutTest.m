//
//  TimeoutTest.m
//  BFTask-Extras
//
//  Created by Felix Dumit on 4/5/15.
//  Copyright (c) 2015 Felix Dumit. All rights reserved.
//

//
//  TaskResultTest.m
//  BFTask-Extras
//
//  Created by Felix Dumit on 4/5/15.
//  Copyright (c) 2015 Felix Dumit. All rights reserved.
//

#import <Expecta.h>
#import <Specta.h>
#import <BFTask+Timeout.h>

SpecBegin(TaskTimeout)

describe(@"task completion", ^{
    __block BFTaskCompletionSource *tsk;
    
    beforeEach ( ^{
        tsk = [BFTaskCompletionSource taskCompletionSourceWithExpiration:2];
    });
    
    it(@"it will expire", ^{
        [[BFTask taskWithDelay:3000] continueWithBlock: ^id (BFTask *task) {
            [tsk setResult:@"result"];
            return nil;
        }];
        waitUntil ( ^(DoneCallback done) {
            [tsk.task continueWithBlock: ^id (BFTask *task) {
                expect(task.cancelled).to.beTruthy();
                expect(task.result).to.beNil();
                done();
                return nil;
            }];
        });
    });
    
    it(@"will not expire", ^{
        [[BFTask taskWithDelay:1000] continueWithBlock: ^id (BFTask *task) {
            [tsk setResult:@"result"];
            return nil;
        }];
        waitUntil ( ^(DoneCallback done) {
            [tsk.task continueWithBlock: ^id (BFTask *task) {
                expect(task.cancelled).to.beFalsy();
                expect(task.result).to.equal(@"result");
                done();
                return nil;
            }];
        });
    });
});


describe(@"it will work with set timeout", ^{
    __block BFTask *task;
    
    beforeEach ( ^{
        task = [[BFTask taskWithDelay:2000] continueWithBlock: ^id (BFTask *task) {
            return @"result";
        }];
    });
    
    it(@"will expire", ^{
        waitUntil ( ^(DoneCallback done) {
            [[task setTimeout:1] continueWithBlock: ^id (BFTask *task) {
                expect(task.cancelled).to.beTruthy();
                expect(task.result).to.beNil();
                done();
                return nil;
            }];
        });
    });
    
    it(@"will not expire", ^{
        waitUntil ( ^(DoneCallback done) {
            [[task setTimeout:3] continueWithBlock: ^id (BFTask *task) {
                expect(task.cancelled).to.beFalsy();
                expect(task.result).to.equal(@"result");
                done();
                return nil;
            }];
        });
    });
});

SpecEnd
