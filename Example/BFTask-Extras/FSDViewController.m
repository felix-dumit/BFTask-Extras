//
//  FSDViewController.m
//  BFTask-Extras
//
//  Created by Felix Dumit on 03/31/2015.
//  Copyright (c) 2014 Felix Dumit. All rights reserved.
//

#import "FSDViewController.h"
#import "BFTask-Extras.h"

@interface FSDViewController ()
@property (weak, nonatomic) IBOutlet BFTaskImageView *imageView1;
@property (weak, nonatomic) IBOutlet BFTaskImageView *imageView2;
@property (weak, nonatomic) IBOutlet BFTaskImageView *imageView3;

@end

@implementation FSDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView1.image = [UIImage imageNamed:@"loading"];
    self.imageView2.image = [UIImage imageNamed:@"loading"];
    self.imageView3.image = [UIImage imageNamed:@"loading"];
    
    [self loadImage1];
    [self loadImage2];
    [self loadImage3];

    
    [BFTask taskWithDelay:1000].then( ^id (BFTask *task) {
        return [BFTask taskWithResult:@{ @"bob": @10 }];
    }).then( ^id (NSDictionary *result) {
        NSLog(@"then method");
        return nil;
    }).catchOnMain( ^id (NSError *error) {
        NSLog(@"catch method");
        return nil;
    }).finally( ^id (BFTask *task) {
        return nil;
    });
}

- (BFTask *)taskForDownloadingSampleImage {
    //for the sake of the example, will just simulate a loading of 3s
    return [[BFTask taskWithDelay:3000] continueWithBlock: ^id (BFTask *task) {
        return [UIImage imageNamed:@"rosie_image"];
    }];
}

- (void)loadImage1 {
    //will expire after 1s
    BFTaskCompletionSource *tsk = [BFTaskCompletionSource taskCompletionSourceWithExpiration:1];
    
    //example of using the result blocks
    [[self taskForDownloadingSampleImage] continueWithSuccessResultBlock: ^id (UIImage *image) {
        //need to use try method because it could have expired already
        [tsk trySetResult:image];
        return nil;
    }];
    
    // task will timeout since loading is 3s and timeout is 1s
    BFTask *imageTask1 = [tsk.task
                          continueWithBlock: ^id (BFTask *task) {
                              if (task.hasTimedOut) {
                                  return [UIImage imageNamed:@"timeout"];
                              }
                              
                              return task;
                          }];
    
    // will show timeout image
    self.imageView1.task = imageTask1;
}

// this is the exact same as load image 1, except with using the setTimeout method
- (void)loadImage2 {
    // wont expire since this is 20s timeout
    BFTask *imageTask2 = [[[self taskForDownloadingSampleImage] setTimeout:20] continueWithBlock: ^id (BFTask *task) {
        if (task.hasTimedOut) {
            return [UIImage imageNamed:@"timeout"];
        }
        
        return task;
    }];
    
    // will show rosie_image
    self.imageView2.task = imageTask2;
}

// will display the image that loads first
- (void)loadImage3 {
    BFTask *raceTask1 = [[BFTask taskWithDelay:100] continueWithBlock: ^id (BFTask *task) {
        return [UIImage imageNamed:@"rosie_image"];
    }];
    
    // exaple of task during block;
    BFTask *raceTask2 = [BFTask taskDuringBlock:^id {
        NSURL *url = [NSURL URLWithString:@"https://international.download.nvidia.com/geforce-com/international/images/assassins-creed-iv-black-flag/assassins-creed-iv-black-flag-pc-screenshot-01.png"];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        return image;
    }];
    
    //will show rosie_image if image from network takes too long
    self.imageView3.task = [BFTask raceForTasks:@[raceTask1, raceTask2]];
}

@end
