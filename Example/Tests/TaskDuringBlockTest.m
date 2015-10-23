//
//  TaskDuringBlockTest.m
//  BFTask-Extras
//
//  Created by Felix Dumit on 8/28/15.
//  Copyright (c) 2015 Felix Dumit. All rights reserved.
//
#import <Expecta.h>
#import <Specta.h>
#import <BFTask+DuringBlock.h>

SpecBegin(TaskDuringBlock)

describe(@"race successfull tasks", ^{
    id result = @"result";
    id error = [NSError errorWithDomain:@"domain" code:444 userInfo:nil];
    id exception = [NSException exceptionWithName:@"name" reason:@"reason" userInfo:nil];
    __block BFTask *waitTask = nil;
    beforeEach( ^{
        waitTask = [BFTask taskWithDelay:1000];
    });
    
    it(@"will complete with correct result", ^{
        waitUntil( ^(DoneCallback done) {
            [[BFTask taskDuringBlock:^id {
                [waitTask waitUntilFinished];
                return result;
            }] continueWithBlock:^id (BFTask *task) {
                expect(task.result).to.equal(result);
                done();
                return nil;
            }];
        });
    });
    
    it(@"will will fail if return error", ^{
        waitUntil( ^(DoneCallback done) {
            [[BFTask taskDuringBlock:^id {
                [waitTask waitUntilFinished];
                return error;
            }] continueWithBlock:^id (BFTask *task) {
                expect(task.result).to.beNil();
                expect(task.error).to.equal(error);
                done();
                return nil;
            }];
        });
    });
    
    it(@"will will cancel if return cancelled task", ^{
        waitUntil( ^(DoneCallback done) {
            [[BFTask taskDuringBlock:^id {
                [waitTask waitUntilFinished];
                return [BFTask cancelledTask];
            }] continueWithBlock:^id (BFTask *task) {
                expect(task.result).to.beNil();
                expect(task.error).to.beNil();
                expect(task.cancelled).to.beTruthy();
                done();
                return nil;
            }];
        });
    });
    
    it(@"will get exception if returned an exception", ^{
        waitUntil( ^(DoneCallback done) {
            [[BFTask taskDuringBlock:^id {
                [waitTask waitUntilFinished];
                return [BFTask taskWithException:exception];
            }] continueWithBlock:^id (BFTask *task) {
                expect(task.exception).to.equal(exception);
                expect(task.result).to.beNil();
                expect(task.error).to.beNil();
                expect(task.faulted).to.beTruthy();
                done();
                return nil;
            }];
        });
    });
    
    it(@"will will get result if returned task", ^{
        waitUntil( ^(DoneCallback done) {
            [[BFTask taskDuringBlock:^id {
                [waitTask waitUntilFinished];
                return [BFTask taskWithResult:result];
            }] continueWithBlock:^id (BFTask *task) {
                expect(task.result).to.equal(result);
                expect(task.error).to.beNil();
                done();
                return nil;
            }];
        });
    });
});

SpecEnd