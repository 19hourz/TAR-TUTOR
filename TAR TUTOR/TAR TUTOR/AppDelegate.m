//
//  AppDelegate.m
//  TAR TUTOR
//
//  Created by Jiasheng Zhu on 2/25/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()/*<BaiduMobAdSplashDelegate>
@property (nonatomic, strong) BaiduMobAdSplash *splash;
@property (nonatomic, retain) UIView *customSplashView;
*/
@end

@implementation AppDelegate
@synthesize storyboard, defaultAction, uid, name;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    WDGOptions *option = [[WDGOptions alloc] initWithSyncURL:@"https://tar.wilddogio.com"];
    [WDGApp configureWithOptions:option];
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* signout = [defaults objectForKey:@"signOut"];
    if(signout == nil || [signout isEqualToString:@""]){
        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    }
    else if([signout isEqualToString:@"False"]){
        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    }
    [self.window makeKeyAndVisible];
    
//    BaiduMobAdSplash *splash = [[BaiduMobAdSplash alloc] init];
//    splash.delegate = self;
//    splash.AdUnitTag = @"2058492";
//    splash.canSplashClick = YES;
//    [splash loadAndDisplayUsingKeyWindow:self.window];
//    self.splash = splash;
    
    //    自定义开屏
    //
//    BaiduMobAdSplash *splash = [[BaiduMobAdSplash alloc] init];
//    splash.delegate = self;
//    splash.AdUnitTag = @"2831758";
//    splash.canSplashClick = YES;
//    self.splash = splash;
//    
//    //可以在customSplashView上显示包含icon的自定义开屏
//    self.customSplashView = [[UIView alloc]initWithFrame:self.window.frame];
//    self.customSplashView.backgroundColor = [UIColor whiteColor];
//    [self.window addSubview:self.customSplashView];
//    
//    CGFloat screenWidth = self.window.frame.size.width;
//    CGFloat screenHeight = self.window.frame.size.height;
//    
//    //在baiduSplashContainer用做上展现百度广告的容器，注意尺寸必须大于200*200，并且baiduSplashContainer需要全部在window内，同时开机画面不建议旋转
//    UIView * baiduSplashContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 40)];
//    [self.customSplashView addSubview:baiduSplashContainer];
//    
//    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2.0 - screenHeight*0.1, screenHeight*0.8875, screenHeight*0.075, screenHeight*0.075)];
//    icon.image = [UIImage imageNamed:@"icontutor.png"];
//    [self.customSplashView addSubview:icon];
//    UIImageView *blackLine = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2.0 - screenHeight*0.0125, screenHeight*0.8875, screenHeight*0.025, screenHeight*0.075)];
//    blackLine.image = [UIImage imageNamed:@"greyLine.png"];
//    [self.customSplashView addSubview:blackLine];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2.0 + screenHeight*0.025, screenHeight*0.8875, screenWidth/2.0, screenHeight*0.075)];
//    label.text = @"TAR UIBE";
//    [label setTextColor:[UIColor darkGrayColor]];
//    label.textAlignment = NSTextAlignmentLeft;
//    [self.customSplashView addSubview:label];
//    UIButton *skipButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - screenHeight*0.125, screenHeight*0.0875, screenHeight*0.1, screenHeight*0.075)];
//    [skipButton setBackgroundColor:[UIColor whiteColor]];
//    [skipButton setTitle:@"skip" forState:UIControlStateNormal];
//    skipButton.layer.borderColor = [UIColor clearColor].CGColor;
//    skipButton.layer.borderWidth=1.0f;
//    skipButton.layer.cornerRadius = screenWidth*0.4/20.0f;
//    [skipButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [skipButton addTarget:self
//                   action:@selector(removeSplash)
//         forControlEvents:UIControlEventTouchUpInside];
//    [self.customSplashView addSubview:skipButton];
//    
//    //在的baiduSplashContainer里展现百度广告
//    [splash loadAndDisplayUsingContainerView:baiduSplashContainer];
    
    return YES;
}

//- (NSString *)publisherId {
//    return @" f1b096ab";
//}
//
//- (void)splashDidClicked:(BaiduMobAdSplash *)splash {
//    NSLog(@"splashDidClicked");
//}
//
//- (void)splashDidDismissLp:(BaiduMobAdSplash *)splash {
//    NSLog(@"splashDidDismissLp");
//}
//
//- (void)splashDidDismissScreen:(BaiduMobAdSplash *)splash {
//    NSLog(@"splashDidDismissScreen");
//    [self removeSplash];
//}
//
//- (void)splashSuccessPresentScreen:(BaiduMobAdSplash *)splash {
//    NSLog(@"splashSuccessPresentScreen");
//}
//
//- (void)splashlFailPresentScreen:(BaiduMobAdSplash *)splash withError:(BaiduMobFailReason)reason {
//    NSLog(@"splashlFailPresentScreen withError %d", reason);
//    [self removeSplash];
//}
//
///**
// *  展示结束or展示失败后, 手动移除splash和delegate
// */
//- (void) removeSplash {
//    if (self.splash) {
//        self.splash.delegate = nil;
//        self.splash = nil;
//        [self.customSplashView removeFromSuperview];
//    }
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[WDGAuth auth] signOut:nil];
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "z.TAR_TUTOR" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TAR_TUTOR" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TAR_TUTOR.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
