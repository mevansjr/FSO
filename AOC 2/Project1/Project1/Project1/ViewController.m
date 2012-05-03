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
