//
//  ViewController.h
//  PushNotiFireBase
//
//  Created by Afiq Hamdan on 11/8/18.
//  Copyright © 2018 Afiq Hamdan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol VCDelegate <NSObject>
- (void)setNotificationLabelText:(NSString *)string;
@end

@interface ViewController : UIViewController

@property (weak, nonatomic) id <VCDelegate> delegate;
@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) NSString *notificationText;
@property (weak, nonatomic) IBOutlet UIView *notificationView;
@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;


@end

