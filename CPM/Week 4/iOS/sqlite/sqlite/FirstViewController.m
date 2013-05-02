//
//  FirstViewController.m
//  sqlite
//
//  Created by Mark Evans on 4/15/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Vehicle.h"
#import "Reachability.h"
#import "AddViewController.h"
#import "DetailsViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize theTableView, theArray, sourceArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"MdTA", @"MdTA");
    }
    return self;
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

- (void)updateLocalFromSource
{
    Vehicle *v1 = [[Vehicle alloc]init];
    sourceArray = [[NSMutableArray alloc]initWithArray:v1.getArrayFromSource];
    
    if (sourceArray != nil)
    {
        if (theArray.count == 0)
        {
            for (int i = 0; i < [sourceArray count]; i++)
            {
                PFObject *obj = [sourceArray objectAtIndex:i];
                NSString *cc = [obj objectForKey:@"cc"];
                NSString *ct = [obj objectForKey:@"ct"];
                NSString *cv = [obj objectForKey:@"cv"];
                NSString *rp = [obj objectForKey:@"rp"];
                NSString *rs = [obj objectForKey:@"rs"];
                NSString *parseId = obj.objectId;
                NSString *dateInstalled = [obj objectForKey:@"date"];
                
                NSDateFormatter* f = [[NSDateFormatter alloc] init];
                [f setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
                NSString* dateMod = [f stringFromDate:[NSDate date]];
                
                Vehicle *v = [[Vehicle alloc]init];
                [v setCar_call:cc];
                [v setCar_tag:ct];
                [v setCar_vin:cv];
                [v setRadio_propertytag:rp];
                [v setRadio_serial:rs];
                [v setInstallDate:dateInstalled];
                [v setDateModified:dateMod];
                [v setParseId:parseId];
                [theArray addObject:v];
            }
        }
    } else {
        sourceArray = [[NSMutableArray alloc]init];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    deleteArray = [[NSMutableArray alloc]init];
    [theTableView reloadData];
    theArray = [[NSMutableArray alloc]init];
    [self createOrOpenDB];
    [self syncParseByModDate];
    [self clear];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar == theSearchBar)
    {
        sqlite3_stmt *statement;
        if (sqlite3_open([dbPathString UTF8String], &theDB)==SQLITE_OK) {
            [theArray removeAllObjects];
            
            if (theSegmentedControl.selectedSegmentIndex == 0)
            {
                NSLog(@"tag 0 - CALL");
                sql = [[NSString alloc] initWithFormat:@"SELECT * FROM Vehicles WHERE call = '%@';", searchBar.text];
            }
            else if (theSegmentedControl.selectedSegmentIndex == 1)
            {
                NSLog(@"tag 1 - VIN");
                sql = [[NSString alloc] initWithFormat:@"SELECT * FROM Vehicles WHERE carvin = '%@';", searchBar.text];
            }
            else if (theSegmentedControl.selectedSegmentIndex == 2)
            {
                NSLog(@"tag 2 - TAG");
                sql = [[NSString alloc] initWithFormat:@"SELECT * FROM Vehicles WHERE cartag = '%@';", searchBar.text];
            }
            else if (theSegmentedControl.selectedSegmentIndex == 3)
            {
                NSLog(@"tag 3 - ALL");
            }

            const char *search_query = [sql UTF8String];
            
            if (sqlite3_prepare(theDB, search_query, -1, &statement, NULL)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    NSString *call = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSString *cartag = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                    NSString *carvin = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                    NSString *radioproperty = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                    NSString *radioserial = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                    NSString *installDate = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                    NSString *dateModified = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                    NSString *parseId = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                    
                    Vehicle *v = [[Vehicle alloc]init];
                    [v setCar_call:call];
                    [v setCar_tag:cartag];
                    [v setCar_vin:carvin];
                    [v setRadio_propertytag:radioproperty];
                    [v setRadio_serial:radioserial];
                    [v setInstallDate:installDate];
                    [v setDateModified:dateModified];
                    [v setParseId:parseId];
                    [theArray addObject:v];
                }
                [theTableView reloadData];
                if (theSegmentedControl.selectedSegmentIndex == 0)
                {
                    NSLog(@"tag 0 - CALL");
                    if (theArray.count == 0)
                    {
                        NSString *s = [[NSString alloc]initWithFormat:@"CALL: No Results for (%@)",searchBar.text];
                        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Alert" message:s delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
                        [a show];
                    }
                }
                else if (theSegmentedControl.selectedSegmentIndex == 1)
                {
                    NSLog(@"tag 1 - VIN");
                    if (theArray.count == 0)
                    {
                        NSString *s = [[NSString alloc]initWithFormat:@"VIN: No Results for (%@)",searchBar.text];
                        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Alert" message:s delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
                        [a show];
                    }
                }
                else if (theSegmentedControl.selectedSegmentIndex == 2)
                {
                    NSLog(@"tag 2 - TAG");
                    if (theArray.count == 0)
                    {
                        NSString *s = [[NSString alloc]initWithFormat:@"TAG: No Results for (%@)",searchBar.text];
                        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Alert" message:s delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
                        [a show];
                    }
                }
                else if (theSegmentedControl.selectedSegmentIndex == 3)
                {
                    NSLog(@"tag 3 - SHOW ALL");
                    if (theArray.count == 0)
                    {
                        NSString *s = [[NSString alloc]initWithFormat:@"Show ALL: No Results for (%@)",searchBar.text];
                        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Alert" message:s delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
                        [a show];
                    }
                }
            } else {
                NSLog(@"issue");
            }
        }
        [theTableView reloadData];
        
    }
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:TRUE];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}   


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:FALSE];
    [searchBar resignFirstResponder];
}

