//
//  NFMapTableViewCell.m
//  farm
//
//  Created by guest on 17/2/21.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFMapTableViewCell.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NFMapModel.h"

@interface NFMapTableViewCell ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//大头针模型数组
@property (nonatomic, strong) NSMutableArray *annotationArray;
@end


@implementation NFMapTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    //设置地图的样式
    self.map.mapType = MKMapTypeStandard;
    //设置地图的跟随方式
//    self.map.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    self.map.delegate = self;
    
}

- (NSMutableArray *)annotationArray{
    if (_annotationArray == nil) {
        _annotationArray = [NSMutableArray array];
    }
    return _annotationArray;
}

- (void)setData:(NSArray<NFMapModel *> *)data{
    if (_data != data) {
        _data = data;
    }
    for (NFMapModel *model in _data) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake([model.lat doubleValue], [model.lon doubleValue]);
        [self.annotationArray addObject:annotation];
    }
    NFMapModel *model = _data[0];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    double lat = [model.lat doubleValue];
    double lon = [model.lon doubleValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, lon);
    [self.map setRegion:MKCoordinateRegionMake(coordinate, span) animated:YES];
    [self.map addAnnotations:self.annotationArray];
    
    _titleLabel.text = [NSString stringWithFormat:@"%@|%@m",model.address,model.juli];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        return nil;
    }
    static NSString *ID = @"YYMapViewController";
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (!view) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
    }
    //设置标注的图片
    view.image=[UIImage imageNamed:@"spot_map_shop_select_icon"];
    //点击显示图详情视图 必须MJPointAnnotation对象设置了标题和副标题
    view.canShowCallout=YES;
    
    //设置拖拽 可以通过点击不放进行拖拽
    view.draggable=YES;
    return view;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
