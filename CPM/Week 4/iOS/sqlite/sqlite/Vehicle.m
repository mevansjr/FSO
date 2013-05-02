//
//  Vehicle.m
//  sqlite
//
//  Created by Mark Evans on 4/23/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import "Vehicle.h"
#import <Parse/Parse.h>

@implementation Vehicle
@synthesize sourceArray, car_call, car_vin, car_tag, radio_serial, radio_propertytag, dateModified, installDate, parseId;

- (int)getCountFromSource
{
    PFQuery *query = [PFQuery queryWithClassName:@"newVehicle"];
    sourceArray = [[NSMutableArray alloc]initWithArray:[query findObjects]];
    return sourceArray.count;
}

- (NSMutableArray*)getArrayFromSource
{
    PFQuery *query = [PFQuery queryWithClassName:@"newVehicle"];
    sourceArray = [[NSMutableArray alloc]initWithArray:[query findObjects]];
    return sourceArray;
}

@end
