//
//  BFTask+DuringBlock.h
//  Pods
//
//  Created by Felix Dumit on 8/28/15.
//
//

#import "BFTask.h"
#import "BFTask-blocks.h"

@interface BFTask (DuringBlock)

+ (BFTask *)taskDuringBlock:(BFTaskExecutionBlock)block;

@end