- (void)showAll
{
    sqlite3_stmt *statement;
    if (sqlite3_open([dbPathString UTF8String], &theDB)==SQLITE_OK) {
        [theArray removeAllObjects];
        
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM Vehicles"];
        const char* query_sql = [querySql UTF8String];
        
        if (sqlite3_prepare(theDB, query_sql, -1, &statement, NULL)==SQLITE_OK) {
            while (sqlite3_step(statement)==SQLITE_ROW) {
                NSString *call = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *cartag = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *carvin = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *radioproperty = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                NSString *radioserial = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                NSString *installDate = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                NSString *dateModified = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                NSString *parseId = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                
                Vehicle *v = [[Vehicle alloc]init];
                [v setCar_call:call];
                [v setCar_tag:cartag];
                [v setCar_vin:carvin];
                [v setRadio_propertytag:radioproperty];
                [v setRadio_serial:radioserial];
                [v setInstallDate:installDate];
                [v setDateModified:dateModified];
                [v setParseId:parseId];
                [theArray addObject:v];
            }
            [theTableView reloadData];
        } else {
            NSLog(@"issue");
        }
    }
    [theTableView reloadData];
}

- (void)clear
{
    [theArray removeAllObjects];
    [theTableView reloadData];
}

- (void)addBtn
{
    AddViewController *addView = [[AddViewController alloc]initWithNibName:@"AddViewController" bundle:nil];
    [self presentViewController:addView animated:TRUE completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    //Sync DB on timer - 90 seconds
    timer = [NSTimer scheduledTimerWithTimeInterval:90.0 target:self selector:@selector(syncParseByModDate) userInfo:nil repeats:YES];
    [timer self];
    
    //Nav Bar Stuff
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtn)];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clear)];
	[self.navigationItem setRightBarButtonItem:rightBtn];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    //Set Control
    [theSegmentedControl addTarget:self action:@selector(selectControl:) forControlEvents:UIControlEventValueChanged];
}

- (NSUInteger)selectControl:(UISegmentedControl *)control {
    control = theSegmentedControl;
    if (control.selectedSegmentIndex == 0) {
        [self clear];
        return 0;
    }
    else if (control.selectedSegmentIndex == 1)
    {
        [self clear];
        return 1;
    }
    else if (control.selectedSegmentIndex == 2)
    {
        [self clear];
        return 2;
    }
    else if (control.selectedSegmentIndex == 3)
    {
        [self showAll];
        return 3;
    }
    return 0;
}

