//
//  BFTaskImageView.m
//  Umwho
//
//  Created by Felix Dumit on 1/20/15.
//  Copyright (c) 2015 Umwho. All rights reserved.
//

#import "BFTaskImageView.h"
#import <Bolts/BFExecutor.h>

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

#if TARGET_OS_IPHONE
- (void)setTask:(BFTask *)task {
    [task continueWithExecutor:[BFExecutor mainThreadExecutor] withSuccessBlock: ^id (BFTask *imageTask) {
        UIImage *img = nil;
        if ([imageTask.result isKindOfClass:[UIImage class]]) {
            img = (UIImage *)imageTask.result;
        }
        else if ([imageTask.result isKindOfClass:[NSData class]]) {
            img = [UIImage imageWithData:imageTask.result];
        }
        if (img) {
            self.image = img;
        }
        return img;
    }];
}
#else
- (void)setTask:(BFTask *)task {
    [task continueWithExecutor:[BFExecutor mainThreadExecutor] withSuccessBlock: ^id (BFTask *imageTask) {
        NSImage *img = nil;
        if ([imageTask.result isKindOfClass:[NSImage class]]) {
            img = (NSImage *)imageTask.result;
        }
        else if ([imageTask.result isKindOfClass:[NSData class]]) {
            img = [[NSImage alloc] initWithData: imageTask.result];
        }
        if (img) {
            self.image = img;
        }
        return img;
    }];
}
#endif
@end

