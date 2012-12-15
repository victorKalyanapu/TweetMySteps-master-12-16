//
//  UserProfileLifeTimeTableViewCell.h
//  TweetMySteps
//
//  Created by Prasad Pamidi on 12/3/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileLifeTimeTableViewCell : UITableViewCell{
    
}
@property (strong, nonatomic) IBOutlet UITextView *commentTextView;

@property (strong, nonatomic) IBOutlet UILabel *stepCountLabel;


@property (strong, nonatomic) IBOutlet UILabel *timeLabel;


@property (strong, nonatomic) IBOutlet UIImageView *profileTabPic;

@property (strong, nonatomic) IBOutlet UILabel *handleLabel;

@end
