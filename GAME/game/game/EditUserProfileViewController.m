//
//  EditUserProfileViewController.m
//  game
//
//  Created by Mark Evans on 4/19/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "EditUserProfileViewController.h"
#import "UserProfileViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "Reachability.h"
#import "RNBlurModalView.h"
#import <Parse/Parse.h>
#import <Social/Social.h>
#import "LeaderBoardViewController.h"
#import "OLGhostAlertView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

@interface EditUserProfileViewController ()

@end

@implementation EditUserProfileViewController
@synthesize profileImg, sname, slocation, sbirthday, sgender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        NSLog(@"SHAKING IS OCCURING");
        //        if ([self connected])
        //        {
        //            OLGhostAlertView *thealert = [[OLGhostAlertView alloc]initWithTitle:@"SYNC" message:@"Image in sync" timeout:2.2 dismissible:TRUE];
        //            thealert.position = OLGhostAlertViewPositionCenter;
        //            [thealert show];
        //            NSData *theimageData = UIImagePNGRepresentation(profileImg.image);
        //            PFFile *imageFile = [PFFile fileWithName:@"image.png" data:theimageData];
        //            [imageFile save];
        //
        //            PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
        //            [userPhoto setObject:@"Profile Image" forKey:@"imageName"];
        //            [userPhoto setObject:imageFile forKey:@"imageFile"];
        //            [userPhoto save];
        //        }
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

- (IBAction)logOutButtonTapAction:(id)sender
{
    [PFUser logOut];
    [self dismissViewControllerAnimated:TRUE completion:nil];
    ViewController *viewController = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [viewController viewDidAppear:true];
}

- (IBAction)dismissKeyboard:(id)sender
{
    [namef resignFirstResponder];
    [genderf resignFirstResponder];
    [locationf resignFirstResponder];
    [birthdayf resignFirstResponder];
    
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        if (self.view.bounds.origin.y == 170)
        {
            [self.view setBounds:CGRectMake(0, -10, theWidth, theHeight)];
        }
        if (self.view.bounds.origin.y == -10)
        {
            NSLog(@"were good 1");
            [selectIMG setHidden:FALSE];
            [profileImg setHidden:FALSE];
            [stackIMG setHidden:FALSE];
        }
        
    } else {
    
    if (self.view.bounds.origin.y == 150)
    {
        [self.view setBounds:CGRectMake(0, -10, theWidth, theHeight)];
    }
    if (self.view.bounds.origin.y == -10)
    {
        NSLog(@"were good");
        [selectIMG setHidden:FALSE];
        [profileImg setHidden:FALSE];
        [stackIMG setHidden:FALSE];
    }
        
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [namef resignFirstResponder];
    [genderf resignFirstResponder];
    [locationf resignFirstResponder];
    [birthdayf resignFirstResponder];
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        if (self.view.bounds.origin.y == 170)
        {
            [self.view setBounds:CGRectMake(0, -10, theWidth, theHeight)];
        }
        if (self.view.bounds.origin.y == -10)
        {
            NSLog(@"were good 1");
            [selectIMG setHidden:FALSE];
            [profileImg setHidden:FALSE];
            [stackIMG setHidden:FALSE];
        }
        
    } else {
        
        if (self.view.bounds.origin.y == 150)
        {
            [self.view setBounds:CGRectMake(0, -10, theWidth, theHeight)];
        }
        if (self.view.bounds.origin.y == -10)
        {
            NSLog(@"were good");
            [selectIMG setHidden:FALSE];
            [profileImg setHidden:FALSE];
            [stackIMG setHidden:FALSE];
        }
    }
    return TRUE;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        if (textField == namef)
        {
            [selectIMG setHidden:TRUE];
            [profileImg setHidden:TRUE];
            [stackIMG setHidden:TRUE];
            [self.view setBounds:CGRectMake(0, 170, theWidth, theHeight)];
        }
        if (textField == genderf)
        {
            [selectIMG setHidden:TRUE];
            [profileImg setHidden:TRUE];
            [stackIMG setHidden:TRUE];
            [self.view setBounds:CGRectMake(0, 170, theWidth, theHeight)];
        }
        if (textField == locationf)
        {
            [selectIMG setHidden:TRUE];
            [profileImg setHidden:TRUE];
            [stackIMG setHidden:TRUE];
            [self.view setBounds:CGRectMake(0, 170, theWidth, theHeight)];
        }
        if (textField == birthdayf)
        {
            [selectIMG setHidden:TRUE];
            [profileImg setHidden:TRUE];
            [stackIMG setHidden:TRUE];
            [self.view setBounds:CGRectMake(0, 170, theWidth, theHeight)];
        }
        
    } else {
        
    if (textField == namef)
    {
        [selectIMG setHidden:TRUE];
        [profileImg setHidden:TRUE];
        [stackIMG setHidden:TRUE];
        [self.view setBounds:CGRectMake(0, 150, theWidth, theHeight)];
    }
    if (textField == genderf)
    {
        [selectIMG setHidden:TRUE];
        [profileImg setHidden:TRUE];
        [stackIMG setHidden:TRUE];
        [self.view setBounds:CGRectMake(0, 150, theWidth, theHeight)];
    }
    if (textField == locationf)
    {
        [selectIMG setHidden:TRUE];
        [profileImg setHidden:TRUE];
        [stackIMG setHidden:TRUE];
        [self.view setBounds:CGRectMake(0, 150, theWidth, theHeight)];
    }
    if (textField == birthdayf)
    {
        [selectIMG setHidden:TRUE];
        [profileImg setHidden:TRUE];
        [stackIMG setHidden:TRUE];
        [self.view setBounds:CGRectMake(0, 150, theWidth, theHeight)];
    }

    }
    return TRUE;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
