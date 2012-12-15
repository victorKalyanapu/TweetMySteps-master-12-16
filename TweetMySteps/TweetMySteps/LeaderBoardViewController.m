//
//  LeaderBoardViewController.m
//  TweetMySteps
//
//  Created by Prasad Pamidi on 11/21/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "LeaderBoardViewController.h"
#import "LeaderBoardTableViewCell.h"
#import "NoDisplayTableViewCell.h"
#import "TweetViewController.h"
#import "UserProfileViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LeaderBoardViewController ()

@end

@implementation LeaderBoardViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
       
       
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title=@"Leaderboard";
        
        self.tabBarItem.image=[UIImage imageNamed:@"home.png"];
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    refreshControl = [[UIRefreshControl alloc]
                                        init];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Pull to Refresh"];
    
    refreshControl.tintColor = [UIColor lightGrayColor];
    
    [refreshControl addTarget:self action:@selector(refreshList) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refreshControl;
 
    dispatch_queue_t downloadQueue=dispatch_queue_create("Download Queue",NULL);
    
    dispatch_async(downloadQueue, ^{
        
        [self loadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
        

    });
    
  }


-(void) viewWillAppear:(BOOL)animated{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        
    });

    
    
}

-(void) loadData{
    
    
    NSString *lifetimeURLString=@"http://m.tweetmysteps.com/updateServiceJSON.php?time=lifetime";
    
    NSString *lifetimeURLEncoded = [lifetimeURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *tmsLifeTimeURL=[NSURL URLWithString:lifetimeURLEncoded];
    
    NSData *lifetimeData=[NSData dataWithContentsOfURL:tmsLifeTimeURL];
    
    NSError *error;
    
    lifetimeTweetsArray=[NSJSONSerialization JSONObjectWithData:lifetimeData options:kNilOptions error:&error];

    NSString *weekURLString=@"http://m.tweetmysteps.com/updateServiceJSON.php?time=week";
    
    NSString *weekURLEncoded = [weekURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *tmsWeekURL=[NSURL URLWithString:weekURLEncoded];
    
    NSData *weekData=[NSData dataWithContentsOfURL:tmsWeekURL];
    

    weekTweetsArray=[NSJSONSerialization JSONObjectWithData:weekData options:kNilOptions error:&error];
    
    NSString *todayURLString=@"http://m.tweetmysteps.com/updateServiceJSON.php?time=today";
    
    NSString *todayURLEncoded = [todayURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *tmsTodayURL=[NSURL URLWithString:todayURLEncoded];
    
    NSData *todayData=[NSData dataWithContentsOfURL:tmsTodayURL];
    
    
    todayTweetsArray=[NSJSONSerialization JSONObjectWithData:todayData options:kNilOptions error:&error];
    

    NSString *noTweetString=@"http://m.tweetmysteps.com/displayNoTweetJSON.php";
    
    NSString *noTweetURLEncoded = [noTweetString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *tmsNoTweetURL=[NSURL URLWithString:noTweetURLEncoded];
    
    NSData *noTweetMSGData=[NSData dataWithContentsOfURL:tmsNoTweetURL];
    
    
    NSArray *json=[NSJSONSerialization JSONObjectWithData:noTweetMSGData options:kNilOptions error:&error];
    
    NSDictionary *message=[json lastObject];

    noTweetMSG=[message objectForKey:@"MSG"];
    

}

-(void) refreshList{
    
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing the TableView"];
  
    NSDateFormatter *formattedDate = [[NSDateFormatter alloc]init];
    
    [formattedDate setDateFormat:@"MMM d, h:mm a"];
    
    NSString *lastupdated = [NSString stringWithFormat:@"Last Updated on %@",[formattedDate stringFromDate:[NSDate date]]];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:lastupdated];
    
    dispatch_queue_t downloadQueue=dispatch_queue_create("Download Queue",NULL);
    
    dispatch_async(downloadQueue, ^{
        
        [self loadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
        
    });
    
 
    [refreshControl endRefreshing];
    
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
        
        if ([todayTweetsArray count]==0) {
            return 1;
        } else {
            return [todayTweetsArray count];
        }
    
        
    } else if(_segmentControl.selectedSegmentIndex==1){
        if ([weekTweetsArray count]==0) {
            return 1;
        } else {
        return [weekTweetsArray count];
        }
        
        
    }else {
        
        if ([lifetimeTweetsArray count]==0) {
            return 1;
        } else {
            return [lifetimeTweetsArray count];
        }
       
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    NSArray *dataArray=nil;
   
    
    if (_segmentControl.selectedSegmentIndex==0) {
        
         dataArray=todayTweetsArray;
   
        
        if ([dataArray count]==0) {

            static NSString *CellIdentifier = @"Cell11";
            
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
                static NSString *CellIdentifier = @"Cell12";
                

                LeaderBoardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                
                if (cell == nil) {
                    
                    NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"LeaderBoardTableViewCell" owner:nil options:nil];
                    for (id obj in views) {
                        
                        if ([obj isKindOfClass:[UITableViewCell class]]) {
                            cell=(LeaderBoardTableViewCell*) obj;
                        }
                        
                    }
                    
                }
                
                NSMutableDictionary *tweet=(NSMutableDictionary *)dataArray[indexPath.row];
                
                
                cell.image.image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[tweet objectForKey:@"IMG"]]]];
                
                [cell.image.layer setMasksToBounds:YES];
                
                [cell.image.layer setCornerRadius:7.0f];
                //[cell.image.layer setBorderColor: [[UIColor blackColor] CGColor]];
                //[cell.image.layer setBorderWidth: 1.0];

                
                cell.comment.text=[tweet objectForKey:@"COMMENT"];
                
                cell.stepCount.text=[tweet objectForKey:@"STEPS"];
                
                cell.twitterHandle.text=[@"@" stringByAppendingString:[tweet objectForKey:@"HNDL"]] ;
                
                return cell;

                
    }
        
    } else if(_segmentControl.selectedSegmentIndex==1){
        
        dataArray=weekTweetsArray;
        
        
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
            
            static NSString *CellIdentifier = @"Cell22";
            
            LeaderBoardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                

                NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"LeaderBoardTableViewCell" owner:nil options:nil];
                for (id obj in views) {
                    
                    if ([obj isKindOfClass:[UITableViewCell class]]) {
                        cell=(LeaderBoardTableViewCell*) obj;
                    }
                    
                }
                
            }
            
            NSMutableDictionary *tweet=(NSMutableDictionary *)dataArray[indexPath.row];
            
            
            cell.image.image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[tweet objectForKey:@"IMG"]]]];
            
            [cell.image.layer setMasksToBounds:YES];
            
            [cell.image.layer setCornerRadius:7.0f];
            
            cell.comment.text=[tweet objectForKey:@"COMMENT"];
            
            cell.stepCount.text=[tweet objectForKey:@"STEPS"];
            
            cell.twitterHandle.text=[@"@" stringByAppendingString:[tweet objectForKey:@"HNDL"]] ;
           
            return cell;
            
            
        }
        
    }else{
        
        dataArray=lifetimeTweetsArray;
      
        
        if ([dataArray count]==0) {
            

            
            static NSString *CellIdentifier = @"Cell31";
            
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
            
            static NSString *CellIdentifier = @"Cell32";
            
            LeaderBoardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                
                NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"LeaderBoardTableViewCell" owner:nil options:nil];
                for (id obj in views) {
                    
                    if ([obj isKindOfClass:[UITableViewCell class]]) {
                        cell=(LeaderBoardTableViewCell*) obj;
                    }
                    
                }
                
            }
            
            NSMutableDictionary *tweet=(NSMutableDictionary *)dataArray[indexPath.row];            

            cell.image.image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[tweet objectForKey:@"IMG"]]]];

            [cell.image.layer setMasksToBounds:YES];
            
            [cell.image.layer setCornerRadius:7.0f];
            
            
            cell.comment.text=[tweet objectForKey:@"COMMENT"];
            
            cell.stepCount.text=[tweet objectForKey:@"STEPS"];
            
            cell.twitterHandle.text=[@"@" stringByAppendingString:[tweet objectForKey:@"HNDL"]] ;            
            return cell;
            
            
        }
        
        
    }

  

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (_segmentControl.selectedSegmentIndex==0) {
        
        if ([todayTweetsArray count]==0) {
            return 100.0f;
        } else {
            return 90.0f;
        }
        
        
    } else if(_segmentControl.selectedSegmentIndex==1){
        if ([weekTweetsArray count]==0) {
            return 100.0f;
        } else {
            return 90.0f;
        }
        
    }else {
        
        if ([lifetimeTweetsArray count]==0) {
            return 100.0f;
        } else {
            return 90.0f;
        }
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    
    if (_segmentControl.selectedSegmentIndex==0) {
        
        if ([todayTweetsArray count]>0) {
            
            NSMutableDictionary *tweet=(NSMutableDictionary *)todayTweetsArray[indexPath.row];
         
            
            UserProfileViewController *userProfileVC=[[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:[NSBundle mainBundle]];
            
            userProfileVC.username=[tweet objectForKey:@"HNDL"];

            
          dispatch_async(dispatch_get_main_queue(), ^{
                
              
              [self.navigationController pushViewController:userProfileVC animated:YES];
       
            });
            
        }
        
        
    } else if(_segmentControl.selectedSegmentIndex==1){
        if ([weekTweetsArray count]>0) {
            
            
            
            NSMutableDictionary *tweet=(NSMutableDictionary *)weekTweetsArray[indexPath.row];
            
            UserProfileViewController *userProfileVC=[[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:[NSBundle mainBundle]];
            
            userProfileVC.username=[tweet objectForKey:@"HNDL"];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [self.navigationController pushViewController:userProfileVC animated:YES];
                
            });
            
            
        }
        
    }else {
        
        if ([lifetimeTweetsArray count]>0) {
            
            
            NSMutableDictionary *tweet=(NSMutableDictionary *)lifetimeTweetsArray[indexPath.row];
        
            UserProfileViewController *userProfileVC=[[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:[NSBundle mainBundle]];
            
            userProfileVC.username=[tweet objectForKey:@"HNDL"];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [self.navigationController pushViewController:userProfileVC animated:YES];
                
            });

       }
    }
    
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 35)];
    
    [_segmentControl setFrame:CGRectMake(20.0, 5, 280.0, 30.0)];
    
    [headerView addSubview:_segmentControl];
    
    return headerView;
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
    
}
- (IBAction)segmentChanged:(id)sender {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        
    });

}
@end
