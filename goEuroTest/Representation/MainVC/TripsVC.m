//
//  ViewController.m
//  goEuroTest
//
//  Created by Roman on 18.01.17.
//  Copyright © 2017 Roman. All rights reserved.

#import "TripsVC.h"
#import "TripDescriptionCell.h"
#import "Trip.h"
#import "ContentLoader.h"
#import "TripsVCConstants.h"
#import "NSString+DateFormats.h"
#import "SortingManager.h"
#import "InfoAlertViewController.h"

@interface TripsVC ()<UITableViewDataSource, UITableViewDelegate, ContentLoaderDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSArray* tripsArray;
@property (strong, nonatomic) ContentLoader* contentLoader;

- (IBAction)loadTripButtonPressed:(UIButton *)sender;
- (IBAction)sortButtonPressed:(UIButton *)sender;

@end

@implementation TripsVC

#pragma mark - View life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"TripDescriptionCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CELL_IDENTIFIER_STRING];
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = self.view.center;
    self.activityIndicator.hidden = YES;

    self.tripsArray = [[NSArray alloc]init];
    self.contentLoader = [[ContentLoader alloc]initWithCacheConfigurations];
    self.contentLoader.delegate = self;
    
    [self.contentLoader loadContentFrom:URL_FOR_TRAINS];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tripsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TripDescriptionCell *cell =  [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_STRING];
    Trip* trip = [self.tripsArray objectAtIndex:indexPath.row];
    [self setTripInfo:trip toCell:cell];
    cell.logo.image = nil;
    [self.contentLoader loadImage:trip.logoImagePath withSize:SIZE_FOR_LOGO_IMAGE withCompletionHandler:^(UIImage *loadedImage) {
        cell.logo.image = loadedImage;
    }];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    InfoAlertViewController* InfoAlertVC = [InfoAlertViewController alertControllerWithInfo:@"Offer details are not yet implemented!"];
    [self.navigationController presentViewController:InfoAlertVC animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_FOR_ROW;
}

#pragma mark - ContentLoaderDelegate
- (void) didFinishLoadTrips:(NSArray *) jsonResponseArray{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    self.tripsArray = [self createArrayOfTripsFrom:jsonResponseArray];
    [self.tableView reloadData];
}

#pragma mark - Helpers
- (void) setTripInfo:(Trip*) trip toCell:(TripDescriptionCell*) cell{
    cell.departureTimeLabel.text = [NSString stringWithFormat:@"%@ -",[NSString stringFromDateWithHHmmFormat:trip.departureTime]];
    cell.arrivalTimeLabel.text = [NSString stringFromDateWithHHmmFormat:trip.arrivalTime];
    cell.numberOfStopsLabel.text = [NSString stringFromNumberOfStops:trip.numberOfStops];
    cell.priceLabel.text = [NSString stringWithFormat:@"Price %.1f",trip.price];
    cell.tripDurationLabel.text = [NSString stringFromTimeIntervalWithHHmmFormat:trip.duration];
}

- (NSArray*) createArrayOfTripsFrom:(NSArray *) jsonResopnse{
    NSMutableArray* tripsArray = [[NSMutableArray alloc]init];
    for(NSDictionary* tripDictionaryInfo in jsonResopnse){
        Trip* trip = [[Trip alloc]initWithDictionary:tripDictionaryInfo];
        [tripsArray addObject:trip];
    }
    return tripsArray;
}

#pragma mark - Button actions
- (IBAction)loadTripButtonPressed:(UIButton *)sender {
    switch (sender.tag) {
        case TripTypeButtonTrain:
            [self.contentLoader loadContentFrom:URL_FOR_TRAINS];
            break;
        case TripTypeButtonBus:
            [self.contentLoader loadContentFrom:URL_FOR_BUSES];
            break;
        case TripTypeButtonFlight:
            [self.contentLoader loadContentFrom:URL_FOR_FLIGHTS];
            break;
        default:
            break;
            
    }
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
}
- (IBAction)sortButtonPressed:(UIButton *)sender {
    if (self.tripsArray.count >=1) {
        NSArray* resultArray;
        switch (sender.tag) {
            case SortTripsTypeByArrival:
                resultArray = [SortingManager sortArray:self.tripsArray ByKey:SORT_BY_ARRIVAL_KEY ascending:YES];
                break;
            case SortTripsTypeByDuration:
                resultArray = [SortingManager sortArray:self.tripsArray ByKey:SORT_BY_DURATION_KEY ascending:YES];
                break;
            case SortTripsTypeByDeparture:
                resultArray = [SortingManager sortArray:self.tripsArray ByKey:SORT_BY_DEPARTURE_KEY ascending:YES];
                break;
            default:
                break;
        }
        self.tripsArray = resultArray;
        [self.tableView reloadData];
    }
}
@end
