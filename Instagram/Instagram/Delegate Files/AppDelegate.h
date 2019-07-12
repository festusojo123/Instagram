//
//  AppDelegate.h
//  Instagram
//
//  Created by festusojo on 7/8/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//this designates a window for Parse to interact with and allows the changeRootViewControllerWithID function to be seen outside of this file
@property (strong, nonatomic) UIWindow *window;
- (void)changeRootViewControllerWithID:(NSString *)storyboardId; 

@end

