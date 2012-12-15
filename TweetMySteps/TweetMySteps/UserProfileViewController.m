//
//  UserProfileViewController.m
//  TweetMySteps
//
//  Created by Prasad Pamidi on 12/2/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "UserProfileViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "UserProfileLifeTimeTableViewCell.h"
#import "DetailedViewController.h"
#import "NoDisplayTableViewCell.h"
#import "DetailVsViewController.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

@synthesize username;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        
        self.title=@"Profile";
        
    
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{

    dispatch_queue_t downloadQueue=dispatch_queue_create("Download Queue",NULL);
    
    
    dispatch_async(downloadQueue, ^{
        
        
    });
    
    
    [self getValues];
    
    [self setValues];
    
    
    [self.tableView reloadData];
        
   

    
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    _profileView.hidden=YES;
    
    _statsView.hidden=YES;
    
    
    [_profileView.layer setCornerRadius:5.0f];
    [_profileView.layer setBorderColor:[UIColor lightTextColor].CGColor];
    [_profileView.layer setBorderWidth:1.0f];
    [_profileView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [_profileView.layer setShadowOpacity:0.8];
    [_profileView.layer setShadowRadius:1.0];
    [_profileView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    
    [_statsView.layer setCornerRadius:5.0f];
    [_statsView.layer setBorderColor:[UIColor lightTextColor].CGColor];
    [_statsView.layer setBorderWidth:1.0f];
    [_statsView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [_statsView.layer setShadowOpacity:0.8];
    [_statsView.layer setShadowRadius:1.0];
    
    [_statsView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    
}
-(void) getValues{
    
    
    NSError *error;
    
    NSString *profileURLString=[@"http://m.tweetmysteps.com/profileInfoServiceJSON.php?userName=" stringByAppendingString:username];
    
    NSString *profileURLEncoded = [profileURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *profileURL=[NSURL URLWithString:profileURLEncoded];
    
    NSData *profileData=[NSData dataWithContentsOfURL:profileURL];
    
    
    profileDataArray=[NSJSONSerialization JSONObjectWithData:profileData options:kNilOptions error:&error];
    
    

    
    NSString *lifetimeTweetsURLString=[@"http://m.tweetmysteps.com/profileUpdateServiceJSON.php?username=" stringByAppendingString:username];
    
    NSString *lifetimeTweetsURLEncoded = [lifetimeTweetsURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *lifetimeTweetsURL=[NSURL URLWithString:lifetimeTweetsURLEncoded];
    
    NSData *lifetimeTweetData=[NSData dataWithContentsOfURL:lifetimeTweetsURL];
    
    
    lifetimeTweetsArray=[NSJSONSerialization JSONObjectWithData:lifetimeTweetData options:kNilOptions error:&error];
    
    
    NSString *vsTweetsURLString=[@"http://m.tweetmysteps.com/profileUpdateServiceVSJSON.php?username=" stringByAppendingString:username];
    
    
    NSString *vsTweetsURLEncoded = [vsTweetsURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *vsTweetsURL=[NSURL URLWithString:vsTweetsURLEncoded];
    
    NSData *vsTweetData=[NSData dataWithContentsOfURL:vsTweetsURL];
    
    vsTweetsArray=[NSJSONSerialization JSONObjectWithData:vsTweetData options:kNilOptions error:&error];
    
    noTweetMSG=@"No sweet versus action yet. Stay tuned...";
    
      
    
}


-(void) setValues{
    
 
    _profileView.hidden=NO;
    
    _statsView.hidden=NO;
    

    NSMutableDictionary *userDataDictionary=[profileDataArray lastObject];
    
    _nameLabel.text=[userDataDictionary objectForKey:@"name"];
    
    _twitterHandle.text=[@"@" stringByAppendingString :username ];
    

    _location.text=[userDataDictionary objectForKey:@"location"];
    
    _descTextView.text=[userDataDictionary objectForKey:@"desc"];
    
    data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[userDataDictionary objectForKey:@"imageURL"]]];
    
    imagePic=[[UIImage alloc] initWithData:data];
    
    _profileImage.image=[[UIImage alloc] initWithData:data];
    
    
     [_profileImage.layer setMasksToBounds:YES];
    
    [_profileImage.layer setCornerRadius:7.0f];
    

    
    _memberSinceDate.text=[userDataDictionary objectForKey:@"memberDate"];
    _avgStepsLabel.text=[[userDataDictionary objectForKey:@"avgStep"] stringByAppendingString:@" steps"];
    
    _bestStepsDayLabel.text=[userDataDictionary objectForKey:@"maxStepDay"];
    
    _tenKDaysLabel.text=[userDataDictionary objectForKey:@"tenKDays"];
    
    _tenKStreakLabel.text=[NSString stringWithFormat:@"%@",[userDataDictionary objectForKey:@"tenKStreaks"]];
    
    _todayStepCountLabel.text=[[[[userDataDictionary objectForKey:@"todaySteps"] stringByAppendingString:@" steps ("] stringByAppendingString:[userDataDictionary objectForKey:@"todayMiles"]] stringByAppendingString:@" miles)"];
    
    _lifetimeStepCountLabel.text=[[[[userDataDictionary objectForKey:@"lifetimeSteps"] stringByAppendingString:@" steps ("] stringByAppendingString:[userDataDictionary objectForKey:@"lifetimeMiles"]] stringByAppendingString:@" miles)"];
    
    _vsBattlesLabel.text=[userDataDictionary objectForKey:@"vsBattles"];
    
    _vsWinsLabel.text=[userDataDictionary objectForKey:@"vsWins"];
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        if ([vsTweetsArray count]>0) {
 
            return [vsTweetsArray count];
            
        }else
            return 1;
        
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

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 450)]; // x,y,width,height
    
    [_profileView setFrame:CGRectMake(10.0, 20.0, 300, 153)];
    
    [_statsView setFrame:CGRectMake(10.0, 215.0, 300, 200)];
    
    
    [_segmentControl setFrame:CGRectMake(20.0, 425, 280.0, 30.0)];
    
    
    [headerView addSubview:_profileView];
    
    
    [headerView addSubview:_statsView];
    
    
    [headerView addSubview:_segmentControl];
    
    return headerView;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 470.0f;
    
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    if (_segmentControl.selectedSegmentIndex==0) {
        
        NSMutableDictionary *tweetData=[lifetimeTweetsArray objectAtIndex:indexPath.row];
        
        
        if ([tweetData objectForKey:@"SUBTWEETS"]!=[NSNull null]) {
            
            
            DetailedViewController *detailVC=[[DetailedViewController alloc] initWithNibName:@"DetailedViewController" bundle:[NSBundle mainBundle]];
            
            detailVC.subTweetsArray=[tweetData objectForKey:@"SUBTWEETS"];
            
            NSMutableDictionary *tweet=[lifetimeTweetsArray objectAtIndex:indexPath.row];
            
            detailVC.time=[tweet objectForKey:@"TIME"];
            
            detailVC.totalSteps=[tweet objectForKey:@"STEPS"];
            
            [self.navigationController pushViewController:detailVC animated:YES];
        
    }

        
        
    }else{
        
        
        NSMutableDictionary *tweetData=[lifetimeTweetsArray objectAtIndex:indexPath.row];
        
        
        if ([tweetData objectForKey:@"SUBTWEETS"]!=[NSNull null]) {
            
            
            DetailVsViewController *detailVC=[[DetailVsViewController alloc] initWithNibName:@"DetailVsViewController" bundle:[NSBundle mainBundle]];
            
            detailVC.subTweetsArray=[tweetData objectForKey:@"SUBTWEETS"];
            
            NSMutableDictionary *tweet=[lifetimeTweetsArray objectAtIndex:indexPath.row];
            
            detailVC.time=[tweet objectForKey:@"TIME"];
            
            detailVC.totalSteps=[tweet objectForKey:@"STEPS"];
            
            [self.navigationController pushViewController:detailVC animated:YES];
            
            
        }else{
            
            
            UserProfileViewController *userProfileVC=[[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:[NSBundle mainBundle]];
            
            userProfileVC.username=[tweetData objectForKey:@"HNDL"];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [self.navigationController pushViewController:userProfileVC animated:YES];
                
            });

            
            
            
        }

        
    }

    
}

- (IBAction)segmentChanged:(id)sender {
    
    
    [self.tableView reloadData];

}
@end
