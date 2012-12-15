//
//  NoDisplayTableViewCell.m
//  TweetMySteps
//
//  Created by Prasad Pamidi on 11/30/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "NoDisplayTableViewCell.h"

@implementation NoDisplayTableViewCell

@synthesize message;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
