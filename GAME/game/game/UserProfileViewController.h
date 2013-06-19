//
//  UserProfileViewController.h
//  game
//
//  Created by Mark Evans on 3/13/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface UserProfileViewController : UIViewController <UINavigationBarDelegate, NSURLConnectionDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UINavigationBar *thenavbar;
    IBOutlet UILabel *namel;
    IBOutlet UILabel *locationl;
    IBOutlet UILabel *genderl;
    IBOutlet UILabel *birthdayl;
    IBOutlet UINavigationItem *navItem;
    IBOutlet UIImageView *profileImg;
    IBOutlet UIButton *closebtn;
    IBOutlet UIButton *selectIMG;
    IBOutlet UIButton *editBtn;
    UIImagePickerController *imagePicker;
    int percentDone1;
    UIActionSheet *popquery;
    NSData *imageData;
    NSData *parseImageData;
    NSString *facebookID;
    NSString *nonfbName;
    NSString *name;
    NSString *location;
    NSString *gender;
    NSString *birthday;
    float theHeight;
    float theWidth;
}
@property BOOL newMedia;
@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
- (IBAction)imageOptions:(id)sender;
- (IBAction)closeView:(id)sender;
- (IBAction)showLeaderBoard:(id)sender;
- (IBAction)shareFacebook:(id)sender;

@end
