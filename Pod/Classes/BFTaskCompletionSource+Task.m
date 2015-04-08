//
//  BFTaskCompletionSource+Task.m
//  Pods
//
//  Created by Felix Dumit on 3/31/15.
//
//

#import "BFTaskCompletionSource+Task.h"

@implementation BFTaskCompletionSource (Task)

- (void)setResultBasedOnTask:(BFTask *)taskk {
    [taskk continueWithBlock: ^id (BFTask *task) {
        if (task.error) {
            [self trySetError:task.error];
        }
        else if (task.isCancelled) {
            [self trySetCancelled];
        }
        else if (task.exception) {
            [self trySetException:task.exception];
        }
        else {
            [self trySetResult:task.result];
        }
        return task;
    }];
}

@end