//    [namef resignFirstResponder];
//    [genderf resignFirstResponder];
//    [locationf resignFirstResponder];
//    [birthdayf resignFirstResponder];
//    if (self.view.bounds.origin.y == 150)
//    {
//        [self.view setBounds:CGRectMake(0, -10, theWidth, theHeight)];
//    }
//    if (self.view.bounds.origin.y == -10)
//    {
//        NSLog(@"were good");
//        [selectIMG setHidden:FALSE];
//        [profileImg setHidden:FALSE];
//        [stackIMG setHidden:FALSE];
//    }
    return TRUE;
}

-(void)viewWillAppear:(BOOL)animated
{
    [profileImg becomeFirstResponder];
    
    theHeight = [[UIScreen mainScreen] bounds].size.height;
    theWidth = [[UIScreen mainScreen] bounds].size.width;
    theStatusbar = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    namef.delegate = self;
    genderf.delegate = self;
    locationf.delegate = self;
    birthdayf.delegate = self;
    
    namef.userInteractionEnabled = FALSE;
    
    [namef setText:sname];
    if (![sgender isEqualToString:@"N/A"])
    {
        [genderf setText:sgender];
        [locationf setText:slocation];
        [birthdayf setText:sbirthday];
    }
    
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    name = [appDelegate.userProfile objectForKey:@"name"];
    location = [appDelegate.userProfile objectForKey:@"location"];
    birthday = [appDelegate.userProfile objectForKey:@"birthday"];
    gender = [appDelegate.userProfile objectForKey:@"gender"];
    facebookID = appDelegate.facebookID;
    NSLog(@"Facebook ID: %@", facebookID);
    imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]]];
    
    [namel setText:@"N/A"];
    [locationl setText:@"N/A"];
    [birthdayl setText:@"N/A"];
    [genderl setText:@"N/A"];
    
    if(![self connected])
    {
        NSLog(@"Not Connected to internet");
    } else {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
        NSData *myData = [[NSData alloc] initWithContentsOfFile:appFile];
        
        if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]){
            [namel setText:name];
            [locationl setText:location];
            [birthdayl setText:birthday];
            [genderl setText:gender];
            
            profileImg = [[UIImageView alloc]initWithFrame:CGRectMake(99, 65, 124, 129)];
            [profileImg setImage:[UIImage imageNamed:@"nouser.png"]];
            profileImg.contentMode = UIViewContentModeScaleAspectFill;
            [profileImg.layer setBorderColor: [[UIColor whiteColor] CGColor]];
            [profileImg.layer setBorderWidth: 2.0];
            profileImg.layer.cornerRadius = 10;
            profileImg.clipsToBounds = YES;
            [self.view addSubview:profileImg];
            if (myData != nil)
            {
                [profileImg setImage:[UIImage imageWithData:myData]];
            } else {
                [profileImg setImage:[UIImage imageWithData:imageData]];
            }
        } else {
            nonfbName = [PFUser currentUser].username;
            [namel setText:nonfbName];
            [locationl setText:@"N/A"];
            [birthdayl setText:@"N/A"];
            [genderl setText:@"N/A"];
            
            profileImg = [[UIImageView alloc]initWithFrame:CGRectMake(99, 65, 124, 129)];
            [profileImg setImage:[UIImage imageNamed:@"nouser.png"]];
            profileImg.contentMode = UIViewContentModeScaleAspectFill;
            [profileImg.layer setBorderColor: [[UIColor whiteColor] CGColor]];
            [profileImg.layer setBorderWidth: 2.0];
            profileImg.layer.cornerRadius = 10;
            profileImg.clipsToBounds = YES;
            [self.view addSubview:profileImg];
            if (myData != nil)
            {
                [profileImg setImage:[UIImage imageWithData:myData]];
            }
        }
    }
}

