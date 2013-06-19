//
//  LeaderBoardViewController.m
//  game
//
//  Created by Mark Evans on 3/27/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "LeaderBoardViewController.h"
#import "GameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "Reachability.h"
#import "CustomCell.h"
#import "UserProfileViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "RNBlurModalView.h"
#import "UIBorderLabel.h"

@interface LeaderBoardViewController ()

@end

@implementation LeaderBoardViewController
@synthesize scoresTable, textPull, textRelease, textLoading, refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner;

#define REFRESH_HEADER_HEIGHT 52.0f

-(void)setupStrings
{
    textPull = @"Pull down to refresh...";
    textRelease = @"Release to refresh...";
    textLoading = @"Loading...";
}

- (void)addPullToRefreshHeader
{
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:13.0];
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    
    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                    27, 44);
    
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    refreshSpinner.hidesWhenStopped = YES;
    
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:refreshArrow];
    [refreshHeaderView addSubview:refreshSpinner];
    [scoresTable addSubview:refreshHeaderView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            scoresTable.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            scoresTable.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.25 animations:^{
            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
                // User is scrolling above the header
                refreshLabel.text = self.textRelease;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } else {
                // User is scrolling somewhere within the header
                refreshLabel.text = self.textPull;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
        }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self startLoading];
    }
}

- (void)startLoading {
    isLoading = YES;
    
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        scoresTable.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        refreshLabel.text = self.textLoading;
        refreshArrow.hidden = YES;
        [refreshSpinner startAnimating];
    }];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading {
    isLoading = NO;
    
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        scoresTable.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}

- (void)stopLoadingComplete {
    // Reset the header
    refreshLabel.text = self.textPull;
    refreshArrow.hidden = NO;
    [refreshSpinner stopAnimating];
}

-(IBAction)closeView:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{

    [self setupStrings];
    [self setTitle:@"Game"];
    scoresArray = [[NSArray alloc]init];
    if(![self connected])
    {
        RNBlurModalView *modal;
        modal = [[RNBlurModalView alloc] initWithTitle:@"Alert" message:@"Internet Connection Lost. Can NOT save score to server."];
        [modal show];
        
        NSLog(@"Not Connected to internet");
    } else {
        @try {
            PFQuery *query = [PFQuery queryWithClassName:@"SavedScore"];
            [query addDescendingOrder:@"score"];
            [query setLimit:10];
            scoresArray = [query findObjects];
            [scoresTable reloadData];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
    }
}

-(void)refresh
{
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
    @try {
        PFQuery *query = [PFQuery queryWithClassName:@"SavedScore"];
        [query addDescendingOrder:@"score"];
        [query setLimit:10];
        scoresArray = [query findObjects];
        [scoresTable reloadData];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addPullToRefreshHeader];
    
    thenavbar.delegate = self;
    
    //Set Custom NavBar
    UIImage *image = [UIImage imageNamed:@"navbg.png"];
    [[UINavigationBar appearance]setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"shadow.png"]];
    
    [closebtn setShowsTouchWhenHighlighted:YES];
    
    UIImage *headerImage = [UIImage imageNamed:@"logoleaderboard.png"];
    navItem.titleView = [[UIImageView alloc] initWithImage:headerImage];
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                UITextAttributeTextColor: [UIColor whiteColor],
                          UITextAttributeTextShadowColor: [UIColor blackColor],
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                     UITextAttributeFont: [UIFont fontWithName:@"MarkerFelt-Wide" size:20.0f]
     }];
}

-(void)viewDidUnload
{
    AudioServicesDisposeSystemSoundID(end);
}

-(IBAction)start:(id)sender
{
    GameViewController *gameView = [[GameViewController alloc]initWithNibName:@"GameViewController" bundle:nil];
    [self presentViewController:gameView animated:true completion:nil];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section == 0)
//    {
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
//        
//        UIBorderLabel *headerLabel= [[UIBorderLabel alloc]initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height)];
//        headerLabel.topInset = 10;
//        headerLabel.leftInset = 15;
//        headerLabel.bottomInset = 12;
//        headerLabel.rightInset = 15;
//        headerLabel.text = @"Top 10 Scores";
//        headerLabel.textColor = [UIColor blackColor];
//        headerLabel.shadowOffset = CGSizeMake(0, -1);
//        headerLabel.shadowColor = [UIColor whiteColor];
//        headerLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:16];
//        headerLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"headerbg.png"]];
//        [headerView addSubview:headerLabel];
//        
//        return headerView;
//    }
//    
//    return nil;
//}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Top 10 Scores";
    }
    return nil;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return scoresArray.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
//    if (cell != nil)
//    {
//        @try {
//            PFObject *obj = [scoresArray objectAtIndex:indexPath.row];
//            NSString *detail = [obj objectForKey:@"playerName"];
//            NSNumber *status = [obj objectForKey:@"score"];
//            NSString *d = [[NSString alloc]initWithFormat:@"%d -  %@",indexPath.row+1,detail];
//            
//            if (detail != nil)
//            {
//                cell.textLabel.text = d;
//            }
//            if (status != nil)
//            {
//                cell.detailTextLabel.text = status.stringValue;
//            }
//        }
//        @catch (NSException *exception) {
//            NSLog(@"%@",exception);
//        }
//    }
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
    CustomCell *cell = (CustomCell *)[nib objectAtIndex:0];
    if (cell != nil)
    {
        @try {
            PFObject *obj = [scoresArray objectAtIndex:indexPath.row];
            NSString *detail = [obj objectForKey:@"playerName"];
            NSNumber *status = [obj objectForKey:@"score"];
            NSString *d = [[NSString alloc]initWithFormat:@"%d -  %@",indexPath.row+1,detail];
            
            if (detail != nil)
            {
                cell.sourceLabel.text = d;
            }
            if (status != nil)
            {
                cell.statusLabel.text = status.stringValue;
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
