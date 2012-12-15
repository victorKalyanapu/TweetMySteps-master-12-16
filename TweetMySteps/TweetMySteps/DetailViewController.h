//
//  DetailViewController.h
//  TweetMySteps
//
//  Created by Prasad Pamidi on 12/3/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController{
    
    NSMutableArray *subTweetsArray;
    NSData *imageData;
    NSString *userName;
    
}

@property (strong, nonatomic) NSMutableArray *subTweetsArray;

@end
