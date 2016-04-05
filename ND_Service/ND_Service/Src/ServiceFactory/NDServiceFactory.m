//
//  NDServiceFactory.m
//  ND_Service
//
//  Created by NDMAC on 16/3/28.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDServiceFactory.h"

#import "NDService.h"

@interface NDServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceContainer;

@end

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

- (id)serviceWithServiceName:(NSString *)serviceName
{
    NSParameterAssert(serviceName);
    
    NDService *service = self.serviceContainer[serviceName];
    if (service)
    {
        return service;
    }
    
    [self nd_unloadUnneededService];
    
    service = [[NSClassFromString(serviceName) alloc] init];
    [service serviceWillLoad];
    self.serviceContainer[serviceName] = service;
    [service serviceDidLoad];
    
    return service;
}

- (void)unloadServiceWithServiceName:(NSString *)serviceName
{
    [self unloadServiceWithServiceName:serviceName isForceUnload:NO];
}

- (void)unloadServiceWithServiceName:(NSString *)serviceName
                       isForceUnload:(BOOL)isForceUnload
{
    NSParameterAssert(serviceName);
    
    NDService *service = self.serviceContainer[serviceName];
    
    if (!isForceUnload && ![service needUnloading])
    {
        return;
    }
    
    [service serviceWillUnload];
    [self.serviceContainer removeObjectForKey:serviceName];
    [service serviceDidUnload];
}

#pragma mark - private

- (void)nd_unloadUnneededService
{
    NSMutableArray *unloadingKeys = [NSMutableArray array];
    
    [self.serviceContainer enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NDService * _Nonnull obj, BOOL * _Nonnull stop)
     {
         if ([obj needUnloading])
         {
             [unloadingKeys addObject:key];
         }
     }];
    
    [self.serviceContainer removeObjectsForKeys:unloadingKeys];
}

#pragma mark - getter and setter

- (NSMutableDictionary *)serviceContainer
{
    if (_serviceContainer)
    {
        return _serviceContainer;
    }
    
    _serviceContainer = [NSMutableDictionary dictionary];
    return _serviceContainer;
}

@end
