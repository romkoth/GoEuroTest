//
//  TripDescriptionCellTableViewCell.h
//  goEuroTest
//
//  Created by Maria on 18.01.17.
//  Copyright © 2017 Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogoImageView.h"

@interface TripDescriptionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet LogoImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfStopsLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalTimeLabel;

@end
