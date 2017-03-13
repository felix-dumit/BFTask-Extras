//
//  BFTaskCompletionSource+Expire.m
//  Umwho
//
//  Created by Felix Dumit on 3/29/15.
//  Copyright (c) 2015 Umwho. All rights reserved.
//

#import "BFTask+Result.h"
#import "BFTask+Timeout.h"
#import "BFTaskCompletionSource+Task.h"

NSInteger const kBFTimeoutError = 80175555;

@interface NSError (BFCancel)

+(NSError*)boltsTimeoutError;

@end


@implementation BFTaskCompletionSource (Timeout)

+ (instancetype)taskCompletionSourceWithExpiration:(NSTimeInterval)timeout {
    BFTaskCompletionSource *taskCompletion = [BFTaskCompletionSource taskCompletionSource];
    [[BFTask taskWithDelay:timeout * 1000] continueWithBlock: ^id (BFTask *task) {
        [taskCompletion trySetTimedOut];
        return nil;
    }];
    return taskCompletion;
}

-(void)setTimedOut {
    [self setError:[NSError boltsTimeoutError]];
}

-(void)trySetTimedOut {
    [self trySetError:[NSError boltsTimeoutError]];
}

@end


@implementation BFTask (Timeout)

- (instancetype)setTimeout:(NSTimeInterval)timeout {
    return [self _continueTaskWithTimeout:timeout];
}

- (BFTask *)_continueTaskWithTimeout:(NSTimeInterval)timeout {
    BFTaskCompletionSource *tcs = [BFTaskCompletionSource taskCompletionSourceWithExpiration:timeout];
    [tcs setResultBasedOnTask:self];
    return tcs.task;
}

-(BOOL)hasTimedOut {
    return [self.error isTimeoutError];
}

@end


@implementation NSError (BFCancel)

+(NSError *)boltsTimeoutError {
    NSDictionary* userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(@"The task timed out", nil) };
    return [NSError errorWithDomain:BFTaskErrorDomain code:kBFTimeoutError userInfo:userInfo];
}

@end

@implementation NSError (TimeoutError)

-(BOOL)isTimeoutError {
    NSError* timeoutError = [NSError boltsTimeoutError];
    return [self.domain isEqualToString:timeoutError.domain] && self.code == timeoutError.code;
}

@end
