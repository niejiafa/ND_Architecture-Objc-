//
//  NDServiceFactory.m
//  ND_Service
//
//  Created by NDMAC on 16/3/28.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDServiceFactory.h"

@implementation NDServiceFactory

#pragma mark - public

+ (instancetype)sharedServiceFactory
{
    static dispatch_once_t once;
    static NDServiceFactory *serviceFactory;
    dispatch_once(&once, ^{
        serviceFactory = [[NDServiceFactory alloc] init];
    });
    return serviceFactory;
}

@end
