//
//  WeatherListModel.m
//  ND_Service
//
//  Created by NDMAC on 16/4/29.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "WeatherListModel.h"

@implementation WeatherListModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"weatherDescription":@"description"};
}

@end
