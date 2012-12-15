//
//  PostTweetViewController.m
//  TweetMySteps
//
//  Created by Prasad Pamidi on 11/21/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "PostTweetViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface PostTweetViewController ()

@end

@implementation PostTweetViewController

@synthesize delegate, tweetButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"Tweet";
        
        self.tabBarItem.image=[UIImage imageNamed:@"plus-sign.png"];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    charLeft=80;
    
    _commentTextView.delegate=self;
    
    _stepsTextField.delegate=self;
    
    _stepCountLabel.text=[NSString stringWithFormat:@"%d",charLeft];

    _commentTextView.contentSize=CGSizeMake(265.0f, 200.0f);
    
     
    [self.tableView reloadData];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                           selector:@selector (handle_TextFieldTextChanged:)
                               name:UITextFieldTextDidChangeNotification
                             object:_stepsTextField];
    
    [notificationCenter addObserver:self
                           selector:@selector (handle_TextViewTextChanged:)
                               name:UITextViewTextDidChangeNotification
                             object:comment];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    tapRecognizer.numberOfTapsRequired = 1;
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapRecognizer.cancelsTouchesInView=NO;

    
    [self.view addGestureRecognizer:tapRecognizer];
    

    [tweetButton setTintColor:[UIColor lightGrayColor]];
      
}

-(void) viewWillAppear:(BOOL)animated{
    
    charLeft=80;
    
    _progressView.progress=0;
    
  
    _stepCountLabel.text=[NSString stringWithFormat:@"%d",charLeft];

    
    _progressView.progressTintColor=[UIColor darkGrayColor];
    
    _stepCountLabel.textColor=[UIColor darkGrayColor];
    
    [self.tableView reloadData];
    
    _stepsTextField.text=@"";
    
    comment.text=@"Comment";
    
    [comment setTextColor:[UIColor lightGrayColor]];
    
    
    
}

-(void) hideKeyBoard:(id) sender{
    
    
    [_stepsTextField resignFirstResponder];
    
    [comment resignFirstResponder];

}


-(void) handle_TextFieldTextChanged:(id)notification{
    
    [self updateStepCount];
    
}

-(void) handle_TextViewTextChanged:(id)notification{
    
    [self updateStepCount];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _stepsTextField )
    {
        [_stepsTextField becomeFirstResponder];
    }

    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)string {
    
    if([string isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    if (charLeft==0&&![string isEqualToString:@""]) {
        
        return NO;
    }
    
    return YES;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = indexPath.row == 0 ? @"StepCountCell" : @"CommentCell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        if( indexPath.row == 0 ) {
            
            _stepsTextField.frame = CGRectMake(20,7,265,40);
            
            [cell addSubview:_stepsTextField];
            
        } else {
            
            comment = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, 265, 90)];
            
            comment.backgroundColor=[UIColor clearColor];

            comment.text=@"Comment";
            
            [comment setTextColor:[UIColor lightGrayColor]];
            
            [comment setFont:[UIFont fontWithName:@"Helvetica" size:14]];
            
            comment.delegate=self;
            
            [cell.contentView addSubview:comment];
        }
        
        aTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        aTableView.separatorColor = [UIColor grayColor];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        return 50.0f;
    }else{
        return 105.0f;
    }
    
}

-(BOOL) textViewShouldBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"Comment"]) {
        
        textView.text=@"";
        
        [textView setTextColor:[UIColor blackColor]];
        
    }
    
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /* for backspace */
    /*  limit to only numeric characters  */
    
    NSCharacterSet* numberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    
    for (int i = 0; i < [string length]; ++i)
    {
        unichar c = [string characterAtIndex:i];
        if (![numberCharSet characterIsMember:c])
        {
            return NO;
        }
    }
    
    if (charLeft==0&&![string isEqualToString:@""]) {
        
        return NO;
    }
    
    /*  limit the users input to only 9 characters  */
    
    NSUInteger newLength = [_stepsTextField.text length] + [string length] - range.length;
    return (newLength > 9)? NO : YES;
}


