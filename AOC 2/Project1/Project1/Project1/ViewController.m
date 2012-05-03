//
//  ViewController.m
//  Project1
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:0.3294 green:0.6395 blue:0.8000 alpha:1];
    
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
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
