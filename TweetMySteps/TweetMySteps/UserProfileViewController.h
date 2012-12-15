//
//  UserProfileViewController.h
//  TweetMySteps
//
//  Created by Prasad Pamidi on 12/2/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>
@class AppDelegate;

@interface UserProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>{
    
   
    NSData *data;
    
    NSArray *lifetimeTweetsArray;
    
    NSArray *vsTweetsArray;
    
    AppDelegate *delegate;
    
    NSMutableDictionary *userDataArray;
    
    NSString *noTweetMSG;

    NSArray *profileDataArray;
    
    UIImage *imagePic;
    
    
}
@property (strong, nonatomic) IBOutlet UILabel *memberSinceDate;

@property (strong, nonatomic) NSString *username;

@property (strong, nonatomic) IBOutlet UIView *statsView;

@property (strong, nonatomic) IBOutlet UILabel *avgStepsLabel;

@property (strong, nonatomic) IBOutlet UILabel *bestStepsDayLabel;


@property (strong, nonatomic) IBOutlet UILabel *tenKDaysLabel;


@property (strong, nonatomic) IBOutlet UILabel *tenKStreakLabel;


@property (strong, nonatomic) IBOutlet UILabel *vsBattlesLabel;


@property (strong, nonatomic) IBOutlet UILabel *vsWinsLabel;



@property (strong, nonatomic) IBOutlet UILabel *todayStepCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *lifetimeStepCountLabel;


@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;


- (IBAction)segmentChanged:(id)sender;



@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) IBOutlet UIView *profileView;


@property (strong, nonatomic) IBOutlet UIImageView *profileImage;


@property (strong, nonatomic) IBOutlet UILabel *nameLabel;


@property (strong, nonatomic) IBOutlet UILabel *twitterHandle;


@property (strong, nonatomic) IBOutlet UILabel *location;


@property (strong, nonatomic) IBOutlet UITextView *descTextView;


@end
