//
//  ForecastVCViewController.m
//  WeatherApp-Test
//
//  Created by Abhishek Chaudhari on 03/09/17.
//  Copyright © 2017 Abhishek Chaudhari. All rights reserved.
//

#import "ForecastVC.h"
#import "MenuView.h"
#import "Constants.h"
#import "ForecastWeatherEntity.h"
#import "LocationHelper.h"
#import <AFNetworking.h>
#import "WeatherEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Utils.h"
#import "ForecastCell.h"

@interface ForecastVC ()<UITableViewDelegate, UITableViewDataSource>{
    ForecastWeatherEntity *forecastEntity;
    NSDateFormatter *formatter;
}
@property (weak, nonatomic) IBOutlet UITableView *forecastTableview;

@end

@implementation ForecastVC
static NSString *CellIdentifier = @"ForecastCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM hh:mm a"];

    forecastEntity = nil;
    [self updateWeatherForecast];
    forecastEntity = nil;
    [_forecastTableview registerNib:[UINib nibWithNibName:@"ForecastCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];

    [[Utils sharedInstance] addAppBGGredient:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview callbacks

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [forecastEntity.forecastArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    WeatherEntity *weather = [forecastEntity.forecastArray objectAtIndex:indexPath.row];
    
    [cell.weatherImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:WEATHER_ICON_URL,weather.icon]] placeholderImage:[UIImage imageNamed:@"placeholder"]];

    cell.descriptionLabel.text = [NSString stringWithFormat:@"%@ on",weather.description];
    cell.timeLabel.text=[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[weather.dt doubleValue]]];
    cell.tempretureLabel.text = [NSString stringWithFormat:@"%.1f°",[weather.temp floatValue] - KELVIN_DEGREE_DIFFRENCE];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}

#pragma mark - Actions

- (IBAction)menuButtonClicked:(id)sender {
    [[MenuView sharedInstance] showMenu:self];
}

- (IBAction)refreshClicked:(UIButton *)sender {
    [self updateWeatherForecast];
}


-(void)updateWeatherForecast{
    NSLog(@"Get forecast weather: API being called");

    SHOW_NETWOEK_ACTIVITY
    
    [[LocationHelper sharedInstance] updateLocation:^(BOOL finished) {
        
        if (finished) {
            NSString *apiURL = [NSString stringWithFormat:GET_FORECAST_WATHER_API,[LocationHelper sharedInstance].currentLatitude,[LocationHelper sharedInstance].currentLongitude];
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:apiURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                NSLog(@"Get forecast weather: API successful");

                ForecastWeatherEntity *forecastWeather = [[ForecastWeatherEntity alloc] initWithDictionry:responseObject];
                NSLog(@"%@",forecastWeather);
                self->forecastEntity = forecastWeather;
                [self.forecastTableview reloadData];
                STOP_NETWOEK_ACTIVITY
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Get forecast weather: API failed");

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
