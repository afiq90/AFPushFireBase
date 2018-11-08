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

    [self setNotificationLabelText:notificationText];
    NSUserDefaults *notiString = [NSUserDefaults standardUserDefaults];
    notificationText = [notiString objectForKey:@"notiString"];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hello:) name:@"notiText" object:nil];

    
//    if (notificationText == nil) {
//        [self setNotificationLabelText:@"janji"];
//    } else {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hello:) name:@"notiText" object:nil];
////         [self setNotificationLabelText:notificationText];
//    }

}

- (void)hello:(NSNotification*)notification {
    NSLog(@"string aaa: %@", notificationText);
    notificationLabel.text = notification.userInfo[@"aps"][@"alert"];

}

- (void)setNotificationLabelText:(NSString*)string {
//    NSLog(@"string: %@", string);
    notificationLabel.text = string;
//    [self.delegate setNotificationLabelText:<#(NSString *)#>];
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
