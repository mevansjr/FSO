//
//  CustomCellView2.h
//  Tab'd
//
//  Created by Mark Evans on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellView2 : UITableViewCell
{
    IBOutlet UILabel *textLabel;
    IBOutlet UILabel *statusLabel;
}

@property (nonatomic, retain) UILabel *statusLabel;

@end
