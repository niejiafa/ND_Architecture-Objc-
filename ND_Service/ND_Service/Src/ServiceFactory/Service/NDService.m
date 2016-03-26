//
//  NDService.m
//  ND_Service
//
//  Created by NDMAC on 16/3/26.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDService.h"

#import <libkern/OSAtomic.h>

#import "NDFeatureSet.h"

@interface NDService()

@property (nonatomic, assign) NSInteger requestFinishCount;
@property (nonatomic, assign) OSSpinLock spinLock;
@property (nonatomic, strong) NSMutableDictionary *featureSetContainer;

@end

@implementation NDService

#pragma mark - life cycle

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.spinLock = OS_SPINLOCK_INIT;
    }
    return self;
}

#pragma mark - public

+ (NSString *)serviceName
{
    return NSStringFromClass(self.class);
}

- (BOOL)needUnloading
{
    BOOL need =  (0 == self.requestFinishCount);
    return need;
}

- (void)serviceWillLoad
{
    
}

- (void)serviceDidLoad
{
    
}

- (void)serviceWillUnload
{
    
}

- (void)serviceDidUnload
{
    
}

- (id)featureSetWithFeatureSetName:(NSString *)featureSetName_
{
    NSParameterAssert(featureSetName_);
    
    NDFeatureSet *featureSet = self.featureSetContainer[featureSetName_];
    if (featureSet)
    {
        return featureSet;
    }
    
    featureSet = [[NSClassFromString(featureSetName_) alloc] init];
    featureSet.service = self;
    [featureSet featureSetWillLoad];
    self.featureSetContainer[featureSetName_] = featureSet;
    [featureSet featureSetDidLoad];
    
    return featureSet;
}

- (void)unloadFeatureSetWithFeatureSetName:(NSString *)featureSetName_
{
    NSParameterAssert(featureSetName_);
    
    NDFeatureSet *featureSet = self.featureSetContainer[featureSetName_];
    [featureSet featureSetWillUnload];
    [self.featureSetContainer removeObjectForKey:featureSetName_];
    [featureSet featureSetDidUnload];
}

- (void)serviceResponseCallBack:(NSString *)requestType_
                      parameter:(id)parameter_
                        success:(BOOL)success
                         object:(id)object_
                      otherInfo:(id)otherInfo_
         networkSuccessResponse:(void (^)(id object, id otherInfo))networkSuccessResponse_
            networkFailResponse:(void (^)(id error, id otherInfo))networkFailResponse_
{
    if (success)
    {
        if (networkSuccessResponse_)
        {
            networkSuccessResponse_(object_, otherInfo_);
        }
    }
    else
    {
        if (networkFailResponse_)
        {
            networkFailResponse_(object_, otherInfo_);
        }
    }
    
    [self recordRequestFinishCount:1];
}

- (void)recordRequestFinishCount:(NSInteger)count_
{
    OSSpinLockLock(&_spinLock);
    
    self.requestFinishCount = self.requestFinishCount + count_;
    
    OSSpinLockUnlock(&_spinLock);
}

#pragma mark getter and setter

- (NSMutableDictionary *)featureSetContainer
{
    if (_featureSetContainer)
    {
        return _featureSetContainer;
    }
    
    _featureSetContainer = [NSMutableDictionary dictionary];
    return _featureSetContainer;
}

@end
