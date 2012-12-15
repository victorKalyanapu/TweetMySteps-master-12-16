//
//  ProfileViewController.m
//  TweetMySteps
//
//  Created by Prasad Pamidi on 11/20/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "UserProfileViewController.h"
#import "UserProfileLifeTimeTableViewCell.h"
#import "DetailViewController.h"
#import "NoDisplayTableViewCell.h"



@interface ProfileViewController ()

@end

@implementation ProfileViewController


@synthesize  delegate, userDataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title=@"Profile";
        
        self.tabBarItem.image=[UIImage imageNamed:@"User.png"];

    
    }
    return self;
}



-(void)viewDidAppear:(BOOL)animated
{
    _scrollView.delegate=self;
    
    [_scrollView setScrollEnabled:YES];
    
    [_scrollView setContentSize:CGSizeMake(320, 1000)];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _profileSubView.hidden=YES;
    
    _statsView.hidden=YES;
    
    _tableView.hidden=YES;
    
    _segmentControl.hidden=YES;
        
    [_profileSubView.layer setCornerRadius:5.0f];
    [_profileSubView.layer setBorderColor:[UIColor lightTextColor].CGColor];
    [_profileSubView.layer setBorderWidth:1.0f];
    [_profileSubView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [_profileSubView.layer setShadowOpacity:0.8];
    [_profileSubView.layer setShadowRadius:1.0];
    [_profileSubView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];    
  
    [_statsView.layer setCornerRadius:5.0f];
    [_statsView.layer setBorderColor:[UIColor lightTextColor].CGColor];
    [_statsView.layer setBorderWidth:1.0f];
    [_statsView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [_statsView.layer setShadowOpacity:0.8];
    [_statsView.layer setShadowRadius:1.0];    
    [_statsView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
   
    self.userDataArray=delegate.dataSource;

    
}

-(void) viewWillAppear:(BOOL)animated{
   
    
    if ([userDataArray count]>0) {
        
    dispatch_queue_t downloadQueue=dispatch_queue_create("Download Queue",NULL);
    
    dispatch_async(downloadQueue, ^{
    
        
        [self getValues];
        
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{        
        
        [self setValues];
        
        [self.tableView reloadData];
        
    });

    }else{
        
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"TMS: Unable to access Twitter Account" message:@"Please configure Twitter account in the Settings App." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"OK",nil];
        
        [alert show];
        
        
        _profileSubView.hidden=YES;
        

    }
    
}

-(void) getValues{
    
    NSError *error;
    
    
    NSString *profileURLString=[@"http://m.tweetmysteps.com/profileInfoServiceJSON.php?userName=" stringByAppendingString:[userDataArray objectForKey:@"screen_name"]];
    
    
    NSString *profileURLEncoded = [profileURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *profileURL=[NSURL URLWithString:profileURLEncoded];
    
    
    NSData *profileData=[NSData dataWithContentsOfURL:profileURL];
    
    
    profileDataArray=[NSJSONSerialization JSONObjectWithData:profileData options:kNilOptions error:&error];
    
    
    NSString *lifetimeTweetsURLString=[@"http://m.tweetmysteps.com/profileUpdateServiceJSON.php?username=" stringByAppendingString:[userDataArray objectForKey:@"screen_name"]];
    
    NSString *lifetimeTweetsURLEncoded = [lifetimeTweetsURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *lifetimeTweetsURL=[NSURL URLWithString:lifetimeTweetsURLEncoded];
    
    NSData *lifetimeTweetData=[NSData dataWithContentsOfURL:lifetimeTweetsURL];
    
    
    lifetimeTweetsArray=[NSJSONSerialization JSONObjectWithData:lifetimeTweetData options:kNilOptions error:&error];
    
    
    
    NSString *vsTweetsURLString=[@"http://m.tweetmysteps.com/profileUpdateServiceVSJSON.php?username=" stringByAppendingString:[userDataArray objectForKey:@"screen_name"]];
    
    
    NSString *vsTweetsURLEncoded = [vsTweetsURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *vsTweetsURL=[NSURL URLWithString:vsTweetsURLEncoded];
    
    NSData *vsTweetData=[NSData dataWithContentsOfURL:vsTweetsURL];
    
    vsTweetsArray=[NSJSONSerialization JSONObjectWithData:vsTweetData options:kNilOptions error:&error];
    
    noTweetMSG=@"No sweet versus action yet. Stay tuned...";
    
    
    
}

-(void) setValues{
    
        
        _profileSubView.hidden=NO;
        
        _profileNameLabel.text=[userDataArray objectForKey:@"name"];
        
        _twitterHandleLabel.text=[@"@" stringByAppendingString :[userDataArray objectForKey:@"screen_name"] ];
        
        _locationStringLabel.text=[userDataArray objectForKey:@"location"];
        
        _descTextView.text=[userDataArray objectForKey:@"description"];
        
        _tweetCountLabel.text=[NSString stringWithFormat:@"%@",[userDataArray objectForKey:@"statuses_count"]];
        
        _followersCountLabel.text=[NSString stringWithFormat:@"%@",[userDataArray objectForKey:@"followers_count"]];
        
        _followingCountLabel.text=[NSString stringWithFormat:@"%@",[userDataArray objectForKey:@"friends_count"]];
        
       
        if ([profileDataArray count]==0) {

            _scrollView.scrollEnabled=NO;
            
            _profileImageView.image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[@"http://api.twitter.com/1/users/profile_image/" stringByAppendingString:[userDataArray objectForKey:@"screen_name"]]]]];
           

            [_profileImageView.layer setMasksToBounds:YES];
            
            [_profileImageView.layer setCornerRadius:7.0f];
            
            
        } else {
            
            data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[@"http://api.twitter.com/1/users/profile_image/" stringByAppendingString:[userDataArray objectForKey:@"screen_name"]]]];
            
            _profileImageView.image=[[UIImage alloc] initWithData:data];
                        
            [_profileImageView.layer setMasksToBounds:YES];
            
            [_profileImageView.layer setCornerRadius:7.0f];
            
            _statsView.hidden=NO;
            
            _tableView.hidden=NO;
            
            _segmentControl.hidden=NO;
            
            NSDictionary *userDataDictionary=[profileDataArray lastObject];
            
            _avgStepLabel.text=[[userDataDictionary objectForKey:@"avgStep"] stringByAppendingString:@"steps"];
            
            _bestStepsLabel.text=[userDataDictionary objectForKey:@"maxStepDay"];
            
            _tenKDaysLabel.text=[userDataDictionary objectForKey:@"tenKDays"];
            
            _tenKStreakLabel.text=[NSString stringWithFormat:@"%@",[userDataDictionary objectForKey:@"tenKStreaks"]];
            
            _todayStepCountLabel.text=[[[[userDataDictionary objectForKey:@"todaySteps"] stringByAppendingString:@" steps ("] stringByAppendingString:[userDataDictionary objectForKey:@"todayMiles"]] stringByAppendingString:@" miles)"];
            
            _lifetimeStepCountLabel.text=[[[[userDataDictionary objectForKey:@"lifetimeSteps"] stringByAppendingString:@" steps ("] stringByAppendingString:[userDataDictionary objectForKey:@"lifetimeMiles"]] stringByAppendingString:@" miles)"];
            
            _vsBattlesLabel.text=[userDataDictionary objectForKey:@"vsBattles"];
            
            _vsWinsLabel.text=[userDataDictionary objectForKey:@"vsWins"];
            
            
        }
    
    imagePic=_profileImageView.image;
    
    
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    
    if (buttonIndex==1) {

        
        NSURL*url=[NSURL URLWithString:@"prefs:root=TWITTER"];
        
        [[UIApplication sharedApplication] openURL:url];
        
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_segmentControl.selectedSegmentIndex==0) {
        
        return [lifetimeTweetsArray count];

        
    }else{
        
        return [vsTweetsArray count];

    }

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    
    NSArray *dataArray=nil;
    
    
    if (_segmentControl.selectedSegmentIndex==0) {
        
        
        UserProfileLifeTimeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {
            
            NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"UserProfileLifetimeTableViewCell" owner:nil options:nil];
            
            for (id obj in views) {
                
                if ([obj isKindOfClass:[UITableViewCell class]]) {
                    cell=(UserProfileLifeTimeTableViewCell*) obj;
                }
                
            }
            
        }
        
        
        dataArray=lifetimeTweetsArray;
        
        NSMutableDictionary *tweet=[dataArray objectAtIndex:indexPath.row];
        
        cell.handleLabel.text=[@"@" stringByAppendingString :[tweet objectForKey:@"HNDL"]];
        
        cell.stepCountLabel.text=[tweet objectForKey:@"STEPS"];
        
        cell.timeLabel.text=[tweet objectForKey:@"TIME"];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            cell.profileTabPic.image=imagePic;
            
            [cell.profileTabPic.layer setMasksToBounds:YES];
            
            [cell.profileTabPic.layer setCornerRadius:7.0f];
            
            cell.commentTextView.text=[tweet objectForKey:@"COMMENT"];
            
            
            
        });
        
        
        if ([tweet objectForKey:@"SUBTWEETS"]!=[NSNull null]) {
            
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
        }
        
        return cell;
        
    }else{
        
        dataArray=vsTweetsArray;
        
        if ([dataArray count]==0) {
            
            static NSString *CellIdentifier = @"Cell21";
            
            
            NoDisplayTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                
                NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"NoDisplayTableViewCell" owner:nil options:nil];
                for (id obj in views) {
                    
                    if ([obj isKindOfClass:[UITableViewCell class]]) {
                        cell=(NoDisplayTableViewCell*) obj;
                    }
                    
                    
                }
                
            }
            
            cell.message.text=noTweetMSG;
            
            return cell;
            
        }else{
            
            UserProfileLifeTimeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell 22"];
            
            
            if (cell == nil) {
                
                NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"UserProfileLifetimeTableViewCell" owner:nil options:nil];
                
                for (id obj in views) {
                    
                    if ([obj isKindOfClass:[UITableViewCell class]]) {
                        cell=(UserProfileLifeTimeTableViewCell*) obj;
                    }
                    
                }
                
            }
            
            
            
            NSMutableDictionary *tweet=[dataArray objectAtIndex:indexPath.row];
            
            cell.handleLabel.text=[@"@" stringByAppendingString :[tweet objectForKey:@"HNDL"]];
            
            cell.stepCountLabel.text=[tweet objectForKey:@"STEPS"];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.profileTabPic.image=imagePic;
                
                [cell.profileTabPic.layer setMasksToBounds:YES];
                
                [cell.profileTabPic.layer setCornerRadius:7.0f];
                
                cell.commentTextView.text=[tweet objectForKey:@"COMMENT"];
                
            });
            
            
            if ([tweet objectForKey:@"SUBTWEETS"]!=[NSNull null]) {
                
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                
            }
            
            return cell;
            
            
        }
        
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_segmentControl.selectedSegmentIndex==0) {
        
        NSMutableDictionary *tweetData=[lifetimeTweetsArray objectAtIndex:indexPath.row];
        
        
        if ([tweetData objectForKey:@"SUBTWEETS"]!=[NSNull null]) {
            
            
            DetailViewController *detailVC=[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
            
            detailVC.subTweetsArray=[tweetData objectForKey:@"SUBTWEETS"];
            
            
            [self.navigationController pushViewController:detailVC animated:YES];
            
            
        }

        
    }else{
        
        NSMutableDictionary *tweetData=[vsTweetsArray objectAtIndex:indexPath.row];
        
        
        if ([tweetData objectForKey:@"SUBTWEETS"]!=[NSNull null]) {
            
            
            DetailViewController *detailVC=[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
            
            detailVC.subTweetsArray=[tweetData objectForKey:@"SUBTWEETS"];
            
            
            [self.navigationController pushViewController:detailVC animated:YES];
            
            
        }else{
            
            UserProfileViewController *userProfileVC=[[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:[NSBundle mainBundle]];
            
            userProfileVC.username=[tweetData objectForKey:@"HNDL"];
            
            [self.navigationController pushViewController:userProfileVC animated:YES];
            
            
        }
        
    }

}
- (IBAction)segmentChanged:(id)sender {
    
    [self.tableView reloadData];
    
}
@end
