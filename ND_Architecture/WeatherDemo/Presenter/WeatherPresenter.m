//
//  WeatherPresenter.m
//  ND_Architecture
//
//  Created by NDMAC on 16/4/29.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "WeatherPresenter.h"

#import "NDServiceFactory.h"
#import "WeatherService.h"
#import "WeatherModel.h"

static NSString *appIdKey = @"8781e4ef1c73ff20a180d3d7a42a8c04";

@implementation WeatherPresenter

#pragma mark - public

- (void)requestLocationWeatherInfoWithLatitude:(CLLocationDegrees)latitude
                                     longitude:(CLLocationDegrees)longitude;
{
    WeatherService *weatherService = [[NDServiceFactory sharedServiceFactory] serviceWithServiceName:[WeatherService serviceName]];
    
    [weatherService requestLocationWeatherInfoWithAppIdKey:appIdKey latitude:[NSString stringWithFormat:@"%f",latitude] longitude:[NSString stringWithFormat:@"%f",longitude]  SuccessAction:^(id object) {
        self.weatherModel = (WeatherModel *)object;
        if (self.delegate && [self.delegate respondsToSelector:@selector(weatherPresenter:requestLocationWeatherInfoSuccess:)])
        {
            [self.delegate weatherPresenter:self requestLocationWeatherInfoSuccess:YES];
        }
    } failAction:^(NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(weatherPresenter:requestLocationWeatherInfoSuccess:)])
        {
            [self.delegate weatherPresenter:self requestLocationWeatherInfoSuccess:NO];
        }
    }];
}

@end
