//
//  BFTask+DuringBlock.h
//  Pods
//
//  Created by Felix Dumit on 8/28/15.
//
//

#import "BFTask-blocks.h"
#import <Bolts/BFTask.h>

@interface BFTask (DuringBlock)

+ (BFTask *)taskDuringBlock:(BFTaskExecutionBlock)block;

@end
