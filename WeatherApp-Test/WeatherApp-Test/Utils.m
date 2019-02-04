//
//  Utils.m
//  WeatherApp-Test
//
//  Created by Abhishek Chaudhari on 03/09/17.
//  Copyright © 2017 Abhishek Chaudhari. All rights reserved.
//

#import "Utils.h"
#import "Constants.h"
#import <AFNetworkReachabilityManager.h>
@implementation Utils

static Utils *sharedManager = nil;
UIView *noInternetView;

+(instancetype)sharedInstance
{
    if(sharedManager==nil)
    {
        sharedManager = [[self alloc] init];
    }
    return sharedManager;
}

-(void)showAlert: (NSString*)message forViewController:(UIViewController*)forViewController{
    UIAlertController * alert= [UIAlertController
                                alertControllerWithTitle:nil
                                message: message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [alert addAction:ok];
    
    [forViewController presentViewController:alert animated:YES completion:nil];
}

-(void)addAppBGGredient:(UIView*)view{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.bounds = SCREEN_FRAME;
    gradient.frame = SCREEN_FRAME;
    gradient.colors = @[(id)SLATE_BLUE.CGColor
                        , (id)INDEGO_BLUE.CGColor];
    
    [view.layer insertSublayer:gradient atIndex:0];
    
}

#pragma mark - Reachability

-(void)startRechabilityNotifications{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        
        if (noInternetView == nil) {
            noInternetView = [[UIView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_SIZE.width, 64)];
            
            [noInternetView setBackgroundColor:[UIColor redColor]];
            UILabel *noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 64)];
            
            noInternetLabel.text = @"It seems you have lost network!!!";
            noInternetLabel.textAlignment = NSTextAlignmentCenter;
            [noInternetLabel setTextColor:[UIColor whiteColor]];
            
            [noInternetView addSubview:noInternetLabel];
            
            [MAIN_WINDOW addSubview:noInternetView];
        }
        
        if (status<1) {
            //not rechable
            [UIView animateWithDuration:0.26 animations:^{
                noInternetView.frame = CGRectMake(0, 0, SCREEN_SIZE.width, 64);
            }];
        }else{
            //rechable
            [UIView animateWithDuration:0.26 animations:^{
                noInternetView.frame = CGRectMake(0, -64, SCREEN_SIZE.width, 64);
            }];
        }
    }];
    
}

-(void)stopRechabilityNotifications{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}


#pragma mark - Activity indicator
-(void)showActivityIndicator{
    if ([MAIN_WINDOW viewWithTag:ACTIVITY_TAG] == nil) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]
                                                 initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.center=MAIN_WINDOW.center;
        activityView.tag = ACTIVITY_TAG;
        [activityView startAnimating];
        [MAIN_WINDOW addSubview:activityView];
    }
}

-(void)removeActivityIndicator{
    if ([MAIN_WINDOW viewWithTag:ACTIVITY_TAG]) {
        [[MAIN_WINDOW viewWithTag:ACTIVITY_TAG] removeFromSuperview];
    }
}

@end
