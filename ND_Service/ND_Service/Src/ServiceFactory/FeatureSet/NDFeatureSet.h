//
//  NDFeatureSet.h
//  ND_Service
//
//  Created by NDMAC on 16/3/26.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NDService;
@class NDBaseRequest;

@interface NDFeatureSet : NSObject

@property (nonatomic, weak) NDService *service;

/**
 *  返回功能的名称，子类必须重写
 *
 *  @return 功能名称
 */
+ (NSString *)featureSetName;

- (void)featureSetWillLoad;

- (void)featureSetDidLoad;

- (void)featureSetWillUnload;

- (void)featureSetDidUnload;

- (void)startRequest:(NDBaseRequest *)baseRequest
         requestType:(NSString *)requestType
           parameter:(id)parameter
           otherInfo:(id)otherInfo
       successAction:(void (^)(id object, NDBaseRequest *request))successAction
          failAction:(void (^)(NSError *error, NDBaseRequest *request))failAction;

@end
