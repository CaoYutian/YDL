//
//  SupplierVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/15.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "SupplierVC.h"

@interface SupplierVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation SupplierVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的供应商";
}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT)];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    
}

- (void)reloadDataSource{
    
    
}

- (void)loadData{
    
    EMError *error = nil;
    NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    //    NSArray *userlist = [[EMClient sharedClient].contactManager getContacts];
    if (!error) {
        NSLog(@"获取成功 -- %@", userlist);
        [self.dataSource addObjectsFromArray:userlist];
        if (self.dataSource.count) {
            
            [self.tableView reloadData];
        }else{
            NSLog(@"暂无好友");
        }
        
    }
}

#pragma mark =========================== UITableViewDelegate ===========================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellID = @"UITableviewCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}



- (NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


@end
