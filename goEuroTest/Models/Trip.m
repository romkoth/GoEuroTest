//
//  Trip.m
//  goEuroTest
//
//  Created by Maria on 18.01.17.
//  Copyright © 2017 Roman. All rights reserved.

#import "Trip.h"
@interface Trip(){
    NSDateFormatter *_dateFormatterToHHmm;
}
@end

@implementation Trip

-(instancetype)initWithDictionary:(NSDictionary *)tripInfo{
    
    self = [super init];
    if (self) {
        self.arrivalTime = [[self dateFormatter] dateFromString:tripInfo[@"arrival_time"]];
        self.departureTime = [[self dateFormatter] dateFromString:tripInfo[@"departure_time"]];
        self.identifier = tripInfo[@"id"];
        self.numberOfStops = [tripInfo[@"number_of_stops"]integerValue];
        self.price = [tripInfo[@"price_in_euros"]floatValue];
        self.logoImagePath = tripInfo[@"provider_logo"];
        self.duration = [self.arrivalTime timeIntervalSinceDate:self.departureTime];
    }
    return self;
}

-(NSDateFormatter *)dateFormatter {
    if (!_dateFormatterToHHmm) {
        _dateFormatterToHHmm = [[NSDateFormatter alloc]init];
        [_dateFormatterToHHmm setDateFormat:@"HH:mm"];
    }
    return _dateFormatterToHHmm;
}

@end
