//
//  Header.h
//  goEuroTest
//
//  Created by Roman Bobelyuk on 1/20/17.
//  Copyright © 2017 Roman. All rights reserved.
//

#ifndef TripsVCConstants_h
#define TripsVCConstants_h

#define URL_FOR_FLIGHTS  @"https://api.myjson.com/bins/w60i"
#define URL_FOR_BUSES  @"https://api.myjson.com/bins/37yzm"
#define URL_FOR_TRAINS  @"https://api.myjson.com/bins/3zmcy"

#define CELL_IDENTIFIER_STRING @"TripDescriptionCell"

#define SORT_BY_ARRIVAL_KEY @"arrivalTime"
#define SORT_BY_DEPARTURE_KEY @"departureTime"
#define SORT_BY_DURATION_KEY @"duration"

#define SIZE_FOR_LOGO_IMAGE 63

#define HEIGHT_FOR_ROW 70

typedef NS_ENUM(NSInteger, SortTripsType) {
    SortTripsTypeByArrival,
    SortTripsTypeByDuration,
    SortTripsTypeByDeparture,
};

typedef NS_ENUM(NSInteger, TripTypeButton) {
    TripTypeButtonTrain,
    TripTypeButtonBus,
    TripTypeButtonFlight,
};

#endif
