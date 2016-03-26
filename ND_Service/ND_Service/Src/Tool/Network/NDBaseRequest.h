//
//  NDBaseRequest.h
//  ND_Service
//
//  Created by NDMAC on 16/3/26.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface NDBaseRequest : YTKBaseRequest

 ///请求方式
@property (nonatomic, assign) YTKRequestMethod requestMethodType;

 ///保存缓存至内存缓存
@property (nonatomic, assign) BOOL isSaveToMemory;

 ///保存缓存至磁盘缓存
@property (nonatomic, assign) BOOL isSaveToDisk;

 ///用户缓存数据文件夹
@property (nonatomic, copy) NSString *userCacheDirectory;

 ///若为公用资源，需设置为空，默认为不同用户资源
@property (nonatomic, copy) NSString *sensitiveDataForSavedFileName;

 ///模型
@property (nonatomic, strong) Class modelClass;

 ///增量更新
@property (nonatomic, copy) id (^operation)(id newObject, id oldObject);

 ///请求成功回调
@property (nonatomic, copy) void (^networkSuccessResponse)(id object, id otherInfo);

///请求失败回调
@property (nonatomic, copy) void (^networkFailResponse)(id error, id otherInfo);

///缓存
- (id)cacheModel;

///最新请求的模型
- (id)currentResponseModel;

///保存缓存至内存
- (void)saveObjectToMemory:(id)object;

///保存缓存至磁盘
- (BOOL)saveObjectToDiskCache:(id)object;

///磁盘中是否有缓存
- (BOOL)haveDiskCache;

///移除内存中的缓存
- (void)removeMemoryCache;

///移除磁盘中的缓存
- (void)removeDiskCache;

///移除所有缓存
- (void)removeAllCache;

/**
 *  JSON 数据转换成 model
 *
 *  @param JSONString JSON 串
 *
 *  @return 模型
 */
- (id)convertToModel:(NSString *)JSONString;

/**
 *  缓存数据与新数据的操作
 *
 *  @param newObject   新数据
 *  @param oldObject   缓存数据
 *  @param updateCount 更新标志
 *
 *  @return 最新数据（可能是新数据也可能是增量请求获取到的数据加入原缓存数据得到的最新数据）
 */
- (id)operateWithNewObject:(id)newObject
                 oldObject:(id)oldObject
               updateCount:(NSInteger *)updateCount;

/**
 *  是否开发人员自己进行业务逻辑的处理（返回 YES表示自己处理，架构将不进行缓存动作）
 *
 *  @param model 请求获取的数据模型
 *
 *  @return 是否处理
 */
- (BOOL)successForBussiness:(id)model;

/// 保存缓存路径
- (NSString *)savedFilePath;

/// 保存缓存文件夹
- (NSString *)savedFileDirectory;

/// 保存缓存文件名字
- (NSString *)savedFileName;

@end
