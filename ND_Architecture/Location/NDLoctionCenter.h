//
//  NDLoctionCenter.h
//  ND_Architecture
//
//  Created by NDMAC on 16/4/29.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@class NDLoctionCenter;

@protocol LoctionCenterDelegate <NSObject>

@optional

- (void)loctionCenter:(NDLoctionCenter *)loctionCenter didUpdateAndGetLastCLLocation:(CLLocation *)location;
- (void)loctionCenter:(NDLoctionCenter *)loctionCenter didFailed:(NSError *)error;
- (void)loctionCenterServerClosed:(NDLoctionCenter *)loctionCenter;

@end

@interface NDLoctionCenter : NSObject

@property (nonatomic, weak) id <LoctionCenterDelegate> delegate;
@property (nonatomic, readonly) CLAuthorizationStatus authorizationStatus;

- (void)start;

@end
