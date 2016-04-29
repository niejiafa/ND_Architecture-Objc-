//
//  NDLoctionCenter.m
//  ND_Architecture
//
//  Created by NDMAC on 16/4/29.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDLoctionCenter.h"

@interface NDLoctionCenter () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation NDLoctionCenter

#pragma mark - public

- (void)start {
    
    self.locationManager          = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // 检测是否为 iOS8.0
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [manager stopUpdatingLocation];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loctionCenter:didUpdateAndGetLastCLLocation:)])
    {
        CLLocation *location = [locations lastObject];
        [self.delegate loctionCenter:self didUpdateAndGetLastCLLocation:location];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败");
    
    if ([CLLocationManager locationServicesEnabled] == NO)
    {
        NSLog(@"定位功能关闭");
        if (self.delegate && [self.delegate respondsToSelector:@selector(loctionCenterServerClosed:)])
        {
            [self.delegate loctionCenterServerClosed:self];
        }
        
    }
    else
    {
        NSLog(@"定位功能开启");
        if (self.delegate && [self.delegate respondsToSelector:@selector(loctionCenter:didFailed:)])
        {
            NSLog(@"%@", error);
            [self.delegate loctionCenter:self didFailed:error];
        }
    }
}

- (CLAuthorizationStatus)authorizationStatus
{
    return [CLLocationManager authorizationStatus];
}

@end
