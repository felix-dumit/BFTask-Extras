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

#import <Expecta/Expecta.h>
#import <Specta/Specta.h>
#import <BFTask_Extras/BFTask+Timeout.h>

SpecBegin(TaskTimeout)

describe(@"task completion", ^{
    __block BFTaskCompletionSource *tcs;
    
    beforeEach ( ^{
        tcs = [BFTaskCompletionSource taskCompletionSourceWithExpiration:2];
    });
    
    it(@"it will expire", ^{
        [[BFTask taskWithDelay:3000] continueWithBlock: ^id (BFTask *task) {
            [tcs trySetResult:@"result"];
            return nil;
        }];
        waitUntil ( ^(DoneCallback done) {
            [tcs.task
             continueWithBlock: ^id (BFTask *task) {
                 expect(task.cancelled).to.beFalsy();
                 expect(task.result).to.beNil();
                 expect(task.error.code).to.equal(kBFTimeoutError);
                 expect(task.error.isTimeoutError).to.beTruthy();
                 expect(task.hasTimedOut).to.beTruthy();
                 done();
                 return nil;
             }];
        });
    });
    
    it(@"will not expire", ^{
        [[BFTask taskWithDelay:1000] continueWithBlock: ^id (BFTask *task) {
            [tcs trySetResult:@"result"];
            return nil;
        }];
        waitUntil ( ^(DoneCallback done) {
            [tcs.task
             continueWithBlock: ^id (BFTask *task) {
                 expect(task.cancelled).to.beFalsy();
                 expect(task.error).to.beNil();
                 expect(task.hasTimedOut).to.beFalsy();
                 expect(task.result).to.equal(@"result");
                 done();
                 return nil;
             }];
        });
    });
    
    
    it(@"will not have timeout error", ^{
        [[BFTask taskWithDelay:1000] continueWithBlock:^id _Nullable(BFTask * task) {
            [tcs trySetError:[NSError errorWithDomain:@"aa" code:222 userInfo:nil]];
            return nil;
        }];
        
        waitUntil(^(DoneCallback done) {
            [tcs.task continueWithBlock:^id _Nullable(BFTask * task) {
                expect(task.error).to.beTruthy();
                expect(task.error.isTimeoutError).to.beFalsy();
                expect(task.hasTimedOut).to.beFalsy();
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
                expect(task.cancelled).to.beFalsy();
                expect(task.error.code).to.equal(kBFTimeoutError);
                expect(task.hasTimedOut).to.beTruthy();
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
                expect(task.error).to.beFalsy();
                expect(task.hasTimedOut).to.beFalsy();
                expect(task.result).to.equal(@"result");
                done();
                return nil;
            }];
        });
    });
});

SpecEnd
