//
//  BFTask+Result.m
//  Umwho
//
//  Created by Felix Dumit on 2/14/15.
//  Copyright (c) 2015 Umwho. All rights reserved.
//

#import "BFTask+Result.h"

@implementation BFTask (Result)

- (instancetype)continueWithResultBlock:(BFResultBlock)block {
    return [self continueWithExecutor:[BFExecutor defaultExecutor] withResultBlock:block];
}

- (instancetype)continueWithExecutor:(BFExecutor *)executor withResultBlock:(BFResultBlock)block {
    return [self continueWithExecutor:executor withBlock: ^id (BFTask *task) {
        block(task.result, task.error);
        return task;
    }];
}

- (instancetype)continueWithSuccessResultBlock:(BFSuccessResultBlock)block {
    return [self continueWithExecutor:[BFExecutor defaultExecutor] withSuccessResultBlock:block];
}

- (instancetype)continueWithExecutor:(BFExecutor *)executor withSuccessResultBlock:(BFSuccessResultBlock)block {
    return [self continueWithExecutor:executor withSuccessBlock: ^id (BFTask *task) {
        block(task.result);
        return task;
    }];
}

@end
