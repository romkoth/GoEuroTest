//
//  SortingManager.h
//  goEuroTest
//
//  Created by Maria on 20.01.17.
//  Copyright © 2017 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortingManager : NSObject

+ (NSArray *)sortArray:(NSArray *) array ByKey:(NSString *)propertyKey ascending:(BOOL) ascending;

@end
