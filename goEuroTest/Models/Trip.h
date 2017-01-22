//
//  Trip.h
//  goEuroTest
//
//  Created by Maria on 18.01.17.
//  Copyright © 2017 Roman. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TripType) {
    TripTypeByTrain,
    TripTypeByBus,
    TripTypeByPlane,
};

@interface Trip : NSObject

@property (strong, nonatomic) NSDate* departureTime;
@property (strong, nonatomic) NSDate* arrivalTime;
@property (strong, nonatomic) NSString* identifier;
@property (strong, nonatomic) NSString* logoImagePath;
@property (assign, nonatomic) NSInteger numberOfStops;
@property (assign, nonatomic) NSTimeInterval duration;
@property (assign, nonatomic) TripType tripType;
@property (assign, nonatomic) float price;

-(instancetype)initWithDictionary:(NSDictionary *)tripInfo;


@end

