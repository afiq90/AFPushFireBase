//
//  ViewController.m
//  PushNotiFireBase
//
//  Created by Afiq Hamdan on 11/8/18.
//  Copyright © 2018 Afiq Hamdan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize mainView, notificationView, notificationLabel, notificationText;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNotificationLabelText:) name:@"notiText" object:nil];

}

- (void)setNotificationLabelText:(NSNotification*)notification {
    notificationLabel.text = notification.userInfo[@"aps"][@"alert"];
}

- (void)loadMainView {
    mainView = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 400, 400)];
    mainView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:mainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
