//
//  MenuView.m
//  WeatherApp-Test
//
//  Created by Abhishek Chaudhari on 02/09/17.
//  Copyright © 2017 Abhishek Chaudhari. All rights reserved.
//

#import "MenuView.h"
#import "Constants.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Utils.h"

@interface MenuView()<UIGestureRecognizerDelegate>{
}
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIView *menuContainerView;
@property (strong, nonatomic) IBOutlet UIViewController *forViewController;
@property (weak, nonatomic) IBOutlet UIView *blurView;

@end


@implementation MenuView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
#pragma mark - Initializers

static MenuView *sharedManager = nil;

+(instancetype)sharedInstance
{
    if(sharedManager==nil)
    {
        sharedManager = [[self alloc] init];
        [sharedManager commonInit];
    }
    return sharedManager;
}

-(void)commonInit{
    UIView *viewFromNib = [[[NSBundle mainBundle] loadNibNamed:@"MenuView" owner:self options:nil] objectAtIndex:0];

    [viewFromNib setFrame:MAIN_WINDOW.frame];
    [viewFromNib setBounds:MAIN_WINDOW.bounds];
    [self addSubview:viewFromNib];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [_menuContainerView addGestureRecognizer:tap];
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = _blurView.frame;
    [_blurView addSubview:visualEffectView];
    [_blurView sendSubviewToBack:visualEffectView];
}

#pragma mark - Menu actions

-(void)singleTap:(UIGestureRecognizer*)recogniser{
    [self hideMenu:nil];
}

-(void)hideMenu:(hideMenuCompletion) compBlock{
    [UIView animateWithDuration:0.26 animations:^{
        CGRect menuContainerFrame = self.menuContainerView.frame;
        menuContainerFrame.origin.x = -self.menuContainerView.frame.size.width;
        
        [self.menuContainerView setFrame:menuContainerFrame];
    } completion:^(BOOL finished) {
        [self.menuContainerView removeFromSuperview];
        if (compBlock) {
            compBlock(YES);
        }
    }];
}

-(void)showMenu: (UIViewController*)forViewController{
    self.forViewController = forViewController;
    
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        [_loginButton setTitle:@"Logout from FaceBook" forState:UIControlStateNormal];
    }else{
        [_loginButton setTitle:@"Login via Facebook" forState:UIControlStateNormal];
    }

    self.menuContainerView.frame = CGRectMake(-self.menuContainerView.frame.size.width, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
    
    [MAIN_WINDOW addSubview:self.menuContainerView];
    
    [UIView animateWithDuration:0.26 animations:^{
        CGRect menuContainerFrame = self.menuContainerView.frame;
        menuContainerFrame.origin.x = 0;
        [self.menuContainerView setFrame:menuContainerFrame];
    } completion:^(BOOL finished) {
    }];
}
- (IBAction)forecastClicked:(id)sender {
    NSLog(@"Forecast clicked");
    [self hideMenu:nil];
    if ([FBSDKAccessToken currentAccessToken]) {
        [UIView transitionWithView:MAIN_WINDOW
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            [MAIN_WINDOW setRootViewController:_forecastVCNav];
                        }
                        completion:nil];
    }else{
        [[Utils sharedInstance] showAlert:FACEBOOK_LOGIN_MSG forViewController:self.forViewController];
    }
}
- (IBAction)dashboardClicked:(id)sender {
    NSLog(@"Dashboard clicked");

    [self hideMenu:nil];
    [UIView transitionWithView:MAIN_WINDOW
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [MAIN_WINDOW setRootViewController:_dashBoardVCNav];
                    }
                    completion:nil];

}

- (IBAction)loginClicked:(id)sender {
    NSLog(@"Facebook loing clicked");

    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];

    if ([FBSDKAccessToken currentAccessToken]) {
        [loginManager logOut];
        [self hideMenu:^(BOOL finished) {
            [self dashboardClicked:nil];
            [[Utils sharedInstance] showAlert:FACEBOOK_LOGOUT_MSG forViewController:self.forViewController];
        }];
        
    }else{
        [self hideMenu:^(BOOL finished) {
            [loginManager
             logInWithReadPermissions: @[@"public_profile"]
             fromViewController:self.forViewController
             handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                 if (error) {
                     [[Utils sharedInstance] showAlert:FACEBOOK_LOGIN_ERROR_MSG forViewController:self.forViewController];
                 } else if (result.isCancelled) {
                     [[Utils sharedInstance] showAlert:FACEBOOK_LOGIN_CANCEL_MSG forViewController:self.forViewController];
                 } else {
                     
                     if ([FBSDKAccessToken currentAccessToken]) {
                         [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                          startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  NSLog(@"fetched user:%@", result);
                                  [[Utils sharedInstance] showAlert:[NSString stringWithFormat:FB_SUCCES_MSG,[(NSDictionary*)result objectForKey:@"name"]] forViewController:self.forViewController];
                              }
                          }];
                     }
                     [_loginButton setTitle:@"Logout from FaceBook" forState:UIControlStateNormal];
                 }
             }];
        }];
    }
}

@end
