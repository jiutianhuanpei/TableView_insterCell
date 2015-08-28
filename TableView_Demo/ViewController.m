//
//  ViewController.m
//  TableView_Demo
//
//  Created by 沈红榜 on 15/8/28.
//  Copyright (c) 2015年 沈红榜. All rights reserved.
//

#import "ViewController.h"
#import "TempController.h"

@interface ViewController ()

@end

@implementation ViewController {
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];


}

- (IBAction)sendMessage:(id)sender {
    TempController *VC = [[TempController alloc] init];
    [self presentViewController:VC animated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
