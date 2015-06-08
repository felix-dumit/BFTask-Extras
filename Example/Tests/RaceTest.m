//
//  RaceTest.m
//  BFTask-Extras
//
//  Created by Felix Dumit on 4/5/15.
//  Copyright (c) 2015 Felix Dumit. All rights reserved.
//

#import <Expecta.h>
#import <Specta.h>
#import <BFTask+Race.h>

SpecBegin(TaskRace)

describe(@"race successfull tasks", ^{
    __block BFTask *task1;
    __block BFTask *task2;
    
    beforeEach ( ^{
        task1 = [[BFTask taskWithDelay:1000] continueWithBlock: ^id (BFTask *task) {
            return @"result1";
        }];
        
        task2 = [[BFTask taskWithDelay:2000] continueWithBlock: ^id (BFTask *task) {
            return @"result2";
        }];
    });
    
    it(@"will complete after the first task", ^{
        waitUntil ( ^(DoneCallback done) {
            [[BFTask raceForTasks:@[task1, task2]] continueWithBlock: ^id (BFTask *task) {
                expect(task.result).to.equal(task1.result);
                done();
                return nil;
            }];
        });
    });
});

describe(@"it will complete after the first error", ^{
    __block BFTask *task1;
    __block BFTask *task2;
    NSError *error = [NSError errorWithDomain:@"domain" code:100 userInfo:nil];
    
    beforeEach ( ^{
        task1 = [[BFTask taskWithDelay:1000] continueWithBlock: ^id (BFTask *task) {
            return [BFTask taskWithError:error];
        }];
        
        task2 = [[BFTask taskWithDelay:2000] continueWithBlock: ^id (BFTask *task) {
            return @"result2";
        }];
    });
    
    it(@"will fail after the first error", ^{
        waitUntil ( ^(DoneCallback done) {
            [[BFTask raceForTasks:@[task1, task2]] continueWithBlock: ^id (BFTask *task) {
                expect(task.result).to.beNil();
                expect(task.error).to.equal(error);
                done();
                return nil;
            }];
        });
    });
});

describe(@"it will not complete after the first cancel", ^{
    __block BFTask *task1;
    __block BFTask *task2;
    __block BFTask *task3;
    
    beforeEach ( ^{
        task1 = [[BFTask taskWithDelay:1000] continueWithBlock: ^id (BFTask *task) {
            return [BFTask cancelledTask];
        }];
        
        task2 = [[BFTask taskWithDelay:2000] continueWithBlock: ^id (BFTask *task) {
            return @"result2";
        }];
        
        task3 = [[BFTask taskWithDelay:1500] continueWithBlock: ^id (BFTask *task) {
            return [BFTask cancelledTask];
        }];
    });
    
    it(@"will not cancel after the first cancel", ^{
        waitUntil ( ^(DoneCallback done) {
            [[BFTask raceForTasks:@[task1, task2]] continueWithBlock: ^id (BFTask *task) {
                expect(task.result).to.equal(@"result2");
                expect(task.cancelled).to.beFalsy();
                done();
                return nil;
            }];
        });
    });
    
    it(@"will cancel after all cancel", ^{
        waitUntil ( ^(DoneCallback done) {
            [[BFTask raceForTasks:@[task1, task3]] continueWithBlock: ^id (BFTask *task) {
                expect(task.result).to.beNil();
                expect(task.cancelled).to.beTruthy();
                done();
                return nil;
            }];
        });
    });
});




SpecEnd
