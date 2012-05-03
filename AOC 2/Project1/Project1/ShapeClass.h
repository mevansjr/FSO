//
//  ShapeClass.h
//
//  Created by Mark Evans on 5/3/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShapeClass : NSObject
{
@protected 
    
    int _type;
    int _numSides;
    int _areaVal;
    NSString* _name;
    NSString *textOutput;
}

-(id)initWithDetails:(int)type numSides:(int)numSides name:(NSString*)name areaVal:(int)areaVal;
-(int)GetArea;
-(NSString*)getTextOutput;

@end
