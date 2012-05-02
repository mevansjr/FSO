//
//  SearchViewController.h
//
//  Created by Mark Evans on 5/2/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchViewController : UITableViewController {
    
}

@property (nonatomic, copy) NSString *query;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *buffer;
@property (nonatomic, retain) NSMutableArray *results;

@end
