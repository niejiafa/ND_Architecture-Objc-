//
//  NDBaseRequest.m
//  NDService
//
//  Created by NDMAC on 16/3/26.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDBaseRequest.h"

#import "YYModel.h"
#import "NSString+ND.h"

@interface NDBaseRequest ()

@property (nonatomic, strong) id ndCacheModel;

@end

@implementation NDBaseRequest

#pragma mark - overwrite

- (BOOL)ignoreCache
{
    return YES;
}

- (YTKRequestMethod)requestMethod
{
    return self.requestMethodType;
}

- (void)requestCompleteFilter
{
    if (!self.isSaveToMemory && !self.isSaveToDisk)
    {
        return;
    }
    
    id model = [self convertToModel:[self responseString]];
    
    NSInteger updateCount;
    model = [self operateWithNewObject:model oldObject:[self cacheModel] updateCount:&updateCount];
    
    if (![self successForBussiness:model])
    {
        return;
    }
    
    if (self.isSaveToMemory)
    {
        self.ndCacheModel = model;
    }
    
    if (self.isSaveToDisk)
    {
        [self saveObjectToDiskCache:model];
    }
}

- (void)requestFailedFilter
{
    
    
}

#pragma mark - public

- (id)cacheModel
{
    id cacheModel = self.ndCacheModel;
    if (!self.isSaveToMemory)
    {
        self.ndCacheModel = nil;
    }
    
    return cacheModel;
}

- (id)currentResponseModel
{
    id model = [self convertToModel:[self responseString]];
    
    NSInteger updateCount;
    model = [self operateWithNewObject:model oldObject:[self cacheModel] updateCount:&updateCount];
    
    return model;
}

- (id)operateWithNewObject:(id)newObject
                 oldObject:(id)oldObject
               updateCount:(NSInteger *)updateCount
{
    if (self.operation)
    {
        return self.operation(newObject, oldObject);
    }
    
    *updateCount = 1;
    return newObject;
}

- (BOOL)successForBussiness:(id)model
{
    return NO;
}

- (BOOL)saveObjectToDiskCache:(id)object
{
    NSParameterAssert(object);
    
    if (!object)
    {
        return YES;
    }
    
    NSString *filePath = [self savedFilePath];
    BOOL success = [NSKeyedArchiver archiveRootObject:object toFile:filePath];
    return success;
}

- (NSString *)savedFilePath
{
    NSString *directory = [self savedFileDirectory];
    NSString *fileName = [self savedFileName];
    NSString *filePath = [directory stringByAppendingPathComponent:fileName];
    return filePath;
}

- (NSString *)savedFileDirectory
{
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    cachesDirectory = [cachesDirectory stringByAppendingPathComponent:@"NDBaseRequest"];
    
    if ([self.userCacheDirectory length] > 0)
    {
        cachesDirectory = [cachesDirectory stringByAppendingPathComponent:self.userCacheDirectory];
    }
    
    [self checkDirectory:cachesDirectory];
    
    return cachesDirectory;
}

- (NSString *)savedFileName
{
    NSString *baseUrl = [self baseUrl];
    NSString *requestUrl = [self requestUrl];
    id argument = [self requestArgument];
    NSString *requestInfo = [NSString stringWithFormat:@"Method:%ld Host:%@ Url:%@ Argument:%@ Sensitive:%@",
                             (long)[self requestMethod], baseUrl, requestUrl,
                             argument, self.sensitiveDataForSavedFileName];
    NSString *cacheFileName = [requestInfo nd_md5String];
    return cacheFileName;
}

- (void)saveObjectToMemory:(id)object
{
    self.ndCacheModel = object;
}

- (BOOL)haveDiskCache
{
    NSString *filePath = [self savedFilePath];
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    return fileExist;
}

- (void)removeMemoryCache
{
    self.ndCacheModel = nil;
}

- (void)removeDiskCache
{
    NSString *filePath = [self savedFilePath];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    if (error)
    {
    }
    else
    {
    }
}

- (void)removeAllCache
{
    [self removeMemoryCache];
    [self removeDiskCache];
}

- (id)convertToModel:(NSString *)JSONString
{
    id model = [JSONString hasPrefix:@"["] ? [NSArray yy_modelArrayWithClass:self.modelClass json:JSONString] : [self.modelClass yy_modelWithJSON:JSONString];
    return model;
}

#pragma mark - private

- (void)checkDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir])
    {
        [self createBaseDirectoryAtPath:path];
    }
    else
    {
        if (!isDir)
        {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}

- (void)createBaseDirectoryAtPath:(NSString *)path
{
    __autoreleasing NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (error)
    {
    }
    else
    {
    }
}

@end
