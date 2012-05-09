//
//  WebViewController.m
//  repolist
//
//  Created by Mark Evans on 5/4/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import "WebViewController.h"
#import "SearchViewController.h"

@implementation WebViewController

@synthesize webView;
@synthesize urlToGet;

- (void)dealloc
{
    [webView release];
    [urlToGet release];
    [super dealloc];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.title = @"GitHub Project";
    
    NSString *fullURL = urlToGet;
    NSLog(@"%@", fullURL);
    NSURL *url = [NSURL URLWithString:fullURL]; 
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url]; 
    [webView loadRequest:requestObj];
}

@end
