//
//  ZBNAddressChangeVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/13.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNAddressChangeVC.h"
#import "ZBNMyAddressModel.h"
#import "ZHFAddTitleAddressView.h"
#import "ZBNLocationSearchVC.h"

@interface ZBNAddressChangeVC () <ZHFAddTitleAddressViewDelegate>

@property(nonatomic,strong)ZHFAddTitleAddressView * addTitleAddressView;
/*! 联系人 */
@property (weak, nonatomic) IBOutlet UITextField *name;
/*! 电话号码 */
@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UIButton *chooseAddBtn;

/*! 详细地址 */
@property (weak, nonatomic) IBOutlet UITextField *DetailAddress;
/*! 是否设置为默认地址 */
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;

@property (nonatomic, copy) NSString *IDArea;

@end

@implementation ZBNAddressChangeVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.IDArea = self.addM.area_id;
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
    
    
    
    
    
    // 设置UI
    [self setupUI];

}


/*! 点击定位 */
- (IBAction)searchAddBtnClick:(id)sender {
    ADWeakSelf;
    ZBNLocationSearchVC * vc = [[ZBNLocationSearchVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.selectedAddressTask = ^(NSString * _Nonnull address, NSString * _Nonnull areaID,NSString * _Nonnull province) {
        [weakSelf.DetailAddress setText:address];
        [weakSelf.chooseAddBtn setTitle:province forState:UIControlStateNormal];
        weakSelf.IDArea = areaID;
    };
}


-(void)cancelBtnClick:(NSString *)titleAddress titleID:(NSString *)titleID{
    
    NSLog( @"%@", [NSString stringWithFormat:@"打印的对应省市县的id=%@",titleID]);
    if (titleID.length > 6) {
        [self.chooseAddBtn setTitle:titleAddress forState:UIControlStateNormal];
        self.IDArea = [titleID substringFromIndex:titleID.length - 6];
    } else {
        [self.chooseAddBtn setTitle:@"点击选择" forState:UIControlStateNormal];
    }
    
}



- (void)setupUI
{

    [self.chooseAddBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@",self.addM.province,self.addM.city,self.addM.area] forState:UIControlStateNormal];
    self.defaultBtn.selected = self.addM.is_defualt;
    self.name.text = self.addM.name;
    self.phone.text = self.addM.mobile;
    self.DetailAddress.text = self.addM.address;
   
}


/*! 确认修改点击 */
- (IBAction)changeBtn:(id)sender {
    // 发起修改地址请求
    [self changeAddressRequest];
    
}


- (IBAction)defaultBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.addM setIs_defualt:YES];
    } else {
        [self.addM setIs_defualt:NO];
    }
    
}

- (IBAction)chooseBtnClick:(UIButton *)sender {
    [self.addTitleAddressView addAnimate];
}


- (void)changeAddressRequest
{
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = self.addM.ID;
    param[@"uid"] = unmodel.uid;
    param[@"token"] = unmodel.token;
    param[@"name"] = self.name.text;
    param[@"mobile"] = self.phone.text;
    param[@"area_id"] = self.IDArea;
    param[@"address"] = self.DetailAddress.text;
    if (self.addM.is_defualt) {
        param[@"is_defualt"] = @"1";
    } else {
        param[@"is_defualt"] = @"0";
    }
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/Usersaddress/address_edit" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
           
           if ([[serverInfo.response objectForKey:@"code"] integerValue] == 200) {
               
               [HUDManager showTextHud:@"添加成功"];
               [[NSNotificationCenter defaultCenter] postNotificationName:@"changeOK" object:nil];
               [self.navigationController popViewControllerAnimated:YES];
               
           }
           if ([[serverInfo.response objectForKey:@"code"] integerValue] == 201) {
                      
                      [HUDManager showTextHud:@"请填写完整"];
                      
                  }
       }];
}


@end
