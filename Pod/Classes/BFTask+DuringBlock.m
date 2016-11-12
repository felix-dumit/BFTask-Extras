//
//  BFTask+DuringBlock.m
//  Pods
//
//  Created by Felix Dumit on 8/28/15.
//
//

#import "BFTask+DuringBlock.h"
#import "BFTaskCompletionSource+Task.h"

@implementation BFTask (DuringBlock)

+ (BFTask *)taskDuringBlock:(BFTaskExecutionBlock)block {
    BFTaskCompletionSource *tcs = [BFTaskCompletionSource taskCompletionSource];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id result = block();
        
        if ([result isKindOfClass:[NSError class]]) {
            [tcs trySetError:result];
        } else if ([result isKindOfClass:[BFTask class]]) {
            [tcs setResultBasedOnTask:result
                      includingCancel:YES];
        } else {
            [tcs trySetResult:result];
        }
    });
    
    return tcs.task;
}

@end
