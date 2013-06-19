//
//  GameViewController.m
//  game
//
//  Created by Mark Evans on 3/8/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "GameViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "Reachability.h"
#import <Parse/Parse.h>
#import "RNBlurModalView.h"
#import "OLGhostAlertView.h"
#import <Social/Social.h>

@interface GameViewController ()

@end

@implementation GameViewController
@synthesize theScore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //Retrieve Questions
    AppDelegate *appDelegate;
    appDelegate = [[UIApplication sharedApplication]delegate];
    NSLog(@"GameType: %@", appDelegate.GameType);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *state = [defaults objectForKey:@"state"];
    NSLog(@"appDelegate state: %@",state);
    if (state != nil)
    {
        if ([state isEqualToString:@"YES"])
        {
            [muteButton setSelected:NO];
            [muteLabel setText:@"mute"];
        } else {
            [muteButton setSelected:YES];
            [muteLabel setText:@"un-mute"];
        }
    }
}

-(IBAction)startGame:(id)sender
{
	time = 30.0;
	timer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

- (IBAction)submitAnswer:(id)sender
{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if ([answerFeild.text isEqualToString:theAnswer])
    {
        [resultsLabel setText:@""];
        [self stopGame:nil];
        [self calcScore];
        [alert show];
        [answerFeild setText:@""];
        [self calcQuestion];
    } else {
        if ([appDelegate.PlayAudio isEqualToString:@"YES"])
        {
            AudioServicesPlaySystemSound(wrong);
        }
        [resultsLabel setText:@"Wrong"];
        [resultsLabel setTextColor:[UIColor redColor]];
    }
}

-(void) updateLabel
{
	timeLabel.text = [NSString stringWithFormat:@":%i",time];
    NSLog(@"%i", time);
}

-(IBAction)stopGame:(id)sender
{
    [timer invalidate];
    timer = nil;
    carryOverTime = time;
    NSLog(@"BLAH: %i", carryOverTime); //Where count is when stopped
    [self updateLabel];
}

-(IBAction)mute:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if(muteButton.isSelected)
    {
        [muteButton setSelected:NO];
        [muteLabel setText:@"mute"];
        appDelegate.PlayAudio = @"YES";
        [defaults setObject:@"YES" forKey:@"state"];
        [defaults synchronize];
        if ([tune isPlaying]){
            //Do nothing
        } else {
            [tune play];
        }
    }
    else {
        [muteButton setSelected:YES];
        [muteLabel setText:@"un-mute"];
        appDelegate.PlayAudio = @"NO";
        [defaults setObject:@"NO" forKey:@"state"];
        [defaults synchronize];
        [tune stop];
    }
}

