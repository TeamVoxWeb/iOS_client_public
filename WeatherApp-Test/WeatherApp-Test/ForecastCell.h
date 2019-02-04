//
//  ForecastCell.h
//  WeatherApp-Test
//
//  Created by Abhishek Chaudhari on 03/09/17.
//  Copyright © 2017 Abhishek Chaudhari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tempText;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempretureLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
