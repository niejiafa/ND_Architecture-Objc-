//
//  WeatherRequest.h
//  ND_Service
//
//  Created by NDMAC on 16/4/29.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDBaseRequest.h"

@interface WeatherRequest : NDBaseRequest

@property (nonatomic, strong) NSDictionary *parameter;

- (instancetype)initWithParameter:(NSDictionary *)parameter;

@end