- (void)viewDidDisappear:(BOOL)animated
{
    theSearchBar.text = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSDate dateWithTimeIntervalSinceNow:-180] forKey:@"date"];
    [defaults synchronize];
}

- (void)viewDidUnload
{
    [timer invalidate];
    timer = nil;
}

- (void)createOrOpenDB
{
    [self updateLocalFromSource];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    
    dbPathString = [docPath stringByAppendingPathComponent:@"MdTA.db"];
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.dbpath = dbPathString;
    
    char *error;
    const char *dbPath = [dbPathString UTF8String];
    if (![fileManager fileExistsAtPath:dbPathString]) {
        
        //CREATES DB
        if (sqlite3_open(dbPath, &theDB)==SQLITE_OK) {
            const char *sql_stmt = "CREATE TABLE Vehicles (id INTEGER PRIMARY KEY, call TEXT, cartag TEXT, carvin TEXT, radioproperty TEXT, radioserial TEXT, dateinstalled TEXT, datemod TEXT, parseId TEXT);";
            sqlite3_exec(theDB, sql_stmt, NULL, NULL, &error);
            if (theArray.count != 0)
            {
                for (int i = 0; i < [theArray count]; i++)
                {
                    Vehicle *v = [theArray objectAtIndex:i];
                    NSString *sql_stmt_insert_str = [[NSString alloc]initWithFormat:@"INSERT INTO Vehicles (call, cartag, carvin, radioproperty, radioserial, dateinstalled, datemod, parseId) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@');",v.car_call, v.car_tag, v.car_vin, v.radio_propertytag, v.radio_serial, v.installDate, v.dateModified, v.parseId];
                    const char *sql_stmt_insert = [sql_stmt_insert_str UTF8String];
                    sqlite3_exec(theDB, sql_stmt_insert, NULL, NULL, &error);
                }
            }
            sqlite3_close(theDB);
        }
    } else {
        //DB EXIST
        NSLog(@"Database exist!");
        
        //DELETE LOGIC
        sqlite3_stmt *statement;
        if (sqlite3_open([dbPathString UTF8String], &theDB)==SQLITE_OK) {
            [deleteArray removeAllObjects];
            
            NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM Vehicles"];
            const char* query_sql = [querySql UTF8String];
            
            if (sqlite3_prepare(theDB, query_sql, -1, &statement, NULL)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    NSString *call = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSString *cartag = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                    NSString *carvin = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                    NSString *radioproperty = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                    NSString *radioserial = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                    NSString *installDate = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                    NSString *dateModified = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                    NSString *parseId = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                    
                    Vehicle *v = [[Vehicle alloc]init];
                    [v setCar_call:call];
                    [v setCar_tag:cartag];
                    [v setCar_vin:carvin];
                    [v setRadio_propertytag:radioproperty];
                    [v setRadio_serial:radioserial];
                    [v setInstallDate:installDate];
                    [v setDateModified:dateModified];
                    [v setParseId:parseId];
                    [deleteArray addObject:v];
                }
            } else {
                NSLog(@"issue");
            }
        }
    }
}

