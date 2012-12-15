//
//  TweetViewController.m
//  TweetMySteps
//
//  Created by Prasad Pamidi on 11/20/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "TweetViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "UserProfileViewController.h"

#import "UserProfileLifeTimeTableViewCell.h"

@interface TweetViewController ()

@end

@implementation TweetViewController

@synthesize subTweets;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title=@"Tweet";
    
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    
    _tweetView.hidden=YES;
    
    dispatch_queue_t downloadQueue=dispatch_queue_create("Download Queue",NULL);
    
    
    dispatch_async(downloadQueue, ^{
        
        
        [self getValues];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            
            [self setValues];
            
            if ([_tweet objectForKey:@"SUBTWEETS"]!=[NSNull null]) {
                
                
                subTweets=[_tweet objectForKey:@"SUBTWEETS"];
                
                [self.tableView reloadData];
                
                
            }
            
            
        });
        
        
    });

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
    [_tweetView.layer setCornerRadius:5.0f];
    [_tweetView.layer setBorderColor:[UIColor lightTextColor].CGColor];
    [_tweetView.layer setBorderWidth:1.0f];
    [_tweetView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [_tweetView.layer setShadowOpacity:0.8];
    [_tweetView.layer setShadowRadius:1.0];
    
    [_tweetView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    tapRecognizer.numberOfTapsRequired = 2;
    
    [_tweetView addGestureRecognizer:tapRecognizer];
    
    
    
  
}


-(void) viewWillAppear:(BOOL)animated{
    
    
    username=[_tweet objectForKey:@"HNDL"];
    
    if ([_tweet objectForKey:@"SUBTWEETS"]!=[NSNull null]) {
        
        
        subTweets=[_tweet objectForKey:@"SUBTWEETS"];
        
        [self.tableView reloadData];
        
        
    }

    
}

-(void) getValues{
    
    
    NSError *error;
    
    NSString *profileURLString=[@"http://m.tweetmysteps.com/profileInfoServiceJSON.php?userName=" stringByAppendingString:username];
    
    NSString *profileURLEncoded = [profileURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *profileURL=[NSURL URLWithString:profileURLEncoded];
    
    NSData *profileData=[NSData dataWithContentsOfURL:profileURL];
    
    
    profileDataArray=[NSJSONSerialization JSONObjectWithData:profileData options:kNilOptions error:&error];

}

-(void) setValues{
    
    _tweetView.hidden=NO;
    
    _twitterHandleLabel.text=[@"@" stringByAppendingString:[_tweet objectForKey:@"HNDL"]] ;
    
    data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[_tweet objectForKey:@"IMG"]] ];
    
    _profileImage.image=[[UIImage alloc] initWithData:data];
    
    _stepCountLabel.text=[_tweet objectForKey:@"STEPS"];
    
    _tweetTextView.text=[_tweet objectForKey:@"COMMENT"];
    
    
    NSMutableDictionary *userDataDictionary=[profileDataArray lastObject];
    
    
    _nameLabel.text=[userDataDictionary objectForKey:@"name"];

    _locationLabel.text=[_tweet objectForKey:@"LOC"];
    
    
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    
    UserProfileViewController *userProfileVC=[[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:[NSBundle mainBundle]];
    
    userProfileVC.username=[_tweet objectForKey:@"HNDL"];
    
    [self.navigationController pushViewController:userProfileVC animated:YES];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return 1;
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([_tweet objectForKey:@"SUBTWEETS"]!=[NSNull null]) {
        
        return [subTweets count];
    
    }else{
        
        return 0;

    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UserProfileLifeTimeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        
        NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"UserProfileLifetimeTableViewCell" owner:nil options:nil];
        
        for (id obj in views) {
            
            if ([obj isKindOfClass:[UITableViewCell class]]) {
                cell=(UserProfileLifeTimeTableViewCell*) obj;
            }
            
        }
        
    }
    
    
    
    NSMutableDictionary *tweet=[subTweets objectAtIndex:indexPath.row];
    
    cell.handleLabel.text=[@"@" stringByAppendingString :[tweet objectForKey:@"HNDL"]];
    
    cell.profileTabPic.image=[UIImage imageWithData:data];
    
    cell.stepCountLabel.text=[NSString stringWithFormat:@"%@",[tweet objectForKey:@"STEPS"]];
    
    cell.commentTextView.text=[tweet objectForKey:@"COMMENT"];
    
    cell.timeLabel.text=[tweet objectForKey:@"TIME"];
    


    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    UserProfileViewController *userProfileVC=[[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:[NSBundle mainBundle]];
    
    userProfileVC.username=[_tweet objectForKey:@"HNDL"];
    
    [self.navigationController pushViewController:userProfileVC animated:YES];
    
    
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 220)]; // x,y,width,height
    
    [_tweetView setFrame:CGRectMake(10.0, 10.0, 300, 210)];
    
    
    [headerView addSubview:_tweetView];
    
    return headerView;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 225.0f;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
