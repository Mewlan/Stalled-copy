//
//  ViewController.h
//  Stalled
//
//  Created by Mewlan Musajan on 11/22/13.
//  Copyright (c) 2013 Mewlan Musajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *numberOfOperations;
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;
@property (strong, nonatomic) IBOutlet UILabel *progressLabel;
@property (strong, nonatomic) IBOutlet UILabel *info;
@property (strong, nonatomic) IBOutlet UIButton *go;

- (IBAction)go:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (void)processChunk:(NSTimer *)timer;
@end
