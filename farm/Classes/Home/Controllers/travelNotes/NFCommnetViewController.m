//
//  NFCommnetViewController.m
//  farm
//
//  Created by guest on 17/3/2.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFCommnetViewController.h"
#import "NFCommentModel.h"
#import "NFCommentCell.h"

@interface NFCommnetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, copy) NSString *commentNum;

@end
static NSString *const NFCommentCellId = @"NFCommentCellID";
@implementation NFCommnetViewController
- (NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTable];
    
    [self requestData];
    
}
- (void)requestData{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"index"] = @(0);
    parameter[@"discoverid"] = [NSNumber numberWithInt:self.discoverid];
    [NSObject GET:@"http://nc.guonongda.com:8808/app/dc/getDC.do" parameters:parameter progress:nil completionHandler:^(id responseObject, NSError *error) {
//        NSLog(@"%@",responseObject);
        _commentNum = responseObject[@"commentnum"];
        NSArray *dataArray = responseObject[@"data"];
        for (NSDictionary *dict in dataArray) {
            NFCommentModel *model = [NFCommentModel yy_modelWithDictionary:dict];
            [self.datasource addObject:model];
        }
//        NSLog(@"%@",self.datasource);
        [self.tableView reloadData];
    }];

}

- (void)setupTable{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"NFCommentCell" bundle:nil] forCellReuseIdentifier:NFCommentCellId];
    [self.view addSubview:_tableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NFCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NFCommentCellId forIndexPath:indexPath];
    cell.model = _datasource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NFCommentModel *model = _datasource[indexPath.row];
    
    return 40+20+10+model.coDetailsHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidthScreen, 30)];
    header.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, kWidthScreen - 40, 20)];
    label.text = [NSString stringWithFormat:@"%@条评论",_commentNum];
    label.font = [UIFont systemFontOfSize:13];
    [header addSubview:label];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
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
