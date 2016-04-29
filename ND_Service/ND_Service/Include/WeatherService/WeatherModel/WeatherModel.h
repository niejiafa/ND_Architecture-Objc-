//
//  WeatherModel.h
//  ND_Service
//
//  Created by NDMAC on 16/4/29.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDModel.h"

@class WeatherListModel;

@interface WeatherModel : NDModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray<WeatherListModel *> *weather;

@end
