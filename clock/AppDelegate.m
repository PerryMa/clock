//
//  AppDelegate.m
//  clock
//
//  Created by 田立彬 on 13-3-7.
//  Copyright (c) 2013年 bluevt. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"


#define kClockDate @"kClockDate"
#define kClockOpen  @"kClockOpen"

@interface AppDelegate()


@end


@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    [self cleanNotifications];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self cleanNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 应用收到通知时，会调到下面的回调函数里，当应用在启动状态，收到通知时不会自动弹出提示框，而应该由程序手动实现。
// 只有在退出应用后，收到本地通知，系统才会弹出提示。
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (application.applicationState == UIApplicationStateActive) {
        // 如不加上面的判断，点击通知启动应用后会重复提示
        // 这里暂时用简单的提示框代替。
        // 也可以做复杂一些，播放想要的铃声。
        UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@""
                                                         message:@"时间到"
                                                        delegate:self
                                               cancelButtonTitle:@"关闭"
                                               otherButtonTitles:nil, nil] autorelease];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self resetClock:nil];
    }
}


- (void)saveOpen:(BOOL)open
{
    self.open = open;
    [[NSUserDefaults standardUserDefaults] setBool:open forKey:kClockOpen];
}
- (BOOL)getClockOpen
{
    self.open = [[NSUserDefaults standardUserDefaults] integerForKey:kClockOpen];
    return self.open;
}

- (void)saveDate:(NSDate*)date
{
    if (date != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:kClockDate];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kClockDate];
    }
}
- (NSDate*)getDate
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kClockDate];
}


- (void)cleanNotifications
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)resetClock:(NSDate*)date
{
    // 试图取消以前的通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [self saveDate:date];
    
    if (date == nil) {
        return;
    }
    
    // 设置新的通知
    UILocalNotification* noti = [[[UILocalNotification alloc] init] autorelease];
    // 设置响应时间
    noti.fireDate = date;
    // 设置时区，默认即可
    noti.timeZone = [NSTimeZone defaultTimeZone];
    
    // 重复提醒，这里设置一分钟提醒一次，只有启动应用，才会停止提醒。
    noti.repeatInterval = NSMinuteCalendarUnit;
//    noti.repeatCalendar = nil;

    // 提示时的显示信息
    noti.alertBody = @"时间到";
    // 下面属性仅在提示框状态时的有效，在横幅时没什么效果
    noti.hasAction = NO;
    noti.alertAction = @"open";
    
    // 这里可以设置从通知启动的启动界面，类似Default.png的作用。
    noti.alertLaunchImage = @"lunch.png";
    
    // 提醒时播放的声音
    // 这里用系统默认的声音。也可以自己把声音文件加到工程中来，把文件名设在下面。最后可以播放时间长点，闹钟啊
    noti.soundName = UILocalNotificationDefaultSoundName;
    
    // 这里是桌面上程序右上角的数字图标，设0的话，就没有。类似QQ的未读消息数。
    noti.applicationIconBadgeNumber = 1;
    
    // 这个属性设置了以后，在通过本应用通知启动应用时，在下面回调中
    // - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    // lanuchOptions里面会含有这里的userInfo.
    // 正常点击应用图标进入应用，这个属性就用不到了
    noti.userInfo = [NSDictionary dictionaryWithObject:@"value" forKey:@"key"];
    
    // 生效
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
}

@end
