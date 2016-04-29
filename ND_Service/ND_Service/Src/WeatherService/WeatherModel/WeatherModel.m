//
//  WeatherModel.m
//  ND_Service
//
//  Created by NDMAC on 16/4/29.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "WeatherModel.h"

#import "WeatherListModel.h"

@implementation WeatherModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"weather":[WeatherListModel class]};
}

@end