- (IBAction)updateProfile:(id)sender
{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc]init];
    [userDict setObject:namef.text forKey:@"name"];
    [userDict setObject:genderf.text forKey:@"gender"];
    [userDict setObject:locationf.text forKey:@"location"];
    [userDict setObject:birthdayf.text forKey:@"birthday"];
    NSString *key = [[NSString alloc]initWithFormat:@"%@_userDict", appDelegate.theusername];
    [defaults setObject:userDict forKey:key];
    [defaults synchronize];
    
    [namef resignFirstResponder];
    [genderf resignFirstResponder];
    [locationf resignFirstResponder];
    [birthdayf resignFirstResponder];
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        if (self.view.bounds.origin.y == 170)
        {
            [self.view setBounds:CGRectMake(0, -10, theWidth, theHeight)];
        }
        if (self.view.bounds.origin.y == -10)
        {
            NSLog(@"were good 1");
            [selectIMG setHidden:FALSE];
            [profileImg setHidden:FALSE];
            [stackIMG setHidden:FALSE];
        }
        
    } else {
        
        if (self.view.bounds.origin.y == 150)
        {
            [self.view setBounds:CGRectMake(0, -10, theWidth, theHeight)];
        }
        if (self.view.bounds.origin.y == -10)
        {
            NSLog(@"were good");
            [selectIMG setHidden:FALSE];
            [profileImg setHidden:FALSE];
            [stackIMG setHidden:FALSE];
        }
    }
    OLGhostAlertView *thealert = [[OLGhostAlertView alloc]initWithTitle:@"ALERT" message:@"Profile Updated" timeout:4.2 dismissible:TRUE];
    thealert.position = OLGhostAlertViewPositionCenter;
    [thealert show];
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [profileImg resignFirstResponder];
    [super viewWillDisappear:animated];
}

-(IBAction)shareFacebook:(id)sender
{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if ([appDelegate.loggedinWithFacebook isEqualToString:@"YES"])
    {
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController*fvc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [fvc setInitialText:@"I'm playing MathZone and killing it!"];
            [fvc addImage:[UIImage imageNamed:@"icon@2x.png"]];
            [self presentViewController:fvc animated:YES completion:nil];
        }
    } else {
        OLGhostAlertView *thealert = [[OLGhostAlertView alloc]initWithTitle:@"ALERT" message:@"Log in with Facebook!" timeout:4.2 dismissible:TRUE];
        thealert.position = OLGhostAlertViewPositionCenter;
        [thealert show];
    }
}

-(IBAction)closeView:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)showLeaderBoard:(id)sender
{
    LeaderBoardViewController *leaderBoard = [[LeaderBoardViewController alloc]initWithNibName:@"LeaderBoardViewController" bundle:nil];
    [self presentViewController:leaderBoard animated:TRUE completion:nil];
}

