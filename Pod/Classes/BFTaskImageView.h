//
//  BFTaskImageView.h
//  Umwho
//
//  Created by Felix Dumit on 1/20/15.
//  Copyright (c) 2015 Umwho. All rights reserved.
//

#import <Bolts/BFTask.h>

#if TARGET_OS_WATCH

#undef BFImageView

#elif TARGET_OS_IOS

#import <UIKit/UIKit.h>
#define BFImage UIImage
#define BFImageView UIImageView

#elif TARGET_OS_MAC

#import <Cocoa/Cocoa.h>
#define BFImage NSImage
#define BFImageView NSImageView

#endif



#ifdef BFImageView
@interface BFTaskImageView: BFImageView

@property (strong, nonatomic) BFTask<BFImage*> *task;

- (instancetype)initWithTask:(BFTask<BFImage*> *)task;

@end
#endif
