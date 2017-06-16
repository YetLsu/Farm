//
//  NFReadFirstViewController.m
//  farm
//
//  Created by guest on 17/2/27.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFReadFirstViewController.h"
#import "YYSightSpotModel.h"
#import "NFAfterReadViewController.h"


@interface NFReadFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation NFReadFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBAColor(243, 247, 250, 1);
    self.title = @"行前必读";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _titleArray = @[@"了解这里",@"重要提示",@"活动"];
    _imageArray = @[@"home_read_before.png",@"home_message.png",@"home_activity.png"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidthScreen, 44*3)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44.0f;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"readcellid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"readcellid"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)  indexPath{
    NFAfterReadViewController *vc = [[NFAfterReadViewController alloc] init];
    vc.tag = _titleArray[indexPath.row];
    vc.spotid = self.model.spotID;
    [self.navigationController pushViewController:vc animated:YES];
}


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