-(void)syncDelete
{
    NSLog(@"deleteArray count: %i", deleteArray.count);
    if ([self connected])
    {
        PFQuery *query = [PFQuery queryWithClassName:@"deleteVehicle"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %d object(s) from the Delete Class", objects.count);
                
                for (int i = 0; i < [objects count]; i++)
                {
                    PFObject *obj = [objects objectAtIndex:i];
                    NSDate *parseDate = [obj updatedAt];
                    NSString *dateMod = [NSDateFormatter localizedStringFromDate:parseDate
                                                                       dateStyle:NSDateFormatterMediumStyle
                                                                       timeStyle:NSDateFormatterShortStyle];
                    NSLog(@"parse date: %@", dateMod);
                    NSString *parseCall = [obj objectForKey:@"cc"];
                    NSString *parseTag = [obj objectForKey:@"ct"];
                    NSString *parseVin = [obj objectForKey:@"cv"];
                    NSString *parseProperty = [obj objectForKey:@"rp"];
                    NSString *parseSerial = [obj objectForKey:@"rs"];
                    NSString *parseInstallDate = [obj objectForKey:@"date"];
                    for (int i = 0; i < [deleteArray count]; i++)
                    {
                        Vehicle *v = [deleteArray objectAtIndex:i];
                        NSString *call = v.car_call;
                        NSString *dm = v.dateModified;
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat: @"yyyy-MM-dd hh:mm:ss"];
                        NSDate * localDate = [dateFormatter dateFromString:dm];
                        if ([call isEqualToString:parseCall]){
                            if (parseDate > localDate)
                            {
                                NSString *dateMod2 = [NSDateFormatter localizedStringFromDate:localDate
                                                                                   dateStyle:NSDateFormatterMediumStyle
                                                                                   timeStyle:NSDateFormatterShortStyle];
                                NSLog(@"local date: %@",dateMod2);
                                NSLog(@"Parse is date is greater - will delete from SQL DB");
                                AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                                dbPathString = appDelegate.dbpath;
                                if (sqlite3_open([dbPathString UTF8String], &theDB)==SQLITE_OK)
                                {
                                    char *error;
                                    NSString *deleteStr = [[NSString alloc]initWithFormat:@"Delete from Vehicles where call is '%s'", [call UTF8String]];
                                    if (sqlite3_exec(theDB, [deleteStr UTF8String], NULL, NULL, &error)==SQLITE_OK)
                                    {
                                        NSLog(@"Vehicle deleted");
                                    } else {
                                        NSLog(@"Error exec delete");
                                    }
                                } else {
                                    NSLog(@"Error open delete");
                                }
                                PFQuery *query = [PFQuery queryWithClassName:@"newVehicle"];
                                [query  whereKey:@"cc" equalTo:call];
                                [query getFirstObjectInBackgroundWithBlock:^(PFObject *obj, NSError *error) {
                                    if (!error) {
                                        // The get request succeeded. Log the score
                                        [obj deleteInBackground];
                                    } else {
                                        // Log details of our failure
                                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                                    }
                                }];
                                NSString *msg = [[NSString alloc]initWithFormat:@"Vehicle %@ has been deleted.", call];
                                UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Alert" message:msg delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
                                [a show];
                            } else if (localDate > parseDate) {
                                NSLog(@"Local is date is greater - will add to Parse DB");
                                PFObject *obj = [PFObject objectWithClassName:@"newVehicle"];
                                [obj setObject:parseCall forKey:@"cc"];
                                [obj setObject:parseTag forKey:@"ct"];
                                [obj setObject:parseVin forKey:@"cv"];
                                [obj setObject:parseProperty forKey:@"rp"];
                                [obj setObject:parseSerial forKey:@"rs"];
                                [obj setObject:parseInstallDate forKey:@"date"];
                                [obj saveInBackground];
                                NSString *msg = [[NSString alloc]initWithFormat:@"Vehicle %@ is in SYNC with Database.", parseCall];
                                UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Alert" message:msg delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
                                [a show];
                            }
                        }
                    }
                }
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    } else {
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Check Connection?" message:@"Please Connect to the internet to SYNC data." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
        [a show];
    }
}

