//
//  LocationHelper.h
//  WeatherApp-Test
//
//  Created by Abhishek Chaudhari on 02/09/17.
//  Copyright © 2017 Abhishek Chaudhari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^weatherUpdateCompletion)(BOOL finished);

@interface LocationHelper : NSObject{
    CLLocation *currentLocation;
}
@property (nonatomic,strong) CLLocation *currentLocation;
@property (nonatomic,strong) NSString *currentLatitude;
@property (nonatomic,strong) NSString *currentLongitude;
- (id) init __unavailable;

-(void)updateLocation:(weatherUpdateCompletion) updateBlock;
+(instancetype)sharedInstance;
@end
