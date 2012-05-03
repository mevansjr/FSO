//
//  SquareClass.m
//  Project1
//
//  Created by Mark Evans on 5/3/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "SquareClass.h"
#import "ShapeClass.h"

@implementation SquareClass
-(id)init
{
    if (self = [super init])
    {
        [self initWithDetails:0 numSides:4 name:@"Square" areaVal:0]; 
        
    }
    return self;
}
-(int)GetArea
{
    _areaVal = (7 * 5);
    return _areaVal;
}
-(NSString*)getTextOutput
{
    textOutput = [NSString stringWithFormat:@"Shape %@ Area: %i", _name, _areaVal];
    if (textOutput != nil)
    {
        return textOutput;    
    }
    return nil;
    
} 

@end
