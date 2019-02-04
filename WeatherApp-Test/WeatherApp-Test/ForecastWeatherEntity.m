//
//  WeatherEntity.m
//  WeatherApp-Test
//
//  Created by Abhishek Chaudhari on 02/09/17.
//  Copyright © 2017 Abhishek Chaudhari. All rights reserved.
//

#import "ForecastWeatherEntity.h"
#import "WeatherEntity.h"

@implementation ForecastWeatherEntity
@synthesize description; //In particualar condition where json key is "description", we need to explicitly sysnthesize
- (instancetype)initWithDictionry:(NSDictionary*)dict {
    self = [super init];
    if (self) {
        _forecastArray = [[NSMutableArray alloc] init];
        [self parseDictionary:dict];
    }
    return self;
}

-(void)parseDictionary:(NSDictionary*)dict{
    for (NSString *key in dict) {
        id value =  [dict valueForKey:key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            [self parseDictionary:value];
        }else if ([value isKindOfClass:[NSArray class]]) {
            NSArray *dictArray = value;
            for (NSDictionary *dictionary in dictArray) {
                WeatherEntity *weather = [[WeatherEntity alloc] initWithDictionry:dictionary];
                [_forecastArray addObject:weather];
            }
        }else{
            if ([self respondsToSelector:NSSelectorFromString(key)]) {
                [self setValue:value forKey:key];
            }
        }
    }
}

@end
