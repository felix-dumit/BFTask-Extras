//
//  BFTask+Result.h
//  Umwho
//
//  Created by Felix Dumit on 2/14/15.
//  Copyright (c) 2015 Umwho. All rights reserved.
//

#import "BFTask-blocks.h"
#import <Bolts/BFTask.h>

@class BFExecutor;

@interface BFTask (Result)

- (instancetype)continueWithResultBlock:(BFResultBlock)block NS_SWIFT_NAME(continueWithResult(block:));

- (instancetype)continueWithExecutor:(BFExecutor *)executor
                     withResultBlock:(BFResultBlock)block NS_SWIFT_NAME(continueWithResult(executor:block:));

- (instancetype)continueWithSuccessResultBlock:(BFSuccessResultBlock)block NS_SWIFT_NAME(continueWithSuccessResult(block:));

- (instancetype)continueWithExecutor:(BFExecutor *)executor
              withSuccessResultBlock:(BFSuccessResultBlock)block NS_SWIFT_NAME(continueWithSuccessResult(executor:block:));

@end
