//
//  DMAppDelegateManager.h
//  DMAnimation
//
//  Created by 张炯 on 2017/8/30.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMApplicationDelegate.h"
#import <UIKit/UIKit.h>

@interface DMAppDelegateManager : NSObject


/**
 模块管理类
 */


+ (instancetype)sharedInstance;

/**
 注册模块，主要用于处理AppDelegate中的事件
 
 @param modlue 模块类Class
 */
- (void)registerModule:(Class <DMApplicationDelegate>)modlue;

/**
 应用启动完成
 
 @param options 启动参数
 */
- (void)action_applicationDidFinishLaunchingWithOptions:(NSDictionary *)options;

/**
 程序暂行
 */
- (void)action_applicationWillResignActive;

/**
 程序已经进入后台
 */
- (void)action_applicationDidEnterBackground;

/**
 程序将要进入前台
 */
- (void)action_applicationWillEnterForeground;

/**
 程序已经被激活
 */
- (void)action_applicationDidBecomeActive;

/**
 程序将要被终止
 */
- (void)action_applicationWillTerminate;

/**
 3D-Touch
 
 @param shortcutItem touch对象
 @param completionHandler 完成block
 */
- (void)action_applicationPerformActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler;

/**
 app间调转
 */
- (BOOL)action_applicationOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80400
- (BOOL)action_applicationOpenURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options;
#endif

/**
 收到远程推送
 
 @param userInfo 推送信息
 */
- (void)action_applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo;

- (void)action_applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

/**
 收到本地推送
 
 @param notification 本地通知
 */
- (void)action_applicationDidReceiveLocalNotification:(UILocalNotification *)notification;

/**
 iOS10+ PresentNotification
 
 */
- (void)action_userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler;

/**
 iOS10+ DidReceiveNotificationResponse
 */
- (void)action_userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler;

/**
 DidUpdateUserActivity
 
 @param userActivity 模块事件item
 */
- (void)action_applicationDidUpdateUserActivity:(NSUserActivity *)userActivity;

/**
 DidFailToContinueUserActivity
 */
- (void)action_applicationDidFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error;

/**
 ContinueUserActivity
 */
- (BOOL)action_applicationContinueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * ))restorationHandler;

/**
 WillContinueUserActivity
 
 @param userActivityType 模块事件item
 */
- (BOOL)action_applicationWillContinueUserActivityWithType:(NSString *)userActivityType;

/**
 将要收到内存警告
 */
- (void)action_applicationDidReceiveMemoryWarning;


@end
