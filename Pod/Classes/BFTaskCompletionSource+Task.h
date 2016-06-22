//
//  BFTaskCompletionSource+Task.h
//  Pods
//
//  Created by Felix Dumit on 3/31/15.
//
//

#import <Bolts/BFTask.h>
#import <Bolts/BFTaskCompletionSource.h>

@interface BFTaskCompletionSource (Task)

- (void)setResultBasedOnTask:(BFTask *)taskk includingCancel:(BOOL)includeCancel;
- (void)setResultBasedOnTask:(BFTask *)taskk;

@end
