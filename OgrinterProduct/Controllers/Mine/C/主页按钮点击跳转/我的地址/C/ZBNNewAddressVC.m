//
//  ZBNNewAddressVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNNewAddressVC.h"

#import "ZHFAddTitleAddressView.h"


@interface ZBNNewAddressVC () <ZHFAddTitleAddressViewDelegate>


@property (nonatomic, assign) NSString *IDArea;

@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

@property(nonatomic,strong)ZHFAddTitleAddressView * addTitleAddressView;

/*! 地址详情 */
@property (weak, nonatomic) IBOutlet UITextField *detailAddTex;
/*! 默认地址按钮 */
@property (weak, nonatomic) IBOutlet UIButton *defultAddBtn;
/*! 收货人 */
@property (weak, nonatomic) IBOutlet UITextField *reciveGoodsP;
/*! 收货人号码 */
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

@property (nonatomic, assign) NSNumber *is_defualt;


@end

@implementation ZBNNewAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新增地址";

   
   
    self.addTitleAddressView = [[ZHFAddTitleAddressView alloc]init];
     self.addTitleAddressView.title = @"选择地址";
    self.addTitleAddressView.delegate1 = self;
    self.addTitleAddressView.defaultHeight = 350;
    self.addTitleAddressView.titleScrollViewH = 37;
    if (self.addTitleAddressView.titleIDMarr.count > 0) {
         self.addTitleAddressView.isChangeAddress = true;
     }
     else{
         self.addTitleAddressView.isChangeAddress = false;
     }
    
     [self.view addSubview:[self.addTitleAddressView initAddressView]];
    
    self.is_defualt = @0;

}

-(void)cancelBtnClick:(NSString *)titleAddress titleID:(NSString *)titleID{
    [self.addressBtn setTitle:titleAddress forState:UIControlStateNormal];
    NSLog( @"%@", [NSString stringWithFormat:@"打印的对应省市县的id=%@",titleID]);
    self.IDArea = [titleID substringFromIndex:titleID.length - 6];
}

/*! 默认地址按钮的点击 */
- (IBAction)defultBtnClick:(UIButton *)sender {
        
//    sender.selected = !sender.selected;
    self.defultAddBtn.selected = !self.defultAddBtn.selected;
    if (self.defultAddBtn.selected) {
        self.is_defualt = @1;
    } else {
        self.is_defualt = @0;
    }
}


/*! 新增地址按钮的点击 */
- (IBAction)newAddressBtnClick:(UIButton *)sender {
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = unmodel.uid;
    param[@"token"] = unmodel.token;
    param[@"name"] = self.reciveGoodsP.text;
    param[@"mobile"] = self.phoneNum.text;
    param[@"area_id"] = self.IDArea;
    param[@"address"] = self.detailAddTex.text;
    if (self.is_defualt) {
        param[@"is_defualt"] = self.is_defualt;
    } else {
        self.is_defualt = @0;
        param[@"is_defualt"] = self.is_defualt;
    }
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/Usersaddress/address_add" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        if ([[serverInfo.response objectForKey:@"code"] integerValue] == 200) {
            [HUDManager showTextHud:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"popView" object:nil];
        }
        if ([[serverInfo.response objectForKey:@"code"] integerValue] == 201) {
                   
                   [HUDManager showTextHud:@"请填写完整"];
                   
               }
        
    }];
    
   
    
}


- (IBAction)addBtnClick:(UIButton *)sender {
     [self.addTitleAddressView addAnimate];
}



@end
