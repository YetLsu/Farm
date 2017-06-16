//
//  YYMapHomeViewModel.m
//  lcjfarm
//
//  Created by wyy on 16/6/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYMapViewModel.h"
#import <CoreLocation/CoreLocation.h>
#import "YYUserTool.h"


@interface YYMapViewModel ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLGeocoder *geocoder;

@property (nonatomic, strong) CLLocationManager *manager;

@end


@implementation YYMapViewModel
- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
- (CLLocationManager *)manager{
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
    }
    return _manager;
}
/**
 *  获取当前位置
 */
-(void)getNowLocation{
    self.manager.delegate = self;
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.manager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0 || error) {
            return ;
        }
        CLPlacemark *placemark = [placemarks firstObject];
//        NSLog(@"%@",placemark.addressDictionary);
        if (placemark.name) {
            NSString *cityName = placemark.locality;
      
//            if ([str rangeOfString:@"浙江省绍兴市"].location != NSNotFound) {
//                NSRange range =  [placemark.name rangeOfString:@"浙江省绍兴市"];
//                
//                str = [placemark.name substringFromIndex:range.location + range.length];
//               
//                
//            }
            //保存模型
            YYUserModel *userModel = [YYUserTool userModel];
            if (userModel == nil) {
                userModel = [[YYUserModel alloc] init];
            }
            userModel.userCity = cityName;
            userModel.lon = [NSString stringWithFormat:@"%f", placemark.location.coordinate.longitude];
            userModel.lat = [NSString stringWithFormat:@"%f", placemark.location.coordinate.latitude];
            [YYUserTool saveUserModel:userModel];
            
        //            YYLog(@"定位完成地址为name%@\nthoroughfare%@",placemark.name,placemark.thoroughfare);
            [self.manager stopUpdatingLocation];
        }
    }];
    
}

@end
