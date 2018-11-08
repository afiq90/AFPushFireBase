//
//  AppDelegate.m
//  PushNotiFireBase
//
//  Created by Afiq Hamdan on 11/8/18.
//  Copyright © 2018 Afiq Hamdan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@import Firebase;
@import UserNotifications;

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [FIRApp configure];
    
    [FIRMessaging messaging].delegate = self;

    // Register for remote notifications. This shows a permission dialog on first run, to
    // show the dialog at a more appropriate time move this registration accordingly.
    // [START register_for_notifications]
    if ([UNUserNotificationCenter class] != nil) {
        // iOS 10 or later
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
        UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:authOptions
         completionHandler:^(BOOL granted, NSError * _Nullable error) {
             // ...
         }];
    } else {
        // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    [application registerForRemoteNotifications];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

// [START ios_10_message_handling]
// Receive displayed notifications for iOS 10 devices.
// Handle incoming notification messages while app is in the foreground.
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center
//       willPresentNotification:(UNNotification *)notification
//         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
//    NSDictionary *userInfo = notification.request.content.userInfo;
//
//    // With swizzling disabled you must let Messaging know about the message, for Analytics
//    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
//
//    // Print message ID.
//    if (userInfo[@"gcm.message_id"]) {
//        NSLog(@"Message ID: %@", userInfo[@"gcm.message_id"]);
//    }
//
//    // Print full message.
//    NSLog(@"%@", userInfo);
//
//    // Change this to your preferred presentation option
////    completionHandler(UNNotificationPresentationOptionNone);
////    completionHandler(UNNotificationPresentationOptionAlert);
//
//}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Device Token: %@", deviceToken);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"user info : %@", userInfo);

    // use nsnotification center to post the userInfo alert value and use in viewcontroller notificationText variables
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"notiText" object:nil userInfo:userInfo];
    [self showNotiPopup: userInfo];

}

// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse*)response withCompletionHandler:(void(^)(void))completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
   
    
    //save the aps alert to NSUserDefault
//    NSUserDefaults *notiString = [NSUserDefaults standardUserDefaults];
//    [notiString setObject:userInfo[@"aps"][@"alert"] forKey:@"notiString"];
//    [notiString synchronize];
    
    if (userInfo[@"gcm.message_id"]) {
        NSLog(@"Message ID: %@", userInfo[@"gcm.message_id"]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler();
}

// [START refresh_token]
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {

    NSLog(@"FCM registration token: %@", fcmToken);
    // Notify about received token.
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"FCMToken" object:nil userInfo:dataDict];
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
}
// [END refresh_token]


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)showNotiPopup:(NSDictionary*)userInfo {
    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
    ViewController *vc = (ViewController*) self.window.rootViewController;
    //    vc.notificationText = userInfo[@"aps"][@"alert"];
    
    // Show an push notification alert
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Push Noti" message:userInfo[@"aps"][@"alert"] preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
    }];
    
    [alertController addAction:okAction];
    [vc presentViewController:alertController animated:YES completion:nil];
}
@end
