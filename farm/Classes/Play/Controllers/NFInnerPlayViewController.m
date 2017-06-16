//
//  NFInnerPlayViewController.m
//  farm
//
//  Created by guest on 17/2/17.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFInnerPlayViewController.h"
#import "NFList1TableViewCell.h"
#import "NFList2TableViewCell.h"
#import "NFMapTableViewCell.h"
#import "NFPastReviewTableViewCell.h"
#import "YYSightSpotRightView.h"
#import "NFInnerHeader.h"
#import "YYSpotDetailViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>

#import "NFPlayModel.h"
#import "NFHeadViewModel.h"
#import "YYSightSpotModel.h"
#import "NFPlayListTwoModel.h"
#import "NFMapModel.h"
#import "NFReviewModel.h"


#define NAVBAR_CHANGE_POINT 55
#define kTopBaseUrl @"http://nc.guonongda.com:8808/app/travelplaying/getFirst.do"
#define kSigntUrl @"http://nc.guonongda.com:8808/app/travelplaying/getSecond1.do"
#define kLikeUrl @"http://nc.guonongda.com:8808/app/travelplaying/getThird.do"
#define kMapUrl @"http://nc.guonongda.com:8808/app/travelplaying/getFourth.do"
#define kReviewUrl @"http://nc.guonongda.com:8808/app/travelplaying/getFifth.do"

@interface NFInnerPlayViewController ()<UITableViewDelegate,UITableViewDataSource,NFList1TableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) YYSightSpotRightView *rightView;
@property (nonatomic, assign) BOOL rightViewShow;
@property (nonatomic, assign) CGFloat rightViewW;
@property (nonatomic, strong) UIButton *tableViewCoverView;

@property (nonatomic, strong) NFInnerHeader *innerHeader;

@property (nonatomic, strong) NSArray *sectionTitleArray;

@end

@implementation NFInnerPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    
    [self setupContent];
    
    [self requestData];
    
}

- (void)requestData{
    NSString *ids = self.model.playModelId;
    NSString *cityCode = self.model.code;
    NSString *lon = self.model.lon;
    NSString *lat = self.model.lat;
    
    NSMutableDictionary *topParameters = [NSMutableDictionary dictionary];
    topParameters[@"id"] = ids;
    topParameters[@"citycode"] = cityCode;
    [NSObject GET:kTopBaseUrl parameters:topParameters progress:nil completionHandler:^(id responseObject, NSError *error) {
        NSDictionary *data = responseObject[@"data"];
        NFHeadViewModel *model = [NFHeadViewModel yy_modelWithDictionary:data];
        _innerHeader.model = model;
    }];
    
    NSMutableDictionary *signtParameter = [NSMutableDictionary dictionary];
    YYUserModel *userModel = [YYUserTool userModel];
    NSLog(@"%@",userModel.name);
    signtParameter[@"username"] = userModel.name;
    signtParameter[@"id"] = ids;
    signtParameter[@"citycode"] = cityCode;
    signtParameter[@"lon"] = lon;
    signtParameter[@"lat"] = lat;
    [NSObject GET:kSigntUrl parameters:signtParameter progress:nil completionHandler:^(id responseObject, NSError *error) {
        NSArray *cellArray = [_tableView visibleCells];
        NFList1TableViewCell *cell = cellArray[0];
        NSArray *data = responseObject[@"data"];
        NSMutableArray *signtArray = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            YYSightSpotModel *model = [YYSightSpotModel yy_modelWithDictionary:dic];
            [signtArray addObject:model];
        }
        cell.signtArray = signtArray;
        [_tableView reloadData];
        
    }];
    
    
    NSMutableDictionary *likeParameter = [NSMutableDictionary dictionary];
    likeParameter[@"lon"] = lon;
    likeParameter[@"lat"] = lat;
    [NSObject GET:kLikeUrl parameters:likeParameter progress:nil completionHandler:^(id responseObject, NSError *error) {
        NSArray *cellArray = [_tableView visibleCells];
        NFList2TableViewCell *cell = cellArray[1];
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *data = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            NFPlayListTwoModel *model = [NFPlayListTwoModel yy_modelWithDictionary:dict];
            [data addObject:model];
        }
        cell.data = data;
        [self.tableView reloadData];
    }];
    
    NSMutableDictionary *mapParameter = [NSMutableDictionary dictionary];
    mapParameter[@"id"] = ids;
    mapParameter[@"lon"] = lon;
    mapParameter[@"lat"] = lat;
    mapParameter[@"citycode"] = cityCode;
    [NSObject GET:kMapUrl parameters:mapParameter progress:nil completionHandler:^(id responseObject, NSError *error) {
        NSArray *data = responseObject[@"data"];
        NSMutableArray *mapArray = [NSMutableArray array];
        for (NSDictionary *dict in data) {
            NFMapModel *mapModel = [NFMapModel yy_modelWithDictionary:dict];
            [mapArray addObject:mapModel];
        }
        NSArray *visibleCells = [_tableView visibleCells];
        NFMapTableViewCell *cell = visibleCells[2];
        cell.data = mapArray;
    }];
    
    NSMutableDictionary *reviewDict = [NSMutableDictionary dictionary];
    reviewDict[@"citycode"] = cityCode;
    [NSObject GET:kReviewUrl parameters:reviewDict progress:nil completionHandler:^(id responseObject, NSError *error) {
        NSArray *dataArray = responseObject[@"data"];
        for (NSDictionary *dict in dataArray) {
            NFReviewModel *model = [NFReviewModel yy_modelWithDictionary:dict];
            [self.datasource addObject:model];
        }
        [_tableView reloadData];
    }];
}


