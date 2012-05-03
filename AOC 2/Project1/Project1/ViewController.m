//
//  ViewController.m
//
//  Created by Mark Evans on 5/3/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "ViewController.h"
#import "ShapeClass.h"
#import "SquareClass.h"
#import "TriangleClass.h"
#import "RectangleClass.h"
#import "ShapeFactory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:0.3294 green:0.6395 blue:0.8000 alpha:1];
    
    ShapeFactory *shapeFactory = [[ShapeFactory alloc] init];
    if (shapeFactory != nil)
    {
        SquareClass *square = (SquareClass*) [shapeFactory CreateShape:0];
        [square GetArea];
        labelShapeType1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 180.0f, 200.0f, 20.0f)];
        
        if (labelShapeType1 != nil)
        {
            labelShapeType1.backgroundColor = [UIColor colorWithRed:0.3294 green:0.6395 blue:0.8000 alpha:1];
            labelShapeType1.text = [square getTextOutput];
            labelShapeType1.textAlignment = UITextAlignmentLeft;
            labelShapeType1.numberOfLines = 7;
            labelShapeType1.textColor = [UIColor blackColor]; 
        }
        [self.view addSubview:labelShapeType1];
    }
    {
        TriangleClass *triangle = (TriangleClass*) [shapeFactory CreateShape:1];
        [triangle GetArea];
        
        labelShapeType2 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 210.0f, 200.0f, 20.0f)];
        
        if (labelShapeType2 != nil)
        {
            labelShapeType2.backgroundColor = [UIColor colorWithRed:0.3294 green:0.6395 blue:0.8000 alpha:1];
            labelShapeType2.text = [triangle getTextOutput];
            labelShapeType2.textAlignment = UITextAlignmentLeft;
            labelShapeType2.numberOfLines = 7;
            labelShapeType2.textColor = [UIColor blackColor]; 
        }
        [self.view addSubview:labelShapeType2];
    }
    {
        ShapeClass *rectangle = [shapeFactory CreateShape:2];
        [rectangle GetArea];
 
        labelShapeType3 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 240.0f, 200.0f, 20.0f)];
        
        if (labelShapeType3 != nil)
        {
            labelShapeType3.backgroundColor = [UIColor colorWithRed:0.3294 green:0.6395 blue:0.8000 alpha:1];
            labelShapeType3.text = [rectangle getTextOutput];
            labelShapeType3.textAlignment = UITextAlignmentLeft;
            labelShapeType3.numberOfLines = 7;
            labelShapeType3.textColor = [UIColor blackColor]; 
        }
        [self.view addSubview:labelShapeType3];
    }
    
    labelProjectTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 40.0f, 320.0f, 60.0f)];
    if (labelProjectTitle != nil)
    {
        labelProjectTitle.backgroundColor = [UIColor colorWithRed:0.0824 green:0.1599 blue:0.2000 alpha:1];
        labelProjectTitle.text = @"AOC 2: Mark Evans";
        labelProjectTitle.textAlignment = UITextAlignmentCenter;
        labelProjectTitle.numberOfLines = 5;
        labelProjectTitle.textColor = [UIColor whiteColor];
        
    }
    [self.view addSubview:labelProjectTitle];

    labelItemDetails = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 345.0f, 320.0f, 120.0f)];
    
    if (labelItemDetails != nil)
    {
        labelItemDetails.backgroundColor = [UIColor colorWithRed:0.3294 green:0.6395 blue:0.8000 alpha:1];
        labelItemDetails.text = @"";
        labelItemDetails.textAlignment = UITextAlignmentCenter;
        labelItemDetails.numberOfLines = 7;
        labelItemDetails.textColor = [UIColor colorWithRed:0.957 green:0.941 blue:0.749 alpha:1]; 
    }
    [self.view addSubview:labelItemDetails];    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
