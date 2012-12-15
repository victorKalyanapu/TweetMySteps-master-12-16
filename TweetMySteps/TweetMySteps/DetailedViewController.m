//
//  DetailedViewController.m
//  TweetMySteps
//
//  Created by Tittu on 12/6/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "DetailedViewController.h"
#import "DetailTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UserProfileViewController.h"

@interface DetailedViewController ()

@end

@implementation DetailedViewController

@synthesize subTweetsArray, time, totalSteps;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title=@" ";
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableDictionary *tweetDictionary=[subTweetsArray lastObject];
    
    imageData= [NSData dataWithContentsOfURL:[NSURL URLWithString:[tweetDictionary objectForKey:@"IMG"]]];
    
    userName=[tweetDictionary objectForKey:@"HNDL"];
    
    _summaryView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern3.png"]];
    
    [_summaryView setFrame:CGRectMake(0.0, 0.0, 320, 45)];

    [self.view addSubview:_summaryView];
    
    [self.tableView reloadData];
    
    
}
-(void) viewWillAppear:(BOOL)animated{
    

    _totalStepsLabel.text=totalSteps;
    
    _timeLabel.text=time;
    
    [self.tableView reloadData];
     
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
    
    return [subTweetsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    DetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        
        NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil];
        
        for (id obj in views) {
            
            if ([obj isKindOfClass:[UITableViewCell class]]) {
                cell=(DetailTableViewCell*) obj;
            }
            
        }
        
    }
    
    
    NSMutableDictionary *tweetDictionary=[subTweetsArray objectAtIndex:indexPath.row];
    
    cell.imageView.image=[UIImage imageWithData:imageData];
    
    [cell.imageView.layer setMasksToBounds:YES];
    
    [cell.imageView.layer setCornerRadius:7.0f];
    
    
    
    cell.handleLable.text=[@"@" stringByAppendingString:[tweetDictionary objectForKey:@"HNDL"]];
    
    cell.stepCountLabel.text=[NSString stringWithFormat:@"%@",[tweetDictionary objectForKey:@"STEPS"]];
    
    cell.timeLabel.text=[tweetDictionary objectForKey:@"TIME"];
    
    cell.commentTextView.text=[tweetDictionary objectForKey:@"COMMENT"];
    return cell;
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


@end