#pragma mark - 懒加载
- (UIButton *)tableViewCoverView{
    if (!_tableViewCoverView) {
        _tableViewCoverView = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, kWidthScreen - self.rightViewW, kNoNavHeight)];
        [_tableViewCoverView bk_addEventHandler:^(id sender) {
            [UIView animateWithDuration:0.2 animations:^{
                self.tableView.x = 0;
                self.rightView.x = kWidthScreen;
                [_tableViewCoverView removeFromSuperview];
                self.rightViewShow = NO;
            }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _tableViewCoverView;
}
- (NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}
#pragma mark - navigation
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}
- (void)setupNavigation{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"play_share.png"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = buttonItem;

}

#pragma mark - 分享
- (void)shareAction{
    NSArray *imageArray = @[[UIImage imageNamed:@"home_1.png"]];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        [shareParams SSDKEnableUseClientShare];
        [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                         message:nil
                                        delegate:nil
                               cancelButtonTitle:@"确定"
                               otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                        message:[NSString stringWithFormat:@"%@",error]
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
                              [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }];
    }

}

#pragma mark - content
- (void)setupContent{
    self.sectionTitleArray = @[@"地图",@"往期回顾"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kRGBAColor(243, 247, 250, 1);
    NFInnerHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"NFInnerHeader" owner:nil options:nil] firstObject];
    self.innerHeader = headerView;
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = headerView;
    
    [_tableView registerNib:[UINib nibWithNibName:@"NFList1TableViewCell" bundle:nil] forCellReuseIdentifier:@"NFList1TableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NFList2TableViewCell" bundle:nil] forCellReuseIdentifier:@"NFList2TableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NFMapTableViewCell" bundle:nil] forCellReuseIdentifier:@"NFMapTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NFPastReviewTableViewCell" bundle:nil] forCellReuseIdentifier:@"NFPastReviewTableViewCell"];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    [self.view addSubview:_tableView];
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightScreen - 44, kWidthScreen, 44)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    CGFloat btnW = kWidthScreen/2.0;
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(0, 0, btnW, 44);
    
    [commentBtn setTitle:@"7" forState:UIControlStateNormal];
    [commentBtn setTitleColor:kRGBAColor(76, 209, 131, 1) forState:UIControlStateNormal];
    [commentBtn setImage:[UIImage imageNamed:@"play_comment.png"] forState:UIControlStateNormal];
    [commentBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [commentBtn addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:commentBtn];
    UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    likeBtn.frame = CGRectMake(kWidthScreen/2.0, 0, btnW, 44);
    [likeBtn setTitle:@"7" forState:UIControlStateNormal];
    [likeBtn setTitleColor:kRGBAColor(76, 209, 131, 1) forState:UIControlStateNormal];
    [likeBtn setImage:[UIImage imageNamed:@"play_like.png"] forState:UIControlStateNormal];
    [likeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [likeBtn addTarget:self action:@selector(likeClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:likeBtn];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kWidthScreen/2.0, 0, 1, 44)];
    line.backgroundColor = kRGBAColor(76, 209, 131, 1);
    [bottomView addSubview:line];
    //增加右边的策划栏
    self.rightViewW = 125 + kX12Margin;
    YYSightSpotRightView *rightView = [[YYSightSpotRightView alloc] initWithTitleArray:@[@"概况", @"猜你喜欢", @"地图",@"往期回顾"] andViewW: self.rightViewW];
    [self.view addSubview:rightView];
    rightView.frame = CGRectMake(kWidthScreen, 0, self.rightViewW, kHeightScreen);
    self.rightView = rightView;
    
    __weak typeof(self) weakSelf = self;
    [self.rightView setYYSightSpotRightViewBlock:^(NSInteger section) {
        [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }];

    
    
    UIButton *listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    listButton.frame = CGRectMake(kWidthScreen - 44 - 10, kHeightScreen - 120 - 44 - 10, 44, 44);
    [listButton setImage:[UIImage imageNamed:@"play_list.png"] forState:UIControlStateNormal];
    [listButton bk_addEventHandler:^(id sender) {
        self.rightViewShow = YES;
        
        [self.view addSubview:self.tableViewCoverView];
        [UIView animateWithDuration:0.2 animations:^{
            
            self.tableView.x = - self.rightViewW;
            self.rightView.x = kWidthScreen - self.rightViewW;
        }];
        
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:listButton];
    
    
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topButton.frame = CGRectMake(kWidthScreen - 44 - 10, kHeightScreen - 120, 44, 44);
    [topButton setImage:[UIImage imageNamed:@"play_top.png"] forState:UIControlStateNormal];
    [topButton addTarget:self action:@selector(topClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topButton];
}

#pragma mark - button click
- (void)commentClick:(UIButton *)button{

}

- (void)likeClick{

}

- (void)listClick{

}

- (void)topClick{
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
}


#pragma mark - datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section != 3) {
        return 1;
    }else{
        return _datasource.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section != 3) {
        return 20;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NFList1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NFList1TableViewCell" forIndexPath:indexPath];
        
        cell.delegate = self;
        return cell;
        
    }else if (indexPath.section == 1){
        NFList2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NFList2TableViewCell" forIndexPath:indexPath];
        
        return cell;
    
    }else if (indexPath.section == 2){
        NFMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NFMapTableViewCell" forIndexPath:indexPath];
        
        return cell;
    }else{
         NFPastReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NFPastReviewTableViewCell" forIndexPath:indexPath];
        if (_datasource.count != 0) {
            
            cell.model = _datasource[indexPath.row];
        }
        
        return cell;
    }
}

#pragma mark - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 140;
    }else if (indexPath.section == 1){
        return 65;
        
    }else if (indexPath.section == 2){
        return 250;
    }else{
        return 260;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section < 2) {
        return nil;
    }
    UIView *viewH = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidthScreen, 40)];
    viewH.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kWidthScreen - 40, 40)];
    titleLabel.text = self.sectionTitleArray[section-2];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor blackColor];
    [viewH addSubview:titleLabel];
    return viewH;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return nil;
    }
    UIView *viewF = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidthScreen, 20)];
    viewF.backgroundColor = kRGBAColor(243, 247, 250, 1);
    return viewF;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section < 2) {
        return 0;
    }else
        return 40;
}


#pragma mark NFList1TableViewCellDelegate
- (void)list1TableViewCell:(NFList1TableViewCell *)cell andModel:(YYSightSpotModel *)model{
    YYSpotDetailViewController *VC = [[YYSpotDetailViewController alloc] initWithSpotModel:model];
    [self.navigationController pushViewController:VC animated:YES];

}

//滚动的时候，动态的改变透明视图的不透明度
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//        UIColor * color = [UIColor whiteColor];
//        CGFloat offsetY = scrollView.contentOffset.y;
//        if (offsetY > NAVBAR_CHANGE_POINT) {
//            CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
//            [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
//        } else {
//            [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
//        }
//    
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
