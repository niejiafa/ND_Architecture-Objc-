//
//  NDFeatureSet.m
//  NDService
//
//  Created by NDMAC on 16/3/26.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDFeatureSet.h"

#import "NDService.h"
#import "NDBaseRequest.h"

@implementation NDFeatureSet

#pragma mark - public

+ (NSString *)featureSetName
{
    return NSStringFromClass(self.class);
}

- (void)featureSetWillLoad
{
    
}

- (void)featureSetDidLoad
{
    
}

- (void)featureSetWillUnload
{
    
}

- (void)featureSetDidUnload
{
    
}

- (void)startRequest:(NDBaseRequest *)baseRequest
         requestType:(NSString *)requestType
           parameter:(id)parameter
           otherInfo:(id)otherInfo
       successAction:(void (^)(id object, NDBaseRequest *request))successAction
          failAction:(void (^)(NSError *error, NDBaseRequest *request))failAction
{
    [self.service recordRequestFinishCount:-1];
    
    [baseRequest startWithCompletionBlockWithSuccess:^(NDBaseRequest *request)
     {
         id object = [request currentResponseModel];
         
         if (successAction)
         {
             successAction(object, request);
         }
         
         [self.service serviceResponseCallBack:requestType
                                     parameter:parameter
                                       success:YES
                                        object:object
                                     otherInfo:otherInfo
                        networkSuccessResponse:request.networkSuccessResponse
                           networkFailResponse:request.networkFailResponse];
         
     }failure:^(NDBaseRequest *request)
     {
         id object = request.requestOperation.error;
         
         if (failAction)
         {
             failAction(object, request);
         }
         
         [self.service serviceResponseCallBack:requestType
                                     parameter:parameter
                                       success:NO
                                        object:object
                                     otherInfo:otherInfo
                        networkSuccessResponse:request.networkSuccessResponse
                           networkFailResponse:request.networkFailResponse];
     }];
}

@end