-(void)syncParseByModDate
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    dbPathString = appDelegate.dbpath;
    if (sqlite3_open([dbPathString UTF8String], &theDB)==SQLITE_OK)
    {
        if ([self connected])
        {
            [self syncDelete];
            NSString *dateMod = [NSDateFormatter localizedStringFromDate:appDelegate.lastOpen
                                                           dateStyle:NSDateFormatterMediumStyle
                                                           timeStyle:NSDateFormatterShortStyle];
            PFQuery *query = [PFQuery queryWithClassName:@"newVehicle"];
            
            [query whereKey:@"updatedAt" greaterThan:appDelegate.lastOpen];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    NSLog(@"Successfully retrieved %d object(s) from %@", objects.count, dateMod);
                    for (int i = 0; i < [objects count]; i++)
                    {
                        PFObject *obj = [objects objectAtIndex:i];
                        NSString *cc = [obj objectForKey:@"cc"];
                        NSString *ct = [obj objectForKey:@"ct"];
                        NSString *cv = [obj objectForKey:@"cv"];
                        NSString *rp = [obj objectForKey:@"rp"];
                        NSString *rs = [obj objectForKey:@"rs"];
                        NSString *parseId = obj.objectId;
                        NSString *dateInstalled = [obj objectForKey:@"date"];
                        
                        NSString *date = [[NSString alloc]initWithFormat:@"%@",[NSDate date]];
                        
                        Vehicle *v = [[Vehicle alloc]init];
                        [v setCar_call:cc];
                        [v setCar_tag:ct];
                        [v setCar_vin:cv];
                        [v setRadio_propertytag:rp];
                        [v setRadio_serial:rs];
                        [v setInstallDate:dateInstalled];
                        [v setDateModified:date];
                        [v setParseId:parseId];
                        
                        NSLog(@"From Parse: %@", v.car_call);
                        
                        //CHECK SQL DB
                        sqlite3_stmt *statement;
                        if (sqlite3_open([dbPathString UTF8String], &theDB)==SQLITE_OK) {
                
                            NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM Vehicles WHERE call IN ('%@')",v.car_call];
                            const char* query_sql = [querySql UTF8String];
                            
                            if (sqlite3_prepare(theDB, query_sql, -1, &statement, NULL)==SQLITE_OK) {
                                arr = [[NSMutableArray alloc]init];
                                while (sqlite3_step(statement)==SQLITE_ROW) {
                                    [arr removeAllObjects];
                                    NSString *call = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                                    NSString *cartag = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                                    NSString *carvin = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                                    NSString *radioproperty = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                                    NSString *radioserial = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                                    NSString *installDate = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                                    NSString *dateModified = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                                    NSString *parseId = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                                    
                                    Vehicle *vv = [[Vehicle alloc]init];
                                    [vv setCar_call:call];
                                    [vv setCar_tag:cartag];
                                    [vv setCar_vin:carvin];
                                    [vv setRadio_propertytag:radioproperty];
                                    [vv setRadio_serial:radioserial];
                                    [vv setInstallDate:installDate];
                                    [vv setDateModified:dateModified];
                                    [vv setParseId:parseId];
                                    [arr addObject:vv];
                                }
                                NSLog(@"1 means the entry is already in the DB -- 0 means this entry is new");
                                NSLog(@"Count: %i", arr.count);
                                //IF arr equals 0 then the object is new and will save to SQL DB .. IF arr is greater then 1 then the object is already in SQL DB so it will be updated.
                                if (arr.count == 0)
                                {
                                    char *error;
                                    NSString *sql_stmt_insert_str = [[NSString alloc]initWithFormat:@"INSERT INTO Vehicles (call, cartag, carvin, radioproperty, radioserial, dateinstalled, datemod, parseId) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@');",v.car_call, v.car_tag, v.car_vin, v.radio_propertytag, v.radio_serial, v.installDate, v.dateModified, v.parseId];
                                    const char *sql_stmt_insert = [sql_stmt_insert_str UTF8String];
                                    if (sqlite3_exec(theDB, sql_stmt_insert, NULL, NULL, &error)==SQLITE_OK)
                                    {
                                        NSLog(@"Vehicle Added");
                                    }
                                } else {
                                    PFQuery *query = [PFQuery queryWithClassName:@"newVehicle"];
                                    [query whereKey:@"cc" equalTo:v.car_call];
                                    [query getObjectInBackgroundWithId:v.parseId block:^(PFObject *obj, NSError *error) {
                                        if (!obj) {
                                            NSLog(@"The request failed.");
                                            UIAlertView *prompt = [[UIAlertView alloc]initWithTitle:@"SYNC ISSUE" message:@"It appears this Vehicle is not in SYNC with the Database. Would you like to save this Vehicle as a new entry?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO", @"YES", nil];
                                            pCC = v.car_call;
                                            pCT = v.car_tag;
                                            pCV = v.car_vin;
                                            pRP = v.radio_propertytag;
                                            pRS = v.radio_serial;
                                            pDATE = v.installDate;
                                            pPARSEID = v.parseId;
                                            [prompt show];
                                        } else {
                                            // The find succeeded.
                                            NSLog(@"Successfully retrieved the object.");
                                            
                                            AddViewController *addView = [[AddViewController alloc]initWithNibName:@"AddViewController" bundle:nil];
                                            [addView setCcStr:v.car_call];
                                            [addView setCtStr:v.car_tag];
                                            [addView setCvStr:v.car_vin];
                                            [addView setRpStr:v.radio_propertytag];
                                            [addView setRsStr:v.radio_serial];
                                            
                                            char *error;
                                            NSString *localDate = [[NSString alloc]initWithFormat:@"%@",[NSDate date]];
                                            NSString *updateStr = [[NSString alloc]initWithFormat:@"UPDATE Vehicles SET call='%@', cartag='%@', carvin='%@', radioproperty='%@', radioserial='%@', dateinstalled='%@', datemod='%@', parseId='%@' WHERE call='%@';", v.car_call, v.car_tag, v.car_vin, v.radio_propertytag, v.radio_serial, v.installDate, localDate, v.parseId, v.car_call];
                                            const char *sql_stmt_update = [updateStr UTF8String];
        
                                            if (sqlite3_exec(theDB, sql_stmt_update, NULL, NULL, &error)==SQLITE_OK)
                                            {
                                                NSLog(@"Vehicle updated");
                                                 NSLog(@"%@",updateStr);
                                            }
                                        }
                                    }];
                                }
                            } else {
                                NSLog(@"issue");
                            }
                        }                        
                    }
                    
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
            
        } else {
            UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Check Connection?" message:@"Please Connect to the internet to SYNC data." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
            [a show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NO
    if (buttonIndex == 0)
    {
        [self viewWillAppear:true];
    }
    //YES
    else if (buttonIndex == 1)
    {
        if ([self connected])
        {
            PFObject *obj = [PFObject objectWithClassName:@"newVehicle"];
            [obj setObject:pCC forKey:@"cc"];
            [obj setObject:pCT forKey:@"ct"];
            [obj setObject:pCV forKey:@"cv"];
            [obj setObject:pRP forKey:@"rp"];
            [obj setObject:pRS forKey:@"rs"];
            [obj setObject:pDATE forKey:@"date"];
            [obj saveInBackground];
        }
    }
}  

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [theArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Vehicle *v = [theArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = v.car_call.uppercaseString;
    cell.detailTextLabel.text = v.car_vin.uppercaseString;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Vehicle *v = [theArray objectAtIndex:indexPath.row];
    NSString *call = v.car_call;
    NSString *cartag = v.car_tag;
    NSString *carvin = v.car_vin;
    NSString *radioproperty = v.radio_propertytag;
    NSString *radioserial = v.radio_serial;
    NSString *installDate = v.installDate;
    NSString *dateMod = v.dateModified;
    NSString *parseId = v.parseId;
    
    DetailsViewController *detailsView = [[DetailsViewController alloc]initWithNibName:@"DetailsViewController" bundle:nil];
    [detailsView setCcStr:call];
    [detailsView setCtStr:cartag];
    [detailsView setCvStr:carvin];
    [detailsView setRpStr:radioproperty];
    [detailsView setRsStr:radioserial];
    [detailsView setInstalldateStr:installDate];
    [detailsView setDatemodStr:dateMod];
    [detailsView setParseIdStr:parseId];
    [self presentViewController:detailsView animated:TRUE completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
