//
//  ViewController.h
//  clock
//
//  Created by 田立彬 on 13-3-7.
//  Copyright (c) 2013年 bluevt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel* titleLabel;
@property (nonatomic, retain) IBOutlet UIButton* startButton;
@property (nonatomic, retain) IBOutlet UIButton* closeButton;
@property (nonatomic, retain) IBOutlet UIDatePicker* datePicket;

- (IBAction)startPressed:(id)sender;
- (IBAction)closePressed:(id)sender;

@end
