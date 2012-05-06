//
//  SearchViewController.h
//
//  Created by Mark Evans on 5/2/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"


@interface SearchViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> 
{
    NSString *urlToGet;
    IBOutlet UIWebView *webView;
}

@property(nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, copy) NSString *query;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *buffer;
@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, copy) NSString *urlToGet;

@end
