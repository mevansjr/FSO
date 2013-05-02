//
//  Vehicle.h
//  sqlite
//
//  Created by Mark Evans on 4/23/13.
//  Copyright (c) 2013 Mark Evans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject

@property(strong)NSString *car_call;
@property(strong)NSString *car_tag;
@property(strong)NSString *car_vin;
@property(strong)NSString *radio_propertytag;
@property(strong)NSString *radio_serial;
@property(strong)NSMutableArray *sourceArray;
@property(strong)NSString *installDate;
@property(strong)NSString *dateModified;
@property(strong)NSString *parseId;

- (int)getCountFromSource;
- (NSMutableArray*)getArrayFromSource;

@end
