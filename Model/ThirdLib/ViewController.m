//
//  ViewController.m
//  chier
//
//  Created by sunmax on 15/12/25.
//  Copyright © 2015年 sunmax. All rights reserved.
//

#import "ViewController.h"
#import "DKView.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DKView * view1 =[[DKView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view1.data =^(DKFilterModel* data){
        NSLog(@"%@",data.clickedButtonText);
    };
    [self.view addSubview:view1];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
