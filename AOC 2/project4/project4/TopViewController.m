//
//  TopViewController.m
//  project4
//
//  Created by Mark Evans on 5/14/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "TopViewController.h"
#import "ViewController.h"

@implementation TopViewController

@synthesize closeKeyBoardButton;
@synthesize leftSwiper;
@synthesize myDatePicker;
@synthesize myTextField;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)onSwipe:(UISwipeGestureRecognizer*)recognizer
{
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
        if (delegate != nil)
        {
            if ((myDatePicker != nil) && (myTextField != nil))
            {
                NSDate *selected = myDatePicker.date;
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm:SS a"];           
                
                NSString *newEventLabel = [[NSString alloc] initWithString:@"New Event: "];
                NSString *textFieldVar = [[NSString alloc] initWithString: textField.text];
                NSString *dateString = [dateFormatter stringFromDate:selected];  
                NSString *newString = [[NSString alloc] initWithFormat:@"%@%@\n%@ \n\n",newEventLabel, textFieldVar, dateString];          
                [delegate DidClose:newString];            
            }
            [self dismissModalViewControllerAnimated:true];
        }
    
        else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
        {
            NSString *test = @"hello";
            NSLog(@"%@", test);
        }
    
}

//-(IBAction)DidSave:(id)sender
//{
//    if (delegate != nil)
//    {
//        if ((myDatePicker != nil) && (myTextField != nil))
//        {
//            myDatePicker.minimumDate = [NSDate date];
//            NSDate *selected = myDatePicker.date;
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm:SS a"];           
//            
//            NSString *newEventLabel = [[NSString alloc] initWithString:@"New Event: "];
//            NSString *textFieldVar = [[NSString alloc] initWithString: textField.text];
//            NSString *dateString = [dateFormatter stringFromDate:selected];  
//            NSString *newString = [[NSString alloc] initWithFormat:@"%@%@\n%@ \n\n",newEventLabel, textFieldVar, dateString];         
//            [delegate DidClose:newString];            
//        }
//        [self dismissModalViewControllerAnimated:true];
//    }
//}

- (IBAction)dismissKeyboard:(id)sender {
    [myTextField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    myTextField = nil;
    [self setMyTextField:nil];
    [self setCloseKeyBoardButton:nil];
    //[self setSaveDataButton:nil];
    [self setMyDatePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated
{
    topLeftSwiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
    topLeftSwiper.direction = UISwipeGestureRecognizerDirectionLeft;
    [topSwipeLabel addGestureRecognizer:topLeftSwiper];
    
    topRightSwiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
    topRightSwiper.direction = UISwipeGestureRecognizerDirectionRight;
    [topSwipeLabel addGestureRecognizer:topRightSwiper];
    
    [super viewWillAppear:animated];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)eventTextField
{
    eventTextField.text = [NSString stringWithString:@""];
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self dismissModalViewControllerAnimated:true];
    return true;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
