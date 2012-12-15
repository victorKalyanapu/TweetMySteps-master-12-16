//
//  MyProfileViewController.m
//  TweetMySteps
//
//  Created by Tittu on 12/3/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "MyProfileViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>



@interface MyProfileViewController ()

@end

@implementation MyProfileViewController


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

- (void)viewDidLoad
{
    [super viewDidLoad];
    lifetimeTweetsArray=@[@"Lifetime1",@"Lifetime2",@"Lifetime3"];
    
    vsTweetsArray=@[@"vs1",@"vs2",@"vs3"];
    
    
    
    // self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, 1258.0f);
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
    
    
    [self.tableView reloadData];
    
    self.userDataArray=delegate.dataSource;
    
     
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
        
        return [vsTweetsArray count];
        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell=nil;
    
    cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (indexPath.section==0) {
        
        
        if (cell==nil) {
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
            
        }
        
        
        
    }
    
    NSArray *dataArray=nil;
    
    if (_segmentControl.selectedSegmentIndex==0) {
        
        dataArray=lifetimeTweetsArray;
        
    } else{
        
        dataArray=vsTweetsArray;
        
    }
    
    cell.textLabel.text=dataArray[indexPath.row];
    
    
    return cell;
    
}


- (IBAction)segmentChanged:(id)sender {
    
    [self.tableView reloadData];
    
}
@end
