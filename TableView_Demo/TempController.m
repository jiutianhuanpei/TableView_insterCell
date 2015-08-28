
//
//  TempController.m
//  TableView_Demo
//
//  Created by 沈红榜 on 15/8/28.
//  Copyright (c) 2015年 沈红榜. All rights reserved.
//

#import "TempController.h"

@interface TempController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@end

@implementation TempController {
    UITableView         *_tableView;
    
    UIView              *_inputView;
    UITextField         *_textField;
    UIButton            *_sendBtn;
    
    NSMutableArray      *_dataArray;
    NSMutableArray      *_heights;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    _heights = [[NSMutableArray alloc] initWithCapacity:0];
    
    CGFloat height = CGRectGetHeight(self.view.frame);
    CGFloat width = CGRectGetWidth(self.view.frame);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width, height - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.contentOffset = CGPointMake(0, 100);
    _tableView.tableFooterView = [UIView new];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    

    
    _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 60, width, 60)];
    _inputView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_inputView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, width - 100, 40)];
    _textField.layer.cornerRadius = 3;
    _textField.layer.masksToBounds = true;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.delegate = self;
    [_inputView addSubview:_textField];
    
    _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendBtn setTitle:@"Send" forState:UIControlStateNormal];
    _sendBtn.frame = CGRectMake(width - 60, 10, 50, 40);
    [_sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [_inputView addSubview:_sendBtn];
}

- (void)sendMessage {
    NSString *title = _textField.text;
    [_dataArray insertObject:title atIndex:0];
    
    NSInteger height = arc4random() % 100 + 20;
    [_heights insertObject:@(height) atIndex:0];
    
    CGPoint offSet = _tableView.contentOffset;
    offSet.y += height;
    
    [UIView setAnimationsEnabled:false];
    [_tableView setContentOffset:offSet animated:false];
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    [UIView setAnimationsEnabled:true];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    cell.textLabel.text = (NSString *)_dataArray[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_heights[indexPath.row] floatValue];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:true];
    return true;
}

- (void)showKeyboard:(NSNotification *)nofi {
    CGRect keyBoardRect=[nofi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    
    CGFloat height = CGRectGetHeight(self.view.frame);
    _inputView.frame = CGRectMake(0, height - deltaY - 58, CGRectGetWidth(self.view.frame), 58);
    
}

- (void)hiddenKeyboard:(NSNotification *)nofi {
    CGFloat height = CGRectGetHeight(self.view.frame);
    _inputView.frame = CGRectMake(0, height - 58, CGRectGetWidth(self.view.frame), 58);
}

@end
