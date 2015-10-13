//
//  BFTaskImageView.h
//  Umwho
//
//  Created by Felix Dumit on 1/20/15.
//  Copyright (c) 2015 Umwho. All rights reserved.
//

#import <Bolts.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

@interface BFTaskImageView : UIImageView
#else
#import <Cocoa/Cocoa.h>

@interface BFTaskImageView : NSImageView
#endif

@property (strong, nonatomic) BFTask *task;

- (instancetype)initWithTask:(BFTask *)task;

@end
