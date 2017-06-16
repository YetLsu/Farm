//
//  NFMyCollectionViewController.m
//  farm
//
//  Created by guest on 17/2/27.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFMyCollectionViewController.h"
#import "NFMyCollectionCell.h"

@interface NFMyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) NSMutableArray *datasource;
@end


static NSString *const myCollectionCellId = @"myCollectionCellId";
@implementation NFMyCollectionViewController

- (NSMutableArray *)datasource{
    if (_datasource != nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    
    _tabelView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    [_tabelView registerNib:[UINib nibWithNibName:@"NFMyCollectionCell" bundle:nil] forCellReuseIdentifier:myCollectionCellId];
    _tabelView.rowHeight = 230.f;
    
    [self.view addSubview:_tabelView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NFMyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:myCollectionCellId forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
