//
//  DashBoardVC.m
//  WeatherApp-Test
//
//  Created by Abhishek Chaudhari on 01/09/17.
//  Copyright © 2017 Abhishek Chaudhari. All rights reserved.
//

#import "DashBoardVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "MenuView.h"
#import "LocationHelper.h"
#import "Constants.h"
#import <AFNetworking.h>
#import "WeatherEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Utils.h"

@interface DashBoardVC ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempNowLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *minMaxTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;

@end

@implementation DashBoardVC

#pragma mark - ViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateWeather];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
    
    [[Utils sharedInstance] addAppBGGredient:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

#pragma mark - Actions

- (IBAction)menuButtonClicked:(id)sender {
    [[MenuView sharedInstance] showMenu:self];
}

- (IBAction)refreshClicked:(UIButton *)sender {
    [self updateWeather];
}

#pragma mark - Weather And Time

-(void)showTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss a"];

    _timeLabel.text=[formatter stringFromDate:[NSDate date]];
}

-(void)updateUIForWeather:(WeatherEntity*)weather{
    _cityLabel.text = weather.name;
    [_weatherImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:WEATHER_ICON_URL,weather.icon]] placeholderImage:[UIImage imageNamed:@"placeholder"]];

    _descriptionLabel.text = weather.description;
    _tempNowLabel.text = [NSString stringWithFormat:@"%.1f°",[weather.temp floatValue] - KELVIN_DEGREE_DIFFRENCE];
    _humidityLabel.text = [NSString stringWithFormat:@"%@%%",weather.humidity];
    _minMaxTempLabel.text = [NSString stringWithFormat:@"%.1f°/%.1f°",[weather.temp_min floatValue] - KELVIN_DEGREE_DIFFRENCE,[weather.temp_max floatValue] - KELVIN_DEGREE_DIFFRENCE];
    _windSpeedLabel.text = [NSString stringWithFormat:@"%.1f m/s",[weather.speed floatValue]];
}

-(void)updateWeather{
    NSLog(@"Update current weather: API being called");
    SHOW_NETWOEK_ACTIVITY
    [[Utils sharedInstance] showActivityIndicator];
    [[LocationHelper sharedInstance] updateLocation:^(BOOL finished) {

        if (finished) {
            NSString *apiURL = [NSString stringWithFormat:GET_CURRENT_WATHER_API,[LocationHelper sharedInstance].currentLatitude,[LocationHelper sharedInstance].currentLongitude];

            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:apiURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                NSLog(@"Update current weather: API successful");
                WeatherEntity *weather = [[WeatherEntity alloc] initWithDictionry:responseObject];
                [self updateUIForWeather:weather];
                STOP_NETWOEK_ACTIVITY
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Update current weather: API failed");
                [[Utils sharedInstance] showAlert:GENRAL_ERROR_MSG forViewController:self];
                STOP_NETWOEK_ACTIVITY
            }];
        }else{
            NSLog(@"Get forecast weather: Location failed");
            [[Utils sharedInstance] showAlert:LOCATION_ISSUE_MSG forViewController:self];
            STOP_NETWOEK_ACTIVITY
        }
    }];
}


@end
