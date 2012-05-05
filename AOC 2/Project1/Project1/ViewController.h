//
//  ViewController.h
//
//  Created by Mark Evans on 5/3/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShapeClass.h"
#import "SquareClass.h"
#import "TriangleClass.h"
#import "RectangleClass.h"
#import "ShapeFactory.h"

@interface ViewController : UIViewController
{
    UILabel *labelProjectTitle;
    UILabel *labelShapeType1;  
    UILabel *labelShapeType2;
    UILabel *labelShapeType3;       
    UILabel *labelItemDetails; 
}


@end
