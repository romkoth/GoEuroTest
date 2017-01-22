//
//  NSString+DateFormats.h
//  goEuroTest
//
//  Created by Roman Bobelyuk on 1/20/17.
//  Copyright © 2017 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DateFormats)

+ (NSString *)stringFromTimeIntervalWithHHmmFormat:(NSTimeInterval)interval;
+ (NSString *)stringFromDateWithHHmmFormat:(NSDate *)date;
+ (NSString *)stringFromNumberOfStops:(NSInteger) count;

//+ (NSString *)stringFromProperty:(id)property withClass:(id)customClass;


@end
