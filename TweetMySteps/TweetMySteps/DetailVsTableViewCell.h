//
//  DetailVsTableViewCell.h
//  TweetMySteps
//
//  Created by Tittu on 12/10/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailVsTableViewCell : UITableViewCell{
    
    
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *handleLable;

@property (strong, nonatomic) IBOutlet UILabel *stepCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UITextView *commentTextView;


@end
