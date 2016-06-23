//
//  BFTaskImageViewTest.m
//  BFTask-Extras
//
//  Created by Felix Dumit on 4/5/15.
//  Copyright (c) 2015 Felix Dumit. All rights reserved.
//


#import <Expecta.h>
#import <Specta.h>
#import <BFTaskImageView.h>

SpecBegin(TaskImageView)

describe(@"set image based on tasks", ^{
    __block UIImage *image;
    __block BFTask *task;
    
    beforeEach ( ^{
        image = [UIImage imageNamed:@"james_image"];
        task = [BFTask taskWithResult:image];
    });
    
    it(@"will with task", ^{
        BFTaskImageView *imageView = [[BFTaskImageView alloc] initWithTask:task];
        waitUntil ( ^(DoneCallback done) {
            [task continueWithBlock: ^id (BFTask *task) {
                expect(imageView.image).to.equal(image);
                done();
                return nil;
            }];
        });
    });
    
    it(@"will allow setting a task", ^{
        BFTaskImageView *imageView = [[BFTaskImageView alloc] initWithImage:[UIImage imageNamed:@"rosie_image"]];
        imageView.task = task;
        waitUntil ( ^(DoneCallback done) {
            [task continueWithBlock: ^id (BFTask *task) {
                expect(imageView.image).to.equal(image);
                done();
                return nil;
            }];
        });
    });
    
    it(@"will not set image if failed", ^{
        UIImage *originalImage = [UIImage imageNamed:@"rosie_image"];
        BFTaskImageView *imageView = [[BFTaskImageView alloc] initWithImage:originalImage];
        task = [BFTask taskWithError:[NSError errorWithDomain:@"task.test" code:111 userInfo:nil]];
        imageView.task = task;
        waitUntil ( ^(DoneCallback done) {
            [task continueWithBlock: ^id (BFTask *task) {
                expect(imageView.image).to.equal(originalImage);
                done();
                return nil;
            }];
        });
    });
    
    it(@"will return task for current image", ^{
        BFTaskImageView *imageView = [[BFTaskImageView alloc] initWithImage:image];
        waitUntil ( ^(DoneCallback done) {
            [imageView.task continueWithBlock: ^id (BFTask *task) {
                expect(task.result).to.equal(image);
                done();
                return nil;
            }];
        });
    });
});

SpecEnd
