//
//  PostTweetViewController.h
//  TweetMySteps
//
//  Created by Prasad Pamidi on 11/21/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
@class AppDelegate;


@interface PostTweetViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource, UITableViewDelegate>{
    
    int charLeft;
    
    IBOutlet UIButton *tweetButton;
    
    UITextView *comment;
    
    UILabel *handle;
    
    AppDelegate *delegate;
    
}


@property (strong, nonatomic) IBOutlet UIProgressView *progressView;

@property (strong, nonatomic) IBOutlet UIButton *tweetButton;

@property (strong, nonatomic) AppDelegate *delegate;

@property (strong, nonatomic) NSString *twitterHandle;

@property (strong, nonatomic) IBOutlet UIButton *postTweet;

- (IBAction)postTweetMsg:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *stepCountLabel;

@property (strong, nonatomic) IBOutlet UITextField *stepsTextField;

@property (strong, nonatomic) IBOutlet UITextView *commentTextView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
