//
//  TweetViewController.h
//  TweetMySteps
//
//  Created by Prasad Pamidi on 11/20/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TweetViewController : UIViewController<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray *subTweets;
    
    NSData *data;
    
    NSString *username;
    
    NSArray *profileDataArray;
    
}


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *tweetView;

@property (strong, nonatomic) NSMutableArray *subTweets;

@property (strong, nonatomic) NSMutableDictionary *tweet;

@property (strong, nonatomic) IBOutlet UIImageView *profileImage;

@property (strong, nonatomic) IBOutlet UILabel *stepCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;


@property (strong, nonatomic) IBOutlet UILabel *twitterHandleLabel;


@property (strong, nonatomic) IBOutlet UITextView *tweetTextView;

@end
