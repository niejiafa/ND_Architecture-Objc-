//
//  NDService.h
//  ND_Service
//
//  Created by NDMAC on 16/3/26.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDService : NSObject

/**
 *  返回服务的名称，子类必须重写
 *
 *  @return 服务名称
 */
+ (NSString *)serviceName;

/**
 *  判断服务没有人使用时，是否需要卸载
 *
 *  @return YES: 需要
 */
- (BOOL)needUnloading;

- (void)serviceWillLoad;

- (void)serviceDidLoad;

- (void)serviceWillUnload;

- (void)serviceDidUnload;

- (id)featureSetWithFeatureSetName:(NSString *)featureSetName;

- (void)unloadFeatureSetWithFeatureSetName:(NSString *)featureSetName;

- (void)serviceResponseCallBack:(NSString *)requestType
                      parameter:(id)parameter
                        success:(BOOL)success
                         object:(id)object
                      otherInfo:(id)otherInfo
         networkSuccessResponse:(void (^)(id object, id otherInfo))networkSuccessResponse
            networkFailResponse:(void (^)(id error, id otherInfo))networkFailResponse;

- (void)recordRequestFinishCount:(NSInteger)count;

@end
