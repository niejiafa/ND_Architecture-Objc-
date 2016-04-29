//
//  WeatherService.m
//  ND_Service
//
//  Created by NDMAC on 16/4/29.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "WeatherService.h"

#import "WeatherFeatureSet.h"

@implementation WeatherService

#pragma mark - overwrite

+ (NSString *)serviceName
{
    return @"WeatherService";
}

- (void)requestLocationWeatherInfoWithAppIdKey:(NSString *)appIdKey
                                      latitude:(NSString *)latitude
                                     longitude:(NSString *)longitude
                                 SuccessAction:(void (^)(id object))successAction
                                    failAction:(void (^)(NSError *error))failAction;
{
    WeatherFeatureSet *featureSet  = [self featureSetWithFeatureSetName:[WeatherFeatureSet featureSetName]];
    
    [featureSet requestLocationWeatherInfoWithAppIdKey:appIdKey latitude:latitude longitude:longitude SuccessAction:successAction failAction:failAction];
}

@end
