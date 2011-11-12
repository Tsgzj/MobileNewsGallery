//
//  AppDelegate.m
//  MobileNewsGallery
//
//  Created by Tommy Su on 11-11-11.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    tabBarController = [[UITabBarController alloc] init];


    
    FrontPageViewController *frontPageController = [[FrontPageViewController alloc] init];
    UINavigationController *FrontPageNavigationController = [[UINavigationController alloc] initWithRootViewController:frontPageController];
    FrontPageNavigationController.tabBarItem.title = @"首页";
    FrontPageNavigationController.tabBarItem.image = [UIImage imageNamed:@"frontpage.png"];
    
    UIViewController *CategoryViewController = [[UIViewController alloc] init];
    CategoryViewController.tabBarItem.title = @"分类";
    CategoryViewController.tabBarItem.image = [UIImage imageNamed:@"category.png"];
    UIViewController *SearchViewController = [[UIViewController alloc] init];
    SearchViewController.tabBarItem.title = @"搜索";
    SearchViewController.tabBarItem.image = [UIImage imageNamed:@"search.png"];
    UIViewController *MoreViewController = [[UIViewController alloc] init];
    MoreViewController.tabBarItem.title = @"更多";
    MoreViewController.tabBarItem.image = [UIImage imageNamed:@"More.png"];
    
    
    NSArray *controller = [[NSArray alloc] initWithObjects:FrontPageNavigationController, CategoryViewController, SearchViewController, MoreViewController, nil];
    tabBarController.viewControllers = controller;
    [self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
