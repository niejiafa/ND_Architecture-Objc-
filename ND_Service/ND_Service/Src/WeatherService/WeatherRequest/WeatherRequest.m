//
//  WeatherRequest.m
//  ND_Service
//
//  Created by NDMAC on 16/4/29.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "WeatherRequest.h"

@implementation WeatherRequest

#pragma mark - life style

- (instancetype)initWithParameter:(NSDictionary *)parameter
{
    self = [super init];
    if (self)
    {
        self.parameter = parameter;
    }
    return self;
}

#pragma mark - overwrite

- (NSString *)baseUrl
{
    return @"http://api.openweathermap.org";
}

- (NSString *)requestUrl
{
    return @"/data/2.5/weather";
}

- (id)requestArgument
{
    return self.parameter;
}

@end
