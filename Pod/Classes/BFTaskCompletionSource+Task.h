//
//  BFTaskCompletionSource+Task.h
//  Pods
//
//  Created by Felix Dumit on 3/31/15.
//
//

#import <Bolts/BFTaskCompletionSource.h>

@class BFTask;

@interface BFTaskCompletionSource (Task)

- (void)setResultBasedOnTask:(BFTask *)taskk includingCancel:(BOOL)includeCancel;
- (void)setResultBasedOnTask:(BFTask *)taskk;

@end
