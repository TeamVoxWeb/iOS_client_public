//
//  MenuView.h
//  WeatherApp-Test
//
//  Created by Abhishek Chaudhari on 02/09/17.
//  Copyright © 2017 Abhishek Chaudhari. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^hideMenuCompletion)(BOOL);

@interface MenuView : UIView

@property (strong, nonatomic) UINavigationController *dashBoardVCNav;
@property (strong, nonatomic) UINavigationController *forecastVCNav;

+(instancetype)sharedInstance;
-(void)hideMenu:(hideMenuCompletion) compBlock;
-(void)showMenu: (UIViewController*)forViewController;

- (id) init __unavailable;
- (id) initWithFrame:(CGRect)frame __unavailable;

@end
