//
//  BFTask-blocks.h
//  Pods
//
//  Created by Felix Dumit on 4/11/15.
//
//


#import <Bolts/BFTask.h>
@class NSError;

NS_ASSUME_NONNULL_BEGIN

@interface BFTask<__covariant ResultType>(Blocks)

typedef __nullable id(^BFResultBlock)(ResultType result, NSError *error);
typedef __nullable id (^BFSuccessResultBlock)(ResultType result);
typedef __nullable id (^BFTaskExecutionBlock)(void);
typedef __nullable id (^BFErrorResultBlock)(NSError *error);
typedef  BFTask * __nullable(^BFPFinallyBlock)(BFTask<ResultType> *task);

@end

NS_ASSUME_NONNULL_END

//typedef id (^BFResultBlock)(id result, NSError *error);
//typedef id (^BFSuccessResultBlock)(id result);
//typedef id (^BFTaskExecutionBlock)();
//typedef id (^BFErrorResultBlock)(NSError *error);
//typedef BFTask *(^BFPFinallyBlock)(BFTask *task);
