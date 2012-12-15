//
//  AppDelegate.h
//  TweetMySteps
//
//  Created by Prasad Pamidi on 11/16/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@class LeaderBoardViewController;
@class ProfileViewController;
@class AboutViewController;
@class SettingsViewController;
@class TweetViewController;
@class PostTweetViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, ADBannerViewDelegate>{
    

    
    NSMutableDictionary *dataSource;
    
}
@property (strong, nonatomic)     NSMutableDictionary *dataSource;

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (retain, nonatomic) UITabBarController *tabBarController;
@property (retain, nonatomic) UINavigationController *homeNavController;

@property (retain, nonatomic) UINavigationController *profileNavController;

@property (retain, nonatomic) UINavigationController *postTweetNavController;

@property (retain, nonatomic) UINavigationController *aboutNavController;


@property (retain, nonatomic) LeaderBoardViewController *leaderBoardVC;
@property (retain, nonatomic) ProfileViewController *profileVC;
@property (retain, nonatomic) AboutViewController *aboutVC;
@property (retain, nonatomic) SettingsViewController *settingsVC;
@property (retain, nonatomic) TweetViewController *tweetVC;
@property (retain, nonatomic) PostTweetViewController *postTweetVC;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
