//
//  ViewController.m
//  clock
//
//  Created by 田立彬 on 13-3-7.
//  Copyright (c) 2013年 bluevt. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.startButton setTitle:@"编辑" forState:UIControlStateNormal];
    self.datePicket.enabled = NO;
    
    AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDate* d = [delegate getDate];
    [self updateTitleLabel:d];

    [self.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTitleLabel:(NSDate*)date
{
    if (date == nil) {
        self.titleLabel.text = @"没有定时";
    }
    else {
        self.titleLabel.text = [NSString stringWithFormat:@"TIME:%@",date];
    }
}

- (IBAction)startPressed:(id)sender
{
    if (self.datePicket.enabled) {
        AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [delegate saveOpen:YES];
        [self.startButton setTitle:@"编辑" forState:UIControlStateNormal];
        self.datePicket.enabled = NO;
    }
    else {
        [self.startButton setTitle:@"完成" forState:UIControlStateNormal];
        self.datePicket.enabled = YES;
        AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [delegate resetClock:self.datePicket.date];
        [self updateTitleLabel:self.datePicket.date];
    }
}

- (IBAction)closePressed:(id)sender
{
    AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate saveOpen:NO];
    [self updateTitleLabel:nil];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
