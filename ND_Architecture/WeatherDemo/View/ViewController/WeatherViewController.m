//
//  WeatherViewController.m
//  ND_Architecture
//
//  Created by NDMAC on 16/4/29.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "WeatherViewController.h"

#import "NDLoctionCenter.h"
#import "WeatherPresenter.h"
#import "WeatherModel.h"
#import "WeatherListModel.h"
#import "NSArray+ND.h"

@interface WeatherViewController () <LoctionCenterDelegate, WeatherPresenterDelegate>

@property (nonatomic, strong) NDLoctionCenter *loctionCenter;
@property (nonatomic, strong) WeatherPresenter *presenter;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *skyLabel;

@end

@implementation WeatherViewController

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.loctionCenter start];
    
    self.addressLabel.text = @"加载中...";
    self.skyLabel.text = @"加载中...";
}

#pragma mark - overwrite

#pragma mark - public

#pragma mark - delegate

#pragma mark -- WeatherPresenterDelegate

-(void)weatherPresenter:(WeatherPresenter *)presenter requestLocationWeatherInfoSuccess:(BOOL)success
{
    if (success)
    {
        self.addressLabel.text = [NSString stringWithFormat:@"地点:%@",self.presenter.weatherModel.name];
        
        WeatherListModel *weatherListModel = [self.presenter.weatherModel.weather nd_objectWithIndex:0];
        self.skyLabel.text = [NSString stringWithFormat:@"天气:%@",weatherListModel.weatherDescription];
    }
    else
    {
        self.addressLabel.text = @"加载失败";
        self.skyLabel.text = @"加载失败";
    }
}

#pragma mark -- LoctionCenterDelegate

- (void)loctionCenter:(NDLoctionCenter *)loctionCenter didUpdateAndGetLastCLLocation:(CLLocation *)location
{
    NSLog(@"定位成功");
    
    [self.presenter requestLocationWeatherInfoWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
}

- (void)loctionCenter:(NDLoctionCenter *)loctionCenter didFailed:(NSError *)error
{
    NSLog(@"定位失败");
    
    self.addressLabel.text = @"定位失败";
    self.skyLabel.text = @"定位失败";
}

- (void)loctionCenterServerClosed:(NDLoctionCenter *)loctionCenter
{
    NSLog(@"定位功能关闭");
    
    self.addressLabel.text = @"定位功能关闭";
    self.skyLabel.text = @"定位功能关闭";
}

#pragma mark - notification

#pragma mark - event response

#pragma mark - private

#pragma mark - getter and setter

- (NDLoctionCenter *)loctionCenter
{
    if (_loctionCenter)
    {
        return _loctionCenter;
    }
    
    _loctionCenter = [[NDLoctionCenter alloc] init];
    _loctionCenter.delegate = self;
    
    return _loctionCenter;
}

- (WeatherPresenter *)presenter
{
    if (_presenter)
    {
        return _presenter;
    }
    
    _presenter = [[WeatherPresenter alloc] init];
    _presenter.delegate = self;
    
    return _presenter;
}

@end
