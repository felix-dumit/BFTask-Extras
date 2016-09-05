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
        [taskCompletion trySetError:[NSError boltsTimeoutError]];
        return nil;
    }];
    return taskCompletion;
}

@end


@implementation BFTask (Timeout)

- (instancetype)setTimeout:(NSTimeInterval)timeout {
    return [self _continueTaskWithTimeout:timeout];
}

- (BFTask *)_continueTaskWithTimeout:(NSTimeInterval)timeout {
    BFTaskCompletionSource *tsk = [BFTaskCompletionSource taskCompletionSourceWithExpiration:timeout];
    [tsk setResultBasedOnTask:self];
    return tsk.task;
}

-(BOOL)hasTimedOut {
    return [self.error.domain isEqualToString:BFTaskErrorDomain] && self.error.code == kBFTimeoutError;
}

@end


@implementation NSError (BFCancel)

+(NSError *)boltsTimeoutError {
    NSDictionary* userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(@"The task timed out", nil) };
    return [NSError errorWithDomain:BFTaskErrorDomain code:kBFTimeoutError userInfo:userInfo];
}

@end
