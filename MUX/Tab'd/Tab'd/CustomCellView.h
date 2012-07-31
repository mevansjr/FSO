//
//  CustomCellView.h
//  Tab'd
//
//  Created by Mark Evans on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellView : UITableViewCell
{
    IBOutlet UILabel *textLabel;
    IBOutlet UILabel *statusLabel;
}

@property (nonatomic, retain) UILabel *statusLabel;

@end
