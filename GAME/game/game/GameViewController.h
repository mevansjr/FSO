//
//  GameViewController.h
//  game
//
//  Created by Mark Evans on 3/8/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface GameViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, UINavigationBarDelegate, AVAudioPlayerDelegate>
{
    NSTimer *timer;
    SystemSoundID coin;
    SystemSoundID end;
    SystemSoundID wrong;
    AVAudioPlayer* tune;
    int time;
    int carryOverTime;
    IBOutlet UILabel *questionLabel;
    IBOutlet UIButton *closebtn;
    IBOutlet UITextField *answerFeild;
    IBOutlet UILabel *timeLabel;
    IBOutlet UIButton *timerButton;
    IBOutlet UILabel *resultsLabel;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UINavigationBar *thenavbar;
    IBOutlet UINavigationController *navController;
    IBOutlet UINavigationItem *navItem;
    UIAlertView *alert;
    NSMutableArray *passedArray;
    NSDictionary *eDict;
    NSString *theAnswer;
    NSString *theScore;
    UIView *gameOverView;
    IBOutlet UIButton *muteButton;
    IBOutlet UILabel *muteLabel;
}
@property (strong, nonatomic) NSString *theScore;

@end
