//
//  TriangleClass.m
//  Project1
//
//  Created by Mark Evans on 5/3/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "ShapeClass.h"
#import "TriangleClass.h"


@implementation TriangleClass
-(id)init
{
    if (self = [super init])
    {
        [self initWithDetails:1 numSides:3 name:@"Traingle" areaVal:0]; 
        
    }
    return self;
}
-(int)GetArea
{
    _areaVal = 0.5f * (8 * 7);
    
    //NSLog(@"Inside GetArea areaVal= %f", areaVal);
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