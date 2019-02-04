//
//  LocationHelper.m
//  WeatherApp-Test
//
//  Created by Abhishek Chaudhari on 02/09/17.
//  Copyright © 2017 Abhishek Chaudhari. All rights reserved.
//

#import "LocationHelper.h"


@interface LocationHelper()<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    weatherUpdateCompletion weatherUpdateBlock;
}

@end

@implementation LocationHelper
@synthesize currentLocation;
static LocationHelper *sharedManager = nil;

+(instancetype)sharedInstance
{
    if(sharedManager==nil)
    {
        sharedManager = [[self alloc] init];
        [sharedManager commonInit];
        [sharedManager updateLocation:nil];
    }
    return sharedManager;
}


-(void)commonInit{
    
    locationManager = [[CLLocationManager alloc] init];
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    [locationManager requestWhenInUseAuthorization];

    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

-(void)updateLocation:(weatherUpdateCompletion)updateBlock{
    [locationManager startUpdatingLocation];
    weatherUpdateBlock = updateBlock;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    currentLocation = newLocation;
    _currentLatitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    _currentLongitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    [locationManager stopUpdatingLocation];
    
    if (weatherUpdateBlock) {
        weatherUpdateBlock(YES);
    }
    weatherUpdateBlock = nil;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (weatherUpdateBlock) {
        weatherUpdateBlock(NO);
    }
    weatherUpdateBlock = nil;
}

@end
