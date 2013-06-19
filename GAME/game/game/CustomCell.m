//
//  CustomCell.m
//  app
//
//  Created by Mark Evans on 8/27/12.
//  Copyright (c) 2012 Mark Evans. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize statusLabel, sourceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
