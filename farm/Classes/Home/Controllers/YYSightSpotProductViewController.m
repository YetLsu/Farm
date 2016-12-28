//
//  YYSightSpotProductViewController.m
//  farm
//
//  Created by wyy on 2016/12/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotProductViewController.h"
#import "YYProductTableViewHeaderView.h"
#import "YYSightSpotProductModel.h"
#import "YYProductDetailTableViewCell.h"

#import "YYProductDetailBottomView.h"

@interface YYSightSpotProductViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) YYSightSpotProductModel *model;

@property (nonatomic, weak) UITableView *tableView;
@end

@implementation YYSightSpotProductViewController
- (instancetype)initWithModel:(YYSightSpotProductModel *)model{
    if (self = [super init]) {
        self.model = model;
        self.title = @"商品详情";
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //增加tableView
    [self addSubViews];
    
}
- (void)addSubViews{
    
    CGFloat bottomViewH = 44;
    YYProductDetailBottomView *bottomView = [[YYProductDetailBottomView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(bottomViewH);
    }];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(bottomView.mas_top);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.backgroundColor = kViewBGColor;

    CGFloat topImageViewH = 235/603.0*kNoNavHeight;
    YYProductTableViewHeaderView *headerView = [[YYProductTableViewHeaderView alloc] initWithTopImageViewH:topImageViewH andFrame:CGRectMake(0, 0, kWidthScreen, 400)];
    self.tableView.tableHeaderView = headerView;
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.tableView);
        make.height.mas_equalTo(400);
    }];
    self.tableView.tableHeaderView.height = 400;
//    self.tableView.tableHeaderView.backgroundColor = [UIColor redColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    __weak YYProductTableViewHeaderView *weakHeaderView = headerView;
    __weak UITableView *weakTableView = tableView;
    [headerView setModel:self.model andCallback:^(CGFloat allHeight) {
        [weakHeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(allHeight);
        }];
        weakTableView.tableHeaderView.height = allHeight;
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYProductDetailTableViewCell *cell = [YYProductDetailTableViewCell productDetailTableViewCellWithTableView:tableView];
    if (indexPath.row == 0) {
        [cell.btn setTitle:@"产品介绍" forState:UIControlStateNormal];
        cell.content = self.model.productIntro;
    }
    else if (indexPath.row == 1){
        [cell.btn setTitle:@"温馨提示" forState:UIControlStateNormal];
        cell.content = self.model.productWarmPrompt;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kY12Margin;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *content = nil;
    if (indexPath.row == 0) {
        content = self.model.productIntro;
    }
    else if (indexPath.row == 1){
        content = self.model.productWarmPrompt;
    }
    UIFont *contentFont = kText18Font11Height;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;
    NSDictionary *attr = @{
                           NSFontAttributeName : contentFont,
                           NSParagraphStyleAttributeName : paragraphStyle,
                           };
    
    CGFloat maxWidth = kWidthScreen - kX12Margin * 2;
    CGFloat contentLabelH = [content calculateHeightStringWithAttr:attr andMaxWidth:maxWidth andMaxHeight:CGFLOAT_MAX] + 1;
    return contentLabelH + kY12Margin * 3 + 25;
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
