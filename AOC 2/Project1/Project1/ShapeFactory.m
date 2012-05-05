//
//  ShapeFactory.m
//
//  Created by Mark Evans on 5/3/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "ShapeFactory.h"
#import "ShapeClass.h"
#import "SquareClass.h"
#import "TriangleClass.h"
#import "RectangleClass.h"


@implementation ShapeFactory
 
-(ShapeClass*)CreateShape:(NSInteger)shapeType
{
    //int _shapeType = shapeType;
    
    if (shapeType == 0)
    {
        return [[SquareClass alloc] initWithDetails:0 numSides:4 name:@"Square" areaVal:(7 * 5)];
    }
    else if (shapeType == 1)
    {
        return [[TriangleClass alloc] initWithDetails:1 numSides:3 name:@"Triangle" areaVal:(0.5f * (8 * 7))];
        
    }
    else if (shapeType == 2)
    {
        return [[RectangleClass alloc] initWithDetails:2  numSides:4 name:@"Rectangle" areaVal:(5 * 8)];
    
    }
    return nil;
     
}

@end
