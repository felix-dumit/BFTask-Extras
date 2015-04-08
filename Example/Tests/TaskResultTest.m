//
//  TaskResultTest.m
//  BFTask-Extras
//
//  Created by Felix Dumit on 4/5/15.
//  Copyright (c) 2015 Felix Dumit. All rights reserved.
//

#import <Expecta.h>
#import <Specta.h>
#import <BFTask+Result.h>

SpecBegin(TaskResult)

describe(@"task result", ^{
    __block BFTask *task;
    
    beforeEach ( ^{
        task = [BFTask taskWithResult:@"result"];
    });
    
    it(@"it can cast the result of block", ^{
        waitUntil ( ^(DoneCallback done) {
            [task continueWithResultBlock: ^id (id result, NSError *error) {
                expect(result).to.beKindOf([NSString class]);
                expect(result).to.equal(@"result");
                expect(error).to.beNil();
                done();
                return nil;
            }];
        });
    });
    
    
    it(@"will call the success block", ^{
        BFTask *task = [BFTask taskWithResult:@"result"];
        waitUntil ( ^(DoneCallback done) {
            [task continueWithSuccessResultBlock: ^id (NSString *result) {
                expect(result).to.equal(@"result");
                expect(result).to.beKindOf([NSString class]);
                done();
                return nil;
            }];
        });
    });
});

describe(@"tasks with errors", ^{
    __block BFTask *task;
    __block NSError *error;
    
    beforeEach ( ^{
        error = [NSError errorWithDomain:@"domain" code:404 userInfo:nil];
        task = [BFTask taskWithError:error];
    });
    
    it(@"will get the error of a block", ^{
        waitUntil ( ^(DoneCallback done) {
            [task continueWithResultBlock: ^id (id result, NSError *err) {
                expect(result).to.beNil();
                expect(err).to.equal(error);
                done();
                return nil;
            }];
        });
    });
    
    it(@"will not call the success block", ^{
        waitUntil ( ^(DoneCallback done) {
            [[task continueWithSuccessResultBlock: ^id (id result) {
                return @"result";
            }] continueWithBlock: ^id (BFTask *task) {
                expect(task.result).to.beNil();
                expect(task.error).to.equal(error);
                done();
                return nil;
            }];
        });
    });
});

SpecEnd
