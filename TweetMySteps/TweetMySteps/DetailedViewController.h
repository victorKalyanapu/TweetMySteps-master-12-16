//
//  DetailedViewController.h
//  TweetMySteps
//
//  Created by Tittu on 12/6/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    
    NSMutableArray *subTweetsArray;
    
    NSData *imageData;
    
    NSString *userName;
    
    NSString *time;
  
    NSString *totalSteps;
    
    
}


@property (strong, nonatomic) NSMutableArray *subTweetsArray;

@property (strong, nonatomic) IBOutlet UIView *summaryView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSString *time;

@property (strong, nonatomic) NSString *totalSteps;

@property (strong, nonatomic) IBOutlet UILabel *totalStepsLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;


@end
