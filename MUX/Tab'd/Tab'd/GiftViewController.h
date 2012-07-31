//
//  GiftViewController.h
//  Tab'd
//
//  Created by Mark Evans on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftViewController : UIViewController <UISearchBarDelegate>
{
    IBOutlet UISearchBar* theSearchBar;
}
- (IBAction)onClose:(id)sender;
- (IBAction)onClick:(id)sender;
@end
