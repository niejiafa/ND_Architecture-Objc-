//
//  NDServiceFactory.h
//  ND_Service
//
//  Created by NDMAC on 16/3/28.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDServiceFactory : NSObject

+ (instancetype)sharedServiceFactory;

- (id)serviceWithServiceName:(NSString *)serviceName;

- (void)unloadServiceWithServiceName:(NSString *)serviceName;
- (void)unloadServiceWithServiceName:(NSString *)serviceName isForceUnload:(BOOL)isForceUnload;

@end