- (IBAction)imageOptions:(id)sender
{
    popquery = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Photo" otherButtonTitles:@"Camera Roll", nil];
    popquery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [popquery showInView:[self view]];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    NSString *cancelTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
	if([title isEqualToString:@"Take Photo"])
	{
        NSLog(@"Take Photo");
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera])
        {
            imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker animated:YES completion:nil];
            _newMedia = YES;
        }
    }
    else if([title isEqualToString:@"Camera Roll"])
	{
        NSLog(@"Open Photo from Camera Roll");
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker animated:TRUE completion:nil];
            _newMedia = NO;
        }
        
    }
    else if([cancelTitle isEqualToString:@"Cancel"])
    {
        NSLog(@"Cancel button clicked.");
    }
}

- (UIImage *)scaleAndRotateImage:(UIImage *)image { // here we rotate the image in its orignel
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *i = [self scaleAndRotateImage:image];
    
    profileImg = [[UIImageView alloc]initWithFrame:CGRectMake(99, 65, 124, 129)];
    [profileImg setImage:i];
    profileImg.contentMode = UIViewContentModeScaleAspectFill;
    [profileImg.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [profileImg.layer setBorderWidth: 2.0];
    profileImg.layer.cornerRadius = 10;
    profileImg.clipsToBounds = YES;
    [self.view addSubview:profileImg];
    
    if (_newMedia)
        UIImageWriteToSavedPhotosAlbum(i, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
    NSData *theimageData = UIImagePNGRepresentation(i);
    [theimageData writeToFile:savedImagePath atomically:NO];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"YES" forKey:@"resetState"];
    [defaults synchronize];
    appDelegate.resetImage = @"YES";
    NSLog(@"Image was saved!");
    
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Save failed" message: @"Failed to save image"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)longPress
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
    if ([appDelegate.resetImage isEqualToString:@"YES"])
    {
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:savedImagePath error:NULL];
        
        profileImg = [[UIImageView alloc]initWithFrame:CGRectMake(99, 65, 124, 129)];
        profileImg.layer.cornerRadius = 10;
        [profileImg.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        [profileImg.layer setBorderWidth: 2.0];
        [profileImg setImage:[UIImage imageNamed:@"nouser.png"]];
        profileImg.contentMode = UIViewContentModeScaleAspectFill;
        profileImg.clipsToBounds = YES;
        [self.view addSubview:profileImg];
        
        if ([appDelegate.loggedinWithFacebook isEqualToString:@"YES"])
        {
            if (imageData != nil)
            {
                [profileImg setImage:[UIImage imageWithData:imageData]];
            }
        }
        
        OLGhostAlertView *thealert = [[OLGhostAlertView alloc]initWithTitle:@"ALERT" message:@"Profile Image reset!" timeout:3.2 dismissible:TRUE];
        thealert.position = OLGhostAlertViewPositionCenter;
        [thealert show];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"NO" forKey:@"resetState"];
        [defaults synchronize];
        appDelegate.resetImage = @"NO";
    }
}

- (void)setname:(NSString*)n setgender:(NSString*)g setlocation:(NSString*)l setbirthday:(NSString*)b
{
    sname = n;
    sgender = g;
    slocation = l;
    sbirthday = b;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    thenavbar.delegate = self;
    imagePicker.delegate = self;
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(longPress)];
    [longPressGesture setMinimumPressDuration:1];
    [selectIMG addGestureRecognizer:longPressGesture];
    
    //Set Custom NavBar
    UIImage *image = [UIImage imageNamed:@"navbg.png"];
    [[UINavigationBar appearance]setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"shadow.png"]];
    
    [closebtn setShowsTouchWhenHighlighted:YES];
    
    UIImage *headerImage = [UIImage imageNamed:@"logouserprofile.png"];
    navItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                UITextAttributeTextColor: [UIColor whiteColor],
                          UITextAttributeTextShadowColor: [UIColor blackColor],
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                     UITextAttributeFont: [UIFont boldSystemFontOfSize:20]
     }];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
