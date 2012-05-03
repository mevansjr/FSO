//
//  RectangleClass.m
//  Project1
//
//  Created by Mark Evans on 5/3/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "RectangleClass.h"
#import "ShapeClass.h"

@implementation RectangleClass
-(id)initWithDetails: (int)numSides name:(NSString*)name
{
    if (self = [super init])
    {
        [self initWithDetails:2 numSides:4 name:@"Rectangle" areaVal:0]; 
        
    }
    return self;
}
-(int)GetArea
{
    _areaVal = (5 * 8);
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
