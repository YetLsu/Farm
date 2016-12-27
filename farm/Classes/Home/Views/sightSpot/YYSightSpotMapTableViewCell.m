//
//  YYSightSpotMapView.m
//  farm
//
//  Created by wyy on 2016/12/26.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotMapTableViewCell.h"
#import "YYSightSpotModel.h"
#import <MapKit/MapKit.h>


@interface YYSightSpotMapTableViewCell ()<MKMapViewDelegate>
@property (nonatomic, strong) CLGeocoder *geocoder;

@property (nonatomic, strong) CLLocationManager *manager;
/**
 *  地图
 */
@property (nonatomic, weak) MKMapView *mapView;

@property (nonatomic, strong) YYSightSpotModel *model;

@end
@implementation YYSightSpotMapTableViewCell
- (instancetype)initWithSpotModel:(YYSightSpotModel *)model{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]) {
        
        self.model = model;
        //增加mapView
        MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:mapView];
        self.mapView = mapView;
        [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(kX12Margin);
            make.right.mas_equalTo(self.contentView).mas_offset(-kX12Margin);
            make.top.bottom.mas_equalTo(self.contentView);
        }];
        
        [self.mapView bk_whenTouches:1 tapped:1 handler:^{
            if (self.YYMapBlock) {
                self.YYMapBlock();
            }
        }];
        //设置地图的样式
        self.mapView.mapType = MKMapTypeStandard;
        //设置地图的跟随方式
        self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
        self.mapView.delegate = self;
        MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.model.cityLat, self.model.cityLon);
        [self.mapView setRegion:MKCoordinateRegionMake(coordinate, span) animated:YES];
        
        [self addAnnotation];
    }
    return self;

}

/**
 *  添加大头针
 *
 */
- (void)addAnnotation{
    MKPointAnnotation *myannotation = [[MKPointAnnotation alloc] init];
    myannotation.coordinate = CLLocationCoordinate2DMake(self.model.cityLat, self.model.cityLon);
    myannotation.title = self.model.spotTitle;
    
    [self.mapView addAnnotation:myannotation];
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
