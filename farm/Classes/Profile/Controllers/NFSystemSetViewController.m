//
//  NFSystemSetViewController.m
//  farm
//
//  Created by guest on 17/2/25.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFSystemSetViewController.h"

@interface NFSystemSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) CGFloat cacaheFileSize;
@end

@implementation NFSystemSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kRGBAColor(243, 247, 250, 1);
    _titleArray = @[@"清楚缓存",@"意见反馈",@"关于我们"];
    _imageArray = @[@"me_clear_cache.png",@"me_advice.png",@"me_about_us.png"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidthScreen, 44*3)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44;
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self caculateCache];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"csysellid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"csysellid"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    if (indexPath.row == 0) {
//        [self caculateCache];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM",self.cacaheFileSize];
    }
    return cell;
}
- (void)caculateCache{
    NSString *homePath = NSHomeDirectory();
//    NSLog(@"homePath :%@",homePath);
    NSString *cachesPath = [homePath stringByAppendingPathComponent:@"Library/Caches/default/com.hackemist.SDWebImageCache.default"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *filenames = [fileManager subpathsOfDirectoryAtPath:cachesPath error:&error];
    if (error) {
        NSLog(@"error");
    }
    
    unsigned long long sum = 0;
    for (NSString *filename in filenames) {
        NSString *filePath = [cachesPath stringByAppendingPathComponent:filename];
        
        NSDictionary *attributesDic = [fileManager attributesOfItemAtPath:filePath error:nil];
        
        unsigned long long size = [attributesDic fileSize];
        
        sum += size;
        
    }
    self.cacaheFileSize = sum/1024./1024.;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [[SDImageCache sharedImageCache] clearDisk];
        
        [self performSelector:@selector(caculateCache) withObject:nil afterDelay:0.3];
    }

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
