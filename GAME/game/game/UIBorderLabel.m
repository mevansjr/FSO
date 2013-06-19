//
//  UIBorderLabel.m
//  game
//
//  Created by Mark Evans on 3/26/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "UIBorderLabel.h"

@implementation UIBorderLabel

@synthesize topInset, leftInset, bottomInset, rightInset;

- (void)drawTextInRect:(CGRect)rect
{
    UIEdgeInsets insets = {self.topInset, self.leftInset,
        self.bottomInset, self.rightInset};
    
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
