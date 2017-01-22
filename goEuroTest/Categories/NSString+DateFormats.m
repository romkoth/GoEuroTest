//
//  NSString+DateFormats.m
//  goEuroTest
//
//  Created by Roman Bobelyuk on 1/20/17.
//  Copyright © 2017 Roman. All rights reserved.
//

#import "NSString+DateFormats.h"
#import <objc/runtime.h>

@implementation NSString (DateFormats)


+ (NSString *)stringFromTimeIntervalWithHHmmFormat:(NSTimeInterval)interval{
    NSInteger time = (NSInteger)interval;
    NSInteger minutes = (time / 60) % 60;
    NSInteger hours = (time / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ldh", (long)hours, (long)minutes];
}

+ (NSString *)stringFromDateWithHHmmFormat:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:date];
}

+ (NSString *)stringFromNumberOfStops:(NSInteger) count{
    return count == 0? @"Direct" : [NSString stringWithFormat:@"number of stops %ld", (long)count];
}

/*
+ (NSString *)stringFromProperty:(id)property withClass:(id)customClass{
    NSString *name = nil;
    uint32_t ivarCount;
    Ivar *ivars = class_copyIvarList([customClass class], &ivarCount);
    
    if(ivars){
        for(uint32_t i=0; i<ivarCount; i++){
            Ivar ivar = ivars[i];
            name = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            if ([customClass valueForKey:name] == property){
                break;
            }
        }
        free(ivars);
    }
    return name;
}
 */
@end
