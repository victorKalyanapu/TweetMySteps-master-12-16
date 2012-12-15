//
//  LeaderBoardViewController.h
//  TweetMySteps
//
//  Created by Prasad Pamidi on 11/21/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardViewController : UITableViewController{
    
    UIRefreshControl *refreshControl;
    
    NSArray *todayTweetsArray;
    
    NSArray *weekTweetsArray;
    
    NSArray *lifetimeTweetsArray;
    
    NSString *noTweetMSG;
    
    

}

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

- (IBAction)segmentChanged:(id)sender;

@end
