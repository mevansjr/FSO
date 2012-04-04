//
//  ViewController.m
//  project2
//
//  Created by Mark Evans on 4/4/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
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
    self.view.backgroundColor = [UIColor redColor];
    
    labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 320.0f, 60.0f)];
    if (labelTitle != nil)
    {
        labelTitle.backgroundColor = [UIColor purpleColor];
        labelTitle.text = @"Dexter by Design";
        labelTitle.textAlignment = UITextAlignmentCenter;
        labelTitle.numberOfLines = 5;
        labelTitle.textColor = [UIColor blackColor];
        
    }
    [self.view addSubview:labelTitle];
    labelAuthor = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 120.0f, 90.0f, 20.0f)];
    
    if (labelAuthor != nil)
    {   
        labelAuthor.backgroundColor = [UIColor greenColor];
        labelAuthor.text = @"Author:";
        labelAuthor.textAlignment = UITextAlignmentRight;
        labelAuthor.numberOfLines = 2;
        labelAuthor.textColor = [UIColor colorWithRed:0.8902 green:0.0244 blue:0.0245 alpha:1];
    }
    [self.view addSubview:labelAuthor];
    labelAuthorText = [[UILabel alloc] initWithFrame:CGRectMake(95.0f, 120.0f, 225.0f, 20.0f)];
    
    if (labelAuthorText != nil)
    {   
        labelAuthorText.backgroundColor = [UIColor blueColor];
        labelAuthorText.text = @"Jeff Lindsay";
        labelAuthorText.textAlignment = UITextAlignmentLeft;
        labelAuthorText.numberOfLines = 7;
        labelAuthorText.textColor = [UIColor grayColor];
    }
    [self.view addSubview:labelAuthorText];    
    
    labelPublished = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 145.0f, 90.0f, 20.0f)];
    
    if (labelPublished != nil)
    {
        labelPublished.backgroundColor = [UIColor orangeColor];
        labelPublished.text = @"Published:";
        labelPublished.textAlignment = UITextAlignmentRight;
        labelPublished.numberOfLines = 7;
        labelPublished.textColor = [UIColor greenColor]; 
    }
    [self.view addSubview:labelPublished];
    
    labelPublishedDate = [[UILabel alloc] initWithFrame:CGRectMake(95.0f, 145.0f, 225.0f, 20.0f)];
    
    if (labelPublishedDate != nil)
    {   
        labelPublishedDate.backgroundColor = [UIColor redColor];
        labelPublishedDate.text = @"August 24, 2010";
        labelPublishedDate.textAlignment = UITextAlignmentLeft;
        labelPublishedDate.numberOfLines = 7;
        labelPublishedDate.textColor = [UIColor blackColor]; 
    }
    [self.view addSubview:labelPublishedDate];
    
    
    labelSummary = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 170.0f, 90.0f, 20.0f)];
    
    if (labelSummary != nil)
    {   
        labelSummary.backgroundColor = [UIColor grayColor];
        labelSummary.text = @"Summary:";
        labelSummary.textAlignment = UITextAlignmentRight;
        labelSummary.numberOfLines = 7;
        labelSummary.textColor = [UIColor orangeColor];
    }
    [self.view addSubview:labelSummary];
    
    labelSummaryDetails = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 190.0f, 320.0f, 120.0f)];
    
    if (labelSummaryDetails != nil)
    {
        labelSummaryDetails.backgroundColor = [UIColor colorWithRed:0.0859 green:0.0902 blue:0.0845 alpha:1];
        labelSummaryDetails.text = @"After his surprisingly glorious honeymoon in Paris, life is almost normal for Dexter Morgan. Married life seems to agree with him. But old habits die hard... ";
        labelSummaryDetails.textAlignment = UITextAlignmentCenter;
        labelSummaryDetails.numberOfLines = 7;
        labelSummaryDetails.textColor = [UIColor yellowColor];
    }
    [self.view addSubview:labelSummaryDetails];
    
    labelItemList = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 320.0f, 120.0f, 20.0f)];
    
    if (labelItemList != nil)
    {   
        labelItemList.backgroundColor = [UIColor yellowColor];
        labelItemList.text = @"List of Items:";
        labelItemList.textAlignment = UITextAlignmentLeft;
        labelItemList.numberOfLines = 7;
        labelItemList.textColor = [UIColor colorWithRed:0.8902 green:0.0244 blue:0.0245 alpha:1];
    }
    [self.view addSubview:labelItemList];
    NSArray *itemListArray = [[NSArray alloc] initWithObjects:@"Showtime,", @"TV Show,", @"Best,", @"Selling,", @"Book", nil];
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:@""];
    
    for (int i=0; i<[itemListArray count]; i++) 
    {
        int strgLength = [mutableString length];
        NSString *list = [[NSString alloc] initWithFormat:@"%@ ", [itemListArray objectAtIndex:i]];
        [mutableString insertString:list atIndex:strgLength];
        
    }
    labelItemDetails = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 345.0f, 320.0f, 60.0f)];
    
    if (labelItemDetails != nil)
    {
        labelItemDetails.backgroundColor = [UIColor blueColor]; 
        labelItemDetails.text = mutableString;
        labelItemDetails.textAlignment = UITextAlignmentCenter;
        labelItemDetails.numberOfLines = 7;
        labelItemDetails.textColor = [UIColor whiteColor];
    }
    [self.view addSubview:labelItemDetails];    
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