-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    
    [self updateStepCount];
    
    return YES;
}

-(void) updateStepCount{
    
    int commentTextLength;
    if ([comment.text isEqualToString:@"Comment"]) {
        
        commentTextLength=0;
        
    }else{
        
        commentTextLength=[comment.text length];
    
    }
    
 
    
    charLeft=80-([_stepsTextField.text length] + commentTextLength);
    
    _stepCountLabel.text=[NSString stringWithFormat:@"%d",charLeft];
    
   
    [self updateProgressBar];
    
}

-(void) updateProgressBar{
    
    int commentTextLength;
    if ([comment.text isEqualToString:@"Comment"]) {
        
        commentTextLength=0;
        
    }else{
        
        commentTextLength=[comment.text length];
        
    }

    
    int chars=[_stepsTextField.text length] + commentTextLength;
    
    _progressView.progress=chars*0.0125;
    
    
    
    if (charLeft<20) {
        
        _progressView.progressTintColor=[UIColor redColor];
        
        _stepCountLabel.textColor=[UIColor redColor];
        
    }else{
        
        _progressView.progressTintColor=[UIColor darkGrayColor];
        
        _stepCountLabel.textColor=[UIColor darkGrayColor];
        
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  

}

- (IBAction)postTweetMsg:(id)sender {
    
   // AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    

    if ([_stepsTextField.text length]>0&&[comment.text length]>0&&![comment.text isEqualToString:@"Comment"]) {
        
        
        
        ACAccountStore *account = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:
                                      ACAccountTypeIdentifierTwitter];
        
        [account requestAccessToAccountsWithType:accountType options:nil
                                      completion:^(BOOL granted, NSError *error)
         {
             if (granted == YES)
             {
                 NSArray *arrayOfAccounts = [account
                                             accountsWithAccountType:accountType];
                 
                 if ([arrayOfAccounts count] > 0)
                 {
                     ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                     
                     
                     //NSString *tweetMSG=[[[[[@"@tweetmysteps " stringByAppendingString:[NSString stringWithFormat:@"%d",[_stepsTextField.text intValue]]] stringByAppendingString:@" steps:"] stringByAppendingString:comment.text] stringByAppendingString:@" http://m.tweetmysteps.com/userProfile.php?username="] stringByAppendingString:[dataSource objectForKey:@"screen_name"]];
                   
                     NSMutableDictionary *dataSource=delegate.dataSource;
                     
                     NSString *tweetText=[[[NSString stringWithFormat:@"%d",[_stepsTextField.text intValue]] stringByAppendingString:@" steps:"] stringByAppendingString:comment.text]
                     ;
                     if ([tweetText length]>80) {
                         tweetText=[tweetText substringFromIndex:80];
                     }
                     
                     NSString *tweetMSG1=[[tweetText stringByAppendingString:@" http://m.tweetmysteps.com/userProfile.php?username="] stringByAppendingString:[dataSource objectForKey:@"screen_name"]];
                     

                     
                       
                     NSDictionary *message = @{@"status": tweetMSG1};
                     
                     NSURL *requestURL = [NSURL
                                          URLWithString:@"http://api.twitter.com/1/statuses/update.json"];
                     
                     SLRequest *postRequest = [SLRequest
                                               requestForServiceType:SLServiceTypeTwitter
                                               requestMethod:SLRequestMethodPOST
                                               URL:requestURL parameters:message];
                     
                     postRequest.account = twitterAccount;
                     
                     [postRequest performRequestWithHandler:^(NSData *responseData,
                                                              NSHTTPURLResponse *urlResponse, NSError *error)
                      {
                          
                          if ([urlResponse statusCode]==200) {
                              
                              NSLog(@"Tweeted Successfully");
                              
                          } else {
                              NSLog(@"Unable to post tweet due to error %i",[urlResponse statusCode]);
                          }
                          
                          
                      }];
                 }
             }
         }];
        
        
        
    }else{
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"TMS: Invalid Fields" message:@"Enter valid values into the fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
    }
    
    
    
}
@end