-(IBAction)closeView:(id)sender
{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [self stopGame:nil];
    [tune stop];
    if ([appDelegate.PlayAudio isEqualToString:@"YES"])
    {
        AudioServicesPlaySystemSound(end);
    }
    [self dismissViewControllerAnimated:true completion:nil];    
    if(![self connected])
    {
        OLGhostAlertView *connAlert = [[OLGhostAlertView alloc]initWithTitle:@"Alert" message:@"Internet Connection Lost. Can NOT save score to server." timeout:4.2 dismissible:TRUE];
        connAlert.position = OLGhostAlertViewPositionCenter;
        [connAlert show];
        NSLog(@"Not Connected to internet");
    } else {
        @try {
            if([scoreLabel.text isEqualToString:@"0"] || scoreLabel.text == nil){
                NSLog(@"ERROR HERE!");
            } else {
                NSLog(@"FACEBOOK NAME: %@",[appDelegate.userProfile objectForKey:@"name"]);
                if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
                    NSString *savedObj = [appDelegate.userProfile objectForKey:@"name"];
                    PFObject *gameScore = [PFObject objectWithClassName:@"SavedScore"];
                    [gameScore setObject:[NSNumber numberWithInt:scoreLabel.text.intValue] forKey:@"score"];
                    [gameScore setObject:savedObj forKey:@"playerName"];
                    [gameScore save];
                } else {
                    NSString *savedObj = [[NSString alloc]initWithFormat:@"%@",[[PFUser currentUser] username]];
                    PFObject *gameScore = [PFObject objectWithClassName:@"SavedScore"];
                    [gameScore setObject:[NSNumber numberWithInt:scoreLabel.text.intValue] forKey:@"score"];
                    [gameScore setObject:savedObj forKey:@"playerName"];
                    [gameScore save];
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
    }
    NSString *msg = [[NSString alloc]initWithFormat:@"%@", scoreLabel.text];
    
    OLGhostAlertView *thealert = [[OLGhostAlertView alloc]initWithTitle:@"Game Over" message:msg timeout:4.2 dismissible:TRUE];
    thealert.position = OLGhostAlertViewPositionCenter;
    [thealert show];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateParent" object:nil];
}

-(void)countDown
{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if (time < 0) {
        [timer invalidate];
        timer = nil;
        [self dismissViewControllerAnimated:true completion:nil];
    }
    if ([appDelegate.PlayAudio isEqualToString:@"YES"])
    {
        [tune play];
    }
    time--;
    [self updateLabel];
    if (time == 0) {
        [self stopGame:nil];
        if ([appDelegate.PlayAudio isEqualToString:@"YES"])
        {
            [tune stop];
            AudioServicesPlaySystemSound(end);
        }
        [self dismissViewControllerAnimated:true completion:nil];
        
        if(![self connected])
        {
            OLGhostAlertView *connAlert = [[OLGhostAlertView alloc]initWithTitle:@"Alert" message:@"Internet Connection Lost. Can NOT save score to server." timeout:4.2 dismissible:TRUE];
            connAlert.position = OLGhostAlertViewPositionCenter;
            [connAlert show];
            NSLog(@"Not Connected to internet");
        } else {
            @try {
                if([scoreLabel.text isEqualToString:@"0"] || scoreLabel.text == nil){
                    NSLog(@"ERROR HERE!");
                } else {
                    NSLog(@"FACEBOOK NAME: %@",[appDelegate.userProfile objectForKey:@"name"]);
                    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
                        NSString *savedObj = [appDelegate.userProfile objectForKey:@"name"];
                        PFObject *gameScore = [PFObject objectWithClassName:@"SavedScore"];
                        [gameScore setObject:[NSNumber numberWithInt:scoreLabel.text.intValue] forKey:@"score"];
                        [gameScore setObject:savedObj forKey:@"playerName"];
                        [gameScore save];
                    } else {
                        NSString *savedObj = [[NSString alloc]initWithFormat:@"%@",[[PFUser currentUser] username]];
                        PFObject *gameScore = [PFObject objectWithClassName:@"SavedScore"];
                        [gameScore setObject:[NSNumber numberWithInt:scoreLabel.text.intValue] forKey:@"score"];
                        [gameScore setObject:savedObj forKey:@"playerName"];
                        [gameScore save];
                    }
                }
            }
            @catch (NSException *exception) {
                NSLog(@"%@",exception);
            }
        }
        NSString *msg = [[NSString alloc]initWithFormat:@"%@", scoreLabel.text];
        OLGhostAlertView *thealert = [[OLGhostAlertView alloc]initWithTitle:@"Game Over" message:msg timeout:4.2 dismissible:TRUE];
        thealert.position = OLGhostAlertViewPositionCenter;
        [thealert show];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateParent" object:nil];
    }
}

-(void)shareFacebook
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController*fvc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        NSString *msg = [[NSString alloc]initWithFormat:@"I'm playing MathZone and killing it! Game Score: %@",scoreLabel.text];
        [fvc setInitialText:msg];
        [fvc addImage:[UIImage imageNamed:@"default.png"]];
        [self presentViewController:fvc animated:YES completion:nil];
    }
}

- (void)calcQuestion
{
    //Random int
    int r = arc4random() % [passedArray count];
    NSLog(@"Random: %i", r);
    
    //Random Question and Answer
    eDict = [passedArray objectAtIndex:r];
    NSString *q = [eDict valueForKey:@"Question"];
    NSString *a = [eDict valueForKey:@"Answer"];
    NSLog(@"Question: %@\nAnswer: %@", q, a);
    
    //Set Question and Answer
    questionLabel.text = q;
    theAnswer = a;
}

