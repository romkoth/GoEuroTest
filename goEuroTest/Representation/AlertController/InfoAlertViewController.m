//
//  InfoAlertViewController.m
//  goEuroTest
//
//  Created by Roman Bobelyuk on 1/20/17.
//  Copyright © 2017 Roman. All rights reserved.
//

#import "InfoAlertViewController.h"

@interface InfoAlertViewController ()

@end

@implementation InfoAlertViewController

+ (InfoAlertViewController *)alertControllerWithInfo:(NSString *) string{
    InfoAlertViewController* alertVC = [InfoAlertViewController alertControllerWithTitle:@"Sorry:(" message:string preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil]];
    return alertVC;
}

@end
