//
//  SortingManager.m
//  goEuroTest
//
//  Created by Maria on 20.01.17.
//  Copyright © 2017 Roman. All rights reserved.
//

#import "SortingManager.h"
@interface SortingManager()

@end
@implementation SortingManager

+ (NSArray *) sortArray:(NSArray *) array ByKey:(NSString *)propertyKey ascending:(BOOL) ascending{
    
    NSSortDescriptor* descriptor = [[NSSortDescriptor alloc] initWithKey:propertyKey ascending:ascending];
    return [array sortedArrayUsingDescriptors:@[descriptor]];
}

@end
