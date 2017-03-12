//
//  BFTaskCompletionSource+Task.h
//  Pods
//
//  Created by Felix Dumit on 3/31/15.
//
//

#import <Bolts/BFTaskCompletionSource.h>

@class BFTask;

@interface BFTaskCompletionSource<__covariant ResultType> (Task)

- (void)setResultBasedOnTask:(BFTask *)taskk includingCancel:(BOOL)includeCancel;
- (void)setResultBasedOnTask:(BFTask *)taskk;
- (void)setError:(NSError*)error orResult:(ResultType)result;
- (void)trySetError:(NSError*)error orResult:(ResultType)result;

@end
