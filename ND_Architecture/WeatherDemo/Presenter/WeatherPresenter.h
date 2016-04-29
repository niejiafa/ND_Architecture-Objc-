//
//  WeatherPresenter.h
//  ND_Architecture
//
//  Created by NDMAC on 16/4/29.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@class WeatherModel;
@class WeatherPresenter;

@protocol WeatherPresenterDelegate <NSObject>

- (void)weatherPresenter:(WeatherPresenter *)presenter requestLocationWeatherInfoSuccess:(BOOL)success;

@end

@interface WeatherPresenter : NSObject

@property (nonatomic, strong) CLLocation  *location;
@property (nonatomic, weak) id <WeatherPresenterDelegate> delegate;
@property (nonatomic, strong) WeatherModel  *weatherModel;

- (void)requestLocationWeatherInfoWithLatitude:(CLLocationDegrees)latitude
                                     longitude:(CLLocationDegrees)longitude;

@end
