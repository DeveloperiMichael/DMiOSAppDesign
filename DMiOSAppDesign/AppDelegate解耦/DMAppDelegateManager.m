//
//  DMAppDelegateManager.m
//  DMAnimation
//
//  Created by 张炯 on 2017/8/30.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "DMAppDelegateManager.h"


@interface DMAppDelegateManager ()

@property (nonatomic, strong) NSMutableArray <Class>*moduleList;

@end

@implementation DMAppDelegateManager

+ (instancetype)sharedInstance {
    static DMAppDelegateManager *handler = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        handler = [DMAppDelegateManager new];
    });
    return handler;
}

#pragma mark-
#pragma mark- Public Methods

- (void)registerModule:(Class)modlue {
    if (modlue == nil) return;
    
    if ([modlue conformsToProtocol:@protocol(DMApplicationDelegate)]) {
        [self.moduleList addObject:modlue];
    }
}

- (void)action_applicationDidFinishLaunchingWithOptions:(NSDictionary *)options {
    [self.moduleList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(dm_applicationDidFinishLaunchingWithOptions:)]) {
            [obj dm_applicationDidFinishLaunchingWithOptions:options];
        }
    }];
}

- (void)action_applicationWillResignActive {
    [self handleModuleNoParamEvent:@selector(dm_applicationWillResignActive)];
}

- (void)action_applicationDidEnterBackground {
    [self handleModuleNoParamEvent:@selector(dm_applicationDidEnterBackground)];
}

- (void)action_applicationWillEnterForeground {
    [self handleModuleNoParamEvent:@selector(dm_applicationWillEnterForeground)];
}

- (void)action_applicationDidBecomeActive {
    [self handleModuleNoParamEvent:@selector(dm_applicationDidBecomeActive)];
}

- (void)action_applicationWillTerminate {
    [self handleModuleNoParamEvent:@selector(dm_applicationWillTerminate)];
}

- (void)action_applicationPerformActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    [self.moduleList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(dm_applicationPerformActionForShortcutItem:completionHandler:)]) {
            [obj dm_applicationPerformActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }];
}

- (BOOL)action_applicationOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    __block BOOL flag = NO;
    [self.moduleList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(dm_applicationOpenURL:sourceApplication:annotation:)]) {
            flag = [obj dm_applicationOpenURL:url sourceApplication:sourceApplication annotation:annotation];
        }
    }];
    return flag;
}

- (BOOL)action_applicationOpenURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    __block BOOL flag = NO;
    [self.moduleList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(dm_applicationOpenURL:options:)]) {
            flag = [obj dm_applicationOpenURL:url options:options];
        }
    }];
    return flag;
}

- (void)action_applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self.moduleList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(dm_applicationDidReceiveRemoteNotification:)]) {
            [obj dm_applicationDidReceiveRemoteNotification:userInfo];
        }
    }];
}

- (void)action_applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [self.moduleList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(dm_applicationDidReceiveRemoteNotification:fetchCompletionHandler:)]) {
            [obj dm_applicationDidReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }];
}

- (void)action_applicationDidReceiveLocalNotification:(UILocalNotification *)notification {
    [self.moduleList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(dm_applicationDidReceiveLocalNotification:)]) {
            [obj dm_applicationDidReceiveLocalNotification:notification];
        }
    }];
}

/**
 iOS10+ PresentNotification
 
 */
- (void)action_userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    [self.moduleList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(dm_userNotificationCenter:willPresentNotification:withCompletionHandler:)]) {
            [obj dm_userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
        }
    }];
}

- (void)action_userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    [self.moduleList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(dm_userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)]) {
            [obj dm_userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
        }
    }];
}

- (void)action_applicationDidUpdateUserActivity:(NSUserActivity *)userActivity {
    [self.moduleList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(dm_applicationDidUpdateUserActivity:)]) {
            [obj dm_applicationDidUpdateUserActivity:userActivity];
        }
    }];
}

- (void)action_applicationDidFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    [self.moduleList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(dm_applicationDidFailToContinueUserActivityWithType:error:)]) {
            [obj dm_applicationDidFailToContinueUserActivityWithType:userActivityType error:error];
        }
    }];
}

- (BOOL)action_applicationContinueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * ))restorationHandler {
    __block BOOL flag = NO;
    [self.moduleList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(dm_applicationContinueUserActivity:restorationHandler:)]) {
            flag = [obj dm_applicationContinueUserActivity:userActivity restorationHandler:restorationHandler];
        }
    }];
    return flag;
}

- (BOOL)action_applicationWillContinueUserActivityWithType:(NSString *)userActivityType {
    __block BOOL flag = NO;
    [self.moduleList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(dm_applicationWillContinueUserActivityWithType:)]) {
            flag = [obj dm_applicationWillContinueUserActivityWithType:userActivityType];
        }
    }];
    return flag;
}

- (void)action_applicationDidReceiveMemoryWarning {
    [self handleModuleNoParamEvent:@selector(dm_applicationDidReceiveMemoryWarning)];
}


#pragma mark-
#pragma mark- Private Methods

- (void)handleModuleNoParamEvent:(SEL)selector{
    [self.moduleList enumerateObjectsUsingBlock:^(Class moduleClass, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([moduleClass respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [moduleClass performSelector:selector];
#pragma clang diagnostic pop
        }
    }];
}

#pragma mark-
#pragma mark-   setters and getters
- (NSMutableArray *)moduleList {
    if (!_moduleList) {
        _moduleList = [NSMutableArray array];
    }
    return _moduleList;
}


@end
