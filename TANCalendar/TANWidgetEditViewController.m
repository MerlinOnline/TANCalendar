//
//  TANWidgetEditViewController.m
//  TANCalendar
//
//  Created by merrill on 2017/8/15.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "TANWidgetEditViewController.h"
#import "TANDataManager.h"

@interface TANWidgetEditViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) UITextField *inputView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TANWidgetEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"widget 编辑";
    self.dataSource = [[NSMutableArray alloc] initWithArray:[TANDataManager shareManager].dataSource];
        
    UITextField *inputView = [[UITextField alloc] initWithFrame:CGRectMake(20, 84, kScreenWidth - 100, 40)];
    inputView.placeholder = @"请输入文字";
    [self.view addSubview:inputView];
    self.inputView = inputView;
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(kScreenWidth - 80, 84, 60, 40);
    saveButton.layer.cornerRadius = 4;
    saveButton.layer.masksToBounds = YES;
    saveButton.backgroundColor = [UIColor redColor];
    saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton setTitle:@"SAVE" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, kScreenHeight- 200) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView setEditing:YES animated:YES];
    
}

- (void)saveButtonClick:(id)sender
{
    NSString *inputText = self.inputView.text;
    [self.dataSource addObject:inputText];
    [TANDataManager shareManager].dataSource = self.dataSource;
    [self.inputView resignFirstResponder];
    self.inputView.text = @"";
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 首先修改model
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [TANDataManager shareManager].dataSource = self.dataSource;
        // 之后更新view
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

}

//是否允许indexPath的cell移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //更新数据源
    [self.dataSource exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    [TANDataManager shareManager].dataSource = self.dataSource;

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
