//
//  BFTaskImageView.m
//  Umwho
//
//  Created by Felix Dumit on 1/20/15.
//  Copyright (c) 2015 Umwho. All rights reserved.
//

#import "BFTaskImageView.h"
#import <Bolts/BFExecutor.h>

#ifdef BFImageView
@implementation BFTaskImageView

- (instancetype)initWithTask:(BFTask *)task {
    if (self = [super init]) {
        self.task = task;
    }
    return self;
}

- (BFTask *)task {
    return [BFTask taskWithResult:self.image];
}

- (void)setTask:(BFTask *)task {
    [task continueWithExecutor:[BFExecutor mainThreadExecutor] withSuccessBlock: ^id (BFTask *imageTask) {
        BFImage *img = nil;
        if ([imageTask.result isKindOfClass:[BFImage class]]) {
            img = (BFImage*)imageTask.result;
        }
        else if ([imageTask.result isKindOfClass:[NSData class]]) {
            img = [[BFImage alloc] initWithData:imageTask.result];
        }
        if (img) {
            [self setImage:img];
        }
        return img;
    }];
}

@end
#endif


