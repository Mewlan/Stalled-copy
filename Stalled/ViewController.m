//
//  ViewController.m
//  Stalled
//
//  Created by Mewlan Musajan on 11/22/13.
//  Copyright (c) 2013 Mewlan Musajan. All rights reserved.
//

#import "ViewController.h"
#import "squareRootBatch.h"

#define kTimeInterval (1.0/60.0)
#define kBatchSize 10

@interface ViewController ()
@property (assign, nonatomic) BOOL processRunning;
@property (assign, nonatomic) NSInteger current;
@property (assign, nonatomic) double nextSquareRoot;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)go:(id)sender
{
    if (!self.processRunning) {
        [self.numberOfOperations resignFirstResponder];
        [self.numberOfOperations setHidden:YES];
        [self.info setHidden:YES];
        [self.progressBar setHidden:NO];
        [self.progressLabel setHidden:NO];        NSInteger operationCount = [self.numberOfOperations.text integerValue];
        squareRootBatch *batch = [[squareRootBatch alloc] initWhithMaxNumber:operationCount];
        
        [NSTimer scheduledTimerWithTimeInterval:kTimeInterval
                                         target:self
                                       selector:@selector(processChunk:)
                                       userInfo:batch
                                        repeats:YES];
        [self.go setTitle:@"Stop" forState:UIControlStateNormal];
        self.processRunning = YES;
    }
    else {
        [self.numberOfOperations becomeFirstResponder];
        [self.numberOfOperations setHidden:NO];
        [self.info setHidden:NO];
        [self.progressBar setHidden:YES];
        [self.progressLabel setHidden:YES];
        self.processRunning = NO;
        [self.go setTitle:@"Go" forState:UIControlStateNormal];
    }
}

- (void)processChunk:(NSTimer *)timer
{
    if (!self.processRunning) {
        // Cancelled
        [timer invalidate];
        self.progressLabel.text = @"Calculations Cancelled";
        return;
    }
    
    squareRootBatch *batch = (squareRootBatch *)[timer userInfo];
    NSTimeInterval endTime = [NSDate timeIntervalSinceReferenceDate] + (kTimeInterval / 2.0);
    BOOL isDone = NO;
    while (([NSDate timeIntervalSinceReferenceDate] < endTime) && !isDone) {
        for (int i = 0; i < kBatchSize; i++) {
            if (![batch hasNext]) {
                isDone = YES;
                i = kBatchSize;
            }
            else {
                self.current = batch.current;
                self.nextSquareRoot = [batch next];
                NSLog(@"Calculated square root of %ld as %.6f", (long)self.current, self.nextSquareRoot);
            }
        }
    }
    
    self.progressLabel.text = [batch percentCompeletedText];
    self.progressBar.progress = [batch percentCompeleted];
    
    if (isDone) {
        [self.numberOfOperations becomeFirstResponder];
        [self.numberOfOperations setHidden:NO];
        [self.progressBar setHidden:YES];
        self.processRunning = NO;        [timer invalidate];
        self.processRunning = NO;
        self.progressLabel.text = [NSString stringWithFormat:@"Calculations Finished, Calculated square root of %ld as %.6f", (long)self.current, self.nextSquareRoot];
        [self.go setTitle:@"Go" forState:UIControlStateNormal];
    }
}


- (IBAction)backgroundTap:(id)sender
{
    [self.numberOfOperations resignFirstResponder];
}

@end
