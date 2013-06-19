//
//  EditUserProfileViewController.h
//  game
//
//  Created by Mark Evans on 4/19/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface EditUserProfileViewController : UIViewController <UINavigationBarDelegate, NSURLConnectionDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
{
    IBOutlet UINavigationBar *thenavbar;
    IBOutlet UITextField *namef;
    IBOutlet UITextField *locationf;
    IBOutlet UITextField *genderf;
    IBOutlet UITextField *birthdayf;
    IBOutlet UILabel *namel;
    IBOutlet UILabel *locationl;
    IBOutlet UILabel *genderl;
    IBOutlet UILabel *birthdayl;
    IBOutlet UINavigationItem *navItem;
    IBOutlet UIImageView *profileImg;
    IBOutlet UIButton *closebtn;
    IBOutlet UIButton *selectIMG;
    IBOutlet UIImageView *stackIMG;
    IBOutlet UIButton *updateBtn;
    UIImagePickerController *imagePicker;
    int percentDone1;
    float theHeight;
    float theWidth;
    float theStatusbar;
    UIActionSheet *popquery;
    NSData *imageData;
    NSData *parseImageData;
    NSString *facebookID;
    NSString *nonfbName;
    NSString *name;
    NSString *location;
    NSString *gender;
    NSString *birthday;
}
- (void) setname:(NSString*)n setgender:(NSString*)g setlocation:(NSString*)l setbirthday:(NSString*)b;
@property BOOL newMedia;
@property (strong, nonatomic) UIImageView *profileImg;
@property (strong, nonatomic) NSString *sname;
@property (strong, nonatomic) NSString *slocation;
@property (strong, nonatomic) NSString *sgender;
@property (strong, nonatomic) NSString *sbirthday;
- (IBAction)imageOptions:(id)sender;
- (IBAction)closeView:(id)sender;
- (IBAction)showLeaderBoard:(id)sender;
- (IBAction)shareFacebook:(id)sender;

@end