//
//  ContentLoader.m
//  goEuroTest
//
//  Created by Roman Bobelyuk on 1/19/17.
//  Copyright © 2017 Roman. All rights reserved.
//

#import "ContentLoader.h"
#import "Trip.h"
@interface ContentLoader()<NSURLSessionTaskDelegate>
@property (strong, nonatomic) NSURLSession* session;

@end
@implementation ContentLoader

-(instancetype)initWithCacheConfigurations{
    self = [super init];
    if (self) {
        self.session = [NSURLSession sessionWithConfiguration:[self sessionConfigurations]];
    }
    return self;
}

#pragma mark - dataLoading
-(void) loadContentFrom:(NSString *) URLString{
    
    NSURLRequest* urlRequestForTripInfo = [self cachedURLRequestFromString:URLString];
    NSCachedURLResponse* cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:urlRequestForTripInfo];
    
    if (cachedResponse) {
        [self loadArrayFromCache:cachedResponse];
        return;
    }
    __weak ContentLoader* weakSelf = self;
    [[self.session dataTaskWithRequest:urlRequestForTripInfo
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                if (!error) {
                    NSError *jsonError;
                    NSArray *jsonResponse = (NSArray*)[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                    
                    if (jsonError) {
                        NSLog(@"error parsing JSON");
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf.delegate didFinishLoadTrips:jsonResponse];
                        });
                    }
                } else {
                    NSLog(@"error : %@", error.description);
                }
            }] resume];
}

-(void) loadImage:(NSString *)imagePath withSize:(NSInteger) imageSize
                                        withCompletionHandler:(void(^)(UIImage* loadedImage)) handler{
    
    NSString *finalURLString =  [imagePath stringByReplacingOccurrencesOfString:@"{size}" withString:[NSString stringWithFormat:@"%ld", (long)imageSize]];
    NSURLRequest* urlRequestForImage = [self cachedURLRequestFromString:finalURLString];
    NSCachedURLResponse* cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:urlRequestForImage];
    
    if (cachedResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            handler([UIImage imageWithData:cachedResponse.data]);
            return;
        });
    }
    [[self.session dataTaskWithRequest:urlRequestForImage
                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (!error){
            UIImage* loadedImage = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(loadedImage);
            });
        }else{
            NSLog(@"error load image %@",error.localizedDescription);
        }
    }]resume];
}

#pragma mark - helpers
- (NSURLSessionConfiguration*) sessionConfigurations{
       NSURLSessionConfiguration* sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.URLCache = [NSURLCache sharedURLCache];
    sessionConfiguration.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
    
    return sessionConfiguration;
}

- (NSURLRequest *) cachedURLRequestFromString:(NSString *) urlString{
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLRequest* urlRequestForTripInfo = [NSURLRequest requestWithURL:[NSURL URLWithString:encodedUrlAsString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    return urlRequestForTripInfo;
}

- (void) loadArrayFromCache:(NSCachedURLResponse*) cachedResponse{
    NSError *error;
    NSArray *jsonResponse = (NSArray*)[NSJSONSerialization JSONObjectWithData:cachedResponse.data options:0 error:&error];
    if (!error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didFinishLoadTrips:jsonResponse];
        });
    }else{
        NSLog(@"loadFromCache error %@",error.description);
    }
}
@end