- (void)calcScore
{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSLog(@"LOG TIME: %i", carryOverTime);
    if ([scoreLabel.text isEqualToString:@"0"]){
        if (carryOverTime >= 20){
            NSString *score = [[NSString alloc]initWithFormat:@"%i", 500];
            [scoreLabel setText:score];
            if ([appDelegate.PlayAudio isEqualToString:@"YES"])
            {
                AudioServicesPlaySystemSound(coin);
            }
            [self startGame:nil];
        }
        else if (carryOverTime < 20 && carryOverTime >= 12){
            NSString *score = [[NSString alloc]initWithFormat:@"%i", 300];
            [scoreLabel setText:score];
            if ([appDelegate.PlayAudio isEqualToString:@"YES"])
            {
                AudioServicesPlaySystemSound(coin);
            }
            [self startGame:nil];
        }
        else if (carryOverTime < 12 && carryOverTime >= 1){
            NSString *score = [[NSString alloc]initWithFormat:@"%i", 100];
            [scoreLabel setText:score];
            if ([appDelegate.PlayAudio isEqualToString:@"YES"])
            {
                AudioServicesPlaySystemSound(coin);
            }
            [self startGame:nil];
        }
        else if (carryOverTime == 0){
            NSString *score = [[NSString alloc]initWithFormat:@"%i", 0];
            [scoreLabel setText:score];
            if ([appDelegate.PlayAudio isEqualToString:@"YES"])
            {
                AudioServicesPlaySystemSound(end);
                [tune stop];
            }
            [self startGame:nil];
        }
    } else {
        if (carryOverTime >= 20){
            NSString *readScore = [[NSString alloc]initWithFormat:@"%@",scoreLabel.text];
            NSString *score = [[NSString alloc]initWithFormat:@"%i", 500];
            int total = readScore.intValue + score.intValue;
            if ([appDelegate.PlayAudio isEqualToString:@"YES"])
            {
                AudioServicesPlaySystemSound(coin);
            }
            NSString *showTotal = [[NSString alloc]initWithFormat:@"%i", total];
            [scoreLabel setText:showTotal];
            [self startGame:nil];
            
        }
        else if (carryOverTime < 20 && carryOverTime >= 12){
            NSString *readScore = [[NSString alloc]initWithFormat:@"%@",scoreLabel.text];
            NSString *score = [[NSString alloc]initWithFormat:@"%i", 300];
            int total = readScore.intValue + score.intValue;
            if ([appDelegate.PlayAudio isEqualToString:@"YES"])
            {
                AudioServicesPlaySystemSound(coin);
            }
            NSString *showTotal = [[NSString alloc]initWithFormat:@"%i", total];
            [scoreLabel setText:showTotal];
            [self startGame:nil];
        }
        else if (carryOverTime < 12 && carryOverTime >= 1){
            NSString *readScore = [[NSString alloc]initWithFormat:@"%@",scoreLabel.text];
            NSString *score = [[NSString alloc]initWithFormat:@"%i", 100];
            int total = readScore.intValue + score.intValue;
            if ([appDelegate.PlayAudio isEqualToString:@"YES"])
            {
                AudioServicesPlaySystemSound(coin);
            }
            NSString *showTotal = [[NSString alloc]initWithFormat:@"%i", total];
            [scoreLabel setText:showTotal];
            [self startGame:nil];
        }
        else if (carryOverTime == 0){
            NSString *readScore = [[NSString alloc]initWithFormat:@"%@",scoreLabel.text];
            NSString *score = [[NSString alloc]initWithFormat:@"%i", 0];
            int total = readScore.intValue + score.intValue;
            if ([appDelegate.PlayAudio isEqualToString:@"YES"])
            {
                AudioServicesPlaySystemSound(end);
                [tune stop];
            }
            NSString *showTotal = [[NSString alloc]initWithFormat:@"%i", total];
            [scoreLabel setText:showTotal];
            [self startGame:nil];
        }
    }
}

-(void)viewDidUnload
{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if ([appDelegate.PlayAudio isEqualToString:@"YES"])
    {
        AudioServicesDisposeSystemSoundID(coin);
        AudioServicesDisposeSystemSoundID(end);
        AudioServicesDisposeSystemSoundID(wrong);
    }
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == answerFeild)
    {
        if ([answerFeild.text isEqualToString:theAnswer])
        {
            [resultsLabel setText:@""];
            [self stopGame:nil];
            alert = [[UIAlertView alloc]initWithTitle:@"Correct" message:@"Your answer was correct!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles: nil];
            [alert show];
            [answerFeild setText:@""];
            [self calcQuestion];
            [self startGame:nil];
        } else {
            [resultsLabel setText:@"Wrong"];
            [resultsLabel setTextColor:[UIColor redColor]];
        }
        return TRUE;
    } else {
        return FALSE;
    }
    return TRUE;
}

