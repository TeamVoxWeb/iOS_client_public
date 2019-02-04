//
//  WeatherEntity.h
//  WeatherApp-Test
//
//  Created by Abhishek Chaudhari on 02/09/17.
//  Copyright © 2017 Abhishek Chaudhari. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WeatherEntity : NSObject

@property(nonatomic,strong) NSString *main;
@property(nonatomic,strong) NSString *description;
@property(nonatomic,strong) NSString *icon;
@property(nonatomic,strong) NSNumber *temp;
@property(nonatomic,strong) NSNumber *pressure;
@property(nonatomic,strong) NSNumber *humidity;
@property(nonatomic,strong) NSNumber *temp_min;
@property(nonatomic,strong) NSNumber *temp_max;
@property(nonatomic,strong) NSNumber *sea_level;
@property(nonatomic,strong) NSNumber *grnd_level;
@property(nonatomic,strong) NSNumber *speed;
@property(nonatomic,strong) NSNumber *deg;
@property(nonatomic,strong) NSNumber *dt;
@property(nonatomic,strong) NSString *country;
@property(nonatomic,strong) NSNumber *sunrise;
@property(nonatomic,strong) NSNumber *sunset;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *formatted_address;
@property(nonatomic,strong) NSString *dt_txt;

- (instancetype)initWithDictionry:(NSDictionary*)dict;

@end





