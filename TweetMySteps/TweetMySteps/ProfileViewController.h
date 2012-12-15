//
//  ProfileViewController.h
//  TweetMySteps
//
//  Created by Prasad Pamidi on 11/20/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>
@class AppDelegate;

@interface ProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>{
                           
    NSArray *lifetimeTweetsArray;
    
    NSArray *vsTweetsArray;

    AppDelegate *delegate;
    
    NSMutableDictionary *userDataArray;
    
    NSString *noTweetMSG;
    
    NSData *data;
    
    NSArray *profileDataArray;
    
    UIImage *imagePic;

    
}

@property (strong, nonatomic) IBOutlet UILabel *tenKStreakLabel;

@property (strong, nonatomic) IBOutlet UILabel *vsBattlesLabel;

@property (strong, nonatomic) IBOutlet UILabel *vsWinsLabel;

@property (strong, nonatomic) IBOutlet UILabel *todayStepCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *lifetimeStepCountLabel;


@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (strong, nonatomic) IBOutlet UILabel *avgStepLabel;


@property (strong, nonatomic) IBOutlet UILabel *bestStepsLabel;


@property (strong, nonatomic) IBOutlet UILabel *tenKDaysLabel;

@property (strong, nonatomic) IBOutlet UIView *profileSubView;


@property (strong, nonatomic) IBOutlet UIView *statsView;

- (IBAction)segmentChanged:(id)sender;

@property (strong, nonatomic)  NSMutableDictionary *userDataArray;

@property (strong, nonatomic) AppDelegate *delegate;

@property (strong, nonatomic) IBOutlet UILabel *locationStringLabel;
@property (strong, nonatomic) IBOutlet UITextView *descTextView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *profileView;

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;

@property (strong, nonatomic) IBOutlet UILabel *profileNameLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UILabel *twitterHandleLabel;

@property (strong, nonatomic) IBOutlet UILabel *tweetCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *followingCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *followersCountLabel;

@end
