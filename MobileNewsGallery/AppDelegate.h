//
//  AppDelegate.h
//  MobileNewsGallery
//
//  Created by Tommy Su on 11-11-11.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrontPageViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UITabBarController *tabBarController;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;

@end
