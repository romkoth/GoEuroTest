//
//  ContentLoader.h
//  goEuroTest
//
//  Created by Roman Bobelyuk on 1/19/17.
//  Copyright © 2017 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol ContentLoaderDelegate;

@interface ContentLoader : NSObject
@property (weak, nonatomic) id<ContentLoaderDelegate> delegate;

-(instancetype)initWithCacheConfigurations;

-(void) loadContentFrom:(NSString *) URLString;
-(void) loadImage:(NSString *)imagePath withSize:(NSInteger) imageSize withCompletionHandler:(void(^)(UIImage* loadedImage)) handler;

@end

@protocol ContentLoaderDelegate <NSObject>
-(void) didFinishLoadTrips:(NSArray *) tripsArray;

@end
