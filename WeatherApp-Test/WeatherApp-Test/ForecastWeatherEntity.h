//
//  WeatherEntity.h
//  WeatherApp-Test
//
//  Created by Abhishek Chaudhari on 02/09/17.
//  Copyright © 2017 Abhishek Chaudhari. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ForecastWeatherEntity : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSMutableArray *forecastArray;

- (instancetype)initWithDictionry:(NSDictionary*)dict;

@end





