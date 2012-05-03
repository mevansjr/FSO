//
//  ShapeClass.m
//  Project1
//
//  Created by Mark Evans on 5/3/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "ShapeClass.h"

@implementation ShapeClass
-(id)initWithDetails:(int)type numSides:(int)numSides name:(NSString*)name areaVal:(int)areaVal
{
    _type = type;
    _numSides = numSides;
    _name = name;
    _areaVal = areaVal;
    return self;
}

@end
