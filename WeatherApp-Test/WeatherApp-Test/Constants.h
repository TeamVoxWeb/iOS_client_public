//
//  Constants.h
//  WeatherApp-Test
//
//  Created by Abhishek Chaudhari on 02/09/17.
//  Copyright © 2017 Abhishek Chaudhari. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#pragma mark - APIs and Keys

#define WEATHER_API_KEY @"ab74971a3571bd2194e2165bd27c12e7"

#define GET_CURRENT_WATHER_API @"https://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid="WEATHER_API_KEY
#define GET_FORECAST_WATHER_API @"https://api.openweathermap.org/data/2.5/forecast?lat=%@&lon=%@&appid="WEATHER_API_KEY

#define WEATHER_ICON_URL @"https://openweathermap.org/img/w/%@.png"

#pragma mark - Helper method constants
#define MAIN_WINDOW [[[UIApplication sharedApplication] delegate] window]
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define SCREEN_FRAME [UIScreen mainScreen].bounds
#define SHOW_NETWOEK_ACTIVITY [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;                 [[Utils sharedInstance] showActivityIndicator];

#define STOP_NETWOEK_ACTIVITY [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;                 [[Utils sharedInstance] removeActivityIndicator];


#define SLATE_BLUE [UIColor colorWithRed:117.0/255.0 green:32.0/255.0 blue:137/255.0 alpha:1]
#define INDEGO_BLUE [UIColor colorWithRed:44.0/255.0 green:30.0/255.0 blue:129.0/255.0 alpha:1]

#define KELVIN_DEGREE_DIFFRENCE 273.15

#define ACTIVITY_TAG 3843 //random number tag

#pragma mark - Messeges
#define LOCATION_ISSUE_MSG @"It seems there is an issue getting your location, check if app has permission to location services in phone settings."
#define GENRAL_ERROR_MSG @"Something went wrong, please try again!!!"
#define FACEBOOK_LOGIN_MSG @"Please login with facebook to access forecast!!!"
#define FACEBOOK_LOGOUT_MSG @"You have successfully logged out of Facebook."
#define FACEBOOK_LOGIN_ERROR_MSG @"Facebook login error!!!"
#define FACEBOOK_LOGIN_CANCEL_MSG @"Facebook login cancelled!!!"
#define FB_SUCCES_MSG @"Welcome %@\n You can now access weather forecast"
#endif /* Constants_h */

