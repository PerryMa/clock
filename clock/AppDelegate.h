//
//  AppDelegate.h
//  clock
//
//  Created by 田立彬 on 13-3-7.
//  Copyright (c) 2013年 bluevt. All rights reserved.
//

// 不足之处：
/*
 1. 不能设置提示框样式，是横幅还是弹框
 2. 不能灵活设置重复的时间，只能按秒，分，小时，天，周，月这样设置
 
 
 
 */

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic, assign) BOOL open;



- (void)saveOpen:(BOOL)open;
- (BOOL)getClockOpen;

- (void)saveDate:(NSDate*)date;
- (NSDate*)getDate;

- (void)resetClock:(NSDate*)date;


@end
