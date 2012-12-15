//
//  MyProfileViewController.h
//  TweetMySteps
//
//  Created by Tittu on 12/3/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>
@class AppDelegate;



@interface MyProfileViewController : UIViewController<UITableViewDataSource, UITableViewDataSource, UIScrollViewDelegate>{
    
    NSArray *lifetimeTweetsArray;
    
    NSArray *vsTweetsArray;
    
    AppDelegate *delegate;
    
    NSMutableDictionary *userDataArray;
    
}

@property (strong, nonatomic)  NSMutableDictionary *userDataArray;

@property (strong, nonatomic) AppDelegate *delegate;



@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *profileView;

@property (strong, nonatomic) IBOutlet UIView *statsView;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)segmentChanged:(id)sender;


@end
