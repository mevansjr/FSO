//
//  UIBorderLabel.h
//  game
//
//  Created by Mark Evans on 3/26/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBorderLabel : UILabel
{
    CGFloat topInset;
    CGFloat leftInset;
    CGFloat bottomInset;
    CGFloat rightInset;
}

@property (nonatomic) CGFloat topInset;
@property (nonatomic) CGFloat leftInset;
@property (nonatomic) CGFloat bottomInset;
@property (nonatomic) CGFloat rightInset;

@end
