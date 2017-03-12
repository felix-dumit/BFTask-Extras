//
//  BFTaskCompletionSource+Task.m
//  Pods
//
//  Created by Felix Dumit on 3/31/15.
//
//

#import "BFTaskCompletionSource+Task.h"
#import <Bolts/BFTask.h>

@implementation BFTaskCompletionSource (Task)

- (void)setResultBasedOnTask:(BFTask *)taskk includingCancel:(BOOL)includeCancel {
    [taskk continueWithBlock: ^id (BFTask *task) {
        if (task.error) {
            [self trySetError:task.error];
        }
        else if(task.isCancelled){
            if(includeCancel){
                [self trySetCancelled];
            }
        } else {
            [self trySetResult:task.result];
        }
        return task;
    }];
}

- (void)setResultBasedOnTask:(BFTask *)taskk {
    [self setResultBasedOnTask:taskk includingCancel:YES];
}

-(void)setError:(NSError *)error orResult:(id)result {
    if(error) {
        [self setError:error];
    } else {
        [self setResult:result];
    }
}

-(void)trySetError:(NSError *)error orResult:(id)result {
    if(error) {
        [self trySetError:error];
    } else {
        [self trySetResult:result];
    }
}

@end
