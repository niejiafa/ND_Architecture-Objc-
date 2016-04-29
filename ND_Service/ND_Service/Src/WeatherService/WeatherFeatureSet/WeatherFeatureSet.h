//
//  WeatherFeatureSet.h
//  ND_Service
//
//  Created by NDMAC on 16/4/29.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDFeatureSet.h"

@interface WeatherFeatureSet : NDFeatureSet

- (void)requestLocationWeatherInfoWithAppIdKey:(NSString *)appIdKey
                                      latitude:(NSString *)latitude
                                     longitude:(NSString *)longitude
                                 SuccessAction:(void (^)(id object))successAction
                                    failAction:(void (^)(NSError *error))failAction;

@end
