//
//  WeatherFeatureSet.m
//  ND_Service
//
//  Created by NDMAC on 16/4/29.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "WeatherFeatureSet.h"

#import "WeatherRequest.h"
#import "WeatherModel.h"

@implementation WeatherFeatureSet

#pragma mark - overwrite

+ (NSString *)featureSetName
{
    return @"WeatherFeatureSet";
}

- (void)requestLocationWeatherInfoWithAppIdKey:(NSString *)appIdKey
                                      latitude:(NSString *)latitude
                                     longitude:(NSString *)longitude
                                 SuccessAction:(void (^)(id object))successAction
                                    failAction:(void (^)(NSError *error))failAction;
{
    
    
    WeatherRequest *request = [[WeatherRequest alloc] initWithParameter:@{@"lat" : latitude,
                                                                          @"lon" : longitude,
                                                                          @"APPID" : appIdKey}];
    
    request.modelClass = [WeatherModel class];
    request.requestMethodType = YTKRequestMethodGet;
    
    [self startRequest:request requestType:nil parameter:nil otherInfo:nil successAction:^(id object, NDBaseRequest *request) {
        if (successAction)
        {
            successAction(object);
        }
        
    } failAction:^(NSError *error, NDBaseRequest *request) {
        if (failAction)
        {
            failAction(error);
        }
    }];
}

@end