-(IBAction)resignKeyboard:(id)sender
{
    [answerFeild resignFirstResponder];
}
-(void)clear
{
    [answerFeild setText:@""];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set Delegate
    alert.delegate = self;
    answerFeild.delegate = self;
    thenavbar.delegate = self;
    
    [closebtn setShowsTouchWhenHighlighted:YES];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"coin" ofType:@"mp3"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &coin);
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"end" ofType:@"mp3"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path2], &end);
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"wrong" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path3], &wrong);
    NSString *path4 = [[NSBundle mainBundle] pathForResource:@"tune" ofType:@"wav"];
    tune= [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path4] error:NULL];
    tune.numberOfLoops = -1;
    tune.delegate = self;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    answerFeild.leftView = paddingView;
    answerFeild.leftViewMode = UITextFieldViewModeAlways;
    
    //Set Custom NavBar
    UIImage *image = [UIImage imageNamed:@"navbg.png"];
    [[UINavigationBar appearance]setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                UITextAttributeTextColor: [UIColor whiteColor],
                          UITextAttributeTextShadowColor: [UIColor blackColor],
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                     UITextAttributeFont: [UIFont fontWithName:@"MarkerFelt-Wide" size:20.0f]
     }];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"shadow.png"]];
    
    //Set Keyboard
    [answerFeild setKeyboardType:UIKeyboardTypeNumberPad];
    [answerFeild becomeFirstResponder];
    
    //Set Toolbar for Keyboard
    UIImage *clear = [UIImage imageNamed:@"btn3.png"];
    CGRect clearframe = CGRectMake(0, 1, 75, 35);
    UIView *clearView = [[UIView alloc]initWithFrame:clearframe];
    UIButton* clearBtn = [[UIButton alloc]initWithFrame:clearframe];
    [clearBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [clearBtn setTitle:@"CLEAR" forState:UIControlStateNormal];
    [clearBtn setBackgroundImage:clear forState:UIControlStateNormal];
    [clearBtn setShowsTouchWhenHighlighted:YES];
    [clearBtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [clearView addSubview:clearBtn];
    
    UIImage *submit = [UIImage imageNamed:@"btn4.png"];
    CGRect submitframe = CGRectMake(0, 1, 75, 35);
    UIView *submitView = [[UIView alloc]initWithFrame:submitframe];
    UIButton* submitBtn = [[UIButton alloc]initWithFrame:submitframe];
    [submitBtn setBackgroundImage:submit forState:UIControlStateNormal];
    [submitBtn setTitle:@"SUBMIT" forState:UIControlStateNormal];
    [submitBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [submitBtn setShowsTouchWhenHighlighted:YES];
    [submitBtn addTarget:self action:@selector(submitAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [submitView addSubview:submitBtn];
    
    UIImage *headerImage = [UIImage imageNamed:@"logo.png"];
    navItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBackgroundImage:[UIImage imageNamed:@"navbg.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [toolbar sizeToFit];
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc]initWithCustomView:clearView];
    UIBarButtonItem *submitButton =[[UIBarButtonItem alloc]initWithCustomView:submitView];
    NSArray *itemsArray = [NSArray arrayWithObjects:doneButton, flexButton, submitButton, nil];
    [toolbar setItems:itemsArray];
    [answerFeild setInputAccessoryView:toolbar];
    
    //Retrieve Questions
    AppDelegate *appDelegate;
    appDelegate = [[UIApplication sharedApplication]delegate];
    
    if ([appDelegate.GameType isEqualToString:@"beginner"])
    {
        passedArray = [[NSMutableArray alloc]initWithArray:[appDelegate beginnerArray]];
        NSLog(@"b 1");
    }
    else if ([appDelegate.GameType isEqualToString:@"intermediate"])
    {
        passedArray = [[NSMutableArray alloc]initWithArray:[appDelegate intermediateArray]];
        NSLog(@"i 2");
    }
    else if ([appDelegate.GameType isEqualToString:@"advanced"])
    {
        passedArray = [[NSMutableArray alloc]initWithArray:[appDelegate advancedArray]];
        NSLog(@"a 3");
    } else {
        passedArray = [[NSMutableArray alloc]initWithArray:[appDelegate qaArray]];
        NSLog(@"passed array count: %i", passedArray.count);
    }
    
    [self calcQuestion];
    
    //Set Timer
    time = 30.0;
	timer = [NSTimer scheduledTimerWithTimeInterval:.75 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
