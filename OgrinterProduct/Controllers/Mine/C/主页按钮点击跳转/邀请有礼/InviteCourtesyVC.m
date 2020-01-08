//
//  InviteCourtesyVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "InviteCourtesyVC.h"
#import "UIImage+ZBNExtension.h"

@interface InviteCourtesyVC ()

@property (weak, nonatomic) IBOutlet UIImageView *userIconView;


@end

@implementation InviteCourtesyVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.userIconView.image = [UIImage circleImageNamed:@"yxj"];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
