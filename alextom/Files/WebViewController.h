//
//  WebViewController.h
//  repolist
//
//  Created by Mark Evans on 5/4/12.
//  Copyright (c) 2012 MdTA / Full Sail University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"

@interface WebViewController : UIViewController <UIWebViewDelegate> {
    
    NSString *urlToGet;
    IBOutlet UIWebView *webView;
    NSDictionary *repo;
}

@property(nonatomic, retain) IBOutlet UIWebView *webView;
@property(nonatomic, retain) NSString *urlToGet;

@end
