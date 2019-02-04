//
//  Utils.h
//  WeatherApp-Test
//
//  Created by Abhishek Chaudhari on 03/09/17.
//  Copyright © 2017 Abhishek Chaudhari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+(instancetype)sharedInstance;
- (id) init __unavailable;
- (id) initWithFrame:(CGRect)frame __unavailable;

-(void)showAlert: (NSString*)message forViewController:(UIViewController*)forViewController;
-(void)addAppBGGredient:(UIView*)view;

-(void)startRechabilityNotifications;
-(void)stopRechabilityNotifications;

-(void)showActivityIndicator;
-(void)removeActivityIndicator;

@end
