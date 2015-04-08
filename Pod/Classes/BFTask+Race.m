//
//  BFTask+Race.m
//  Pods
//
//  Created by Felix Dumit on 3/31/15.
//
//

#import "BFTaskCompletionSource+Task.h"
#import "BFTask+Race.h"

@implementation BFTask (Race)

+ (BFTask *)raceForTasks:(NSArray *)tasks {
    BFTaskCompletionSource *tsk = [BFTaskCompletionSource taskCompletionSource];
    
    for (BFTask *task in tasks) {
        [tsk setResultBasedOnTask:task];
    }
    return tsk.task;
}

@end
