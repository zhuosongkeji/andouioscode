//
//  OrderlModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/3.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "OrderlModel.h"
#import "OrderListModel.h"

@implementation OrderlModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    OrderlModel *model = [[OrderlModel alloc]init];
    
    model.spid = [NSString stringWithFormat:@"%@",dict[@"id"]];
    model.order_sn = [NSString stringWithFormat:@"%@",dict[@"order_sn"]];
    model.allnum = [NSString stringWithFormat:@"%@",dict[@"allnum"]];
    
    model.pay_way = [NSString stringWithFormat:@"%@",dict[@"pay_way"]];
    model.pay_money = [NSString stringWithFormat:@"%@",dict[@"pay_money"]];
    
    model.address_id = [NSString stringWithFormat:@"%@",dict[@"address_id"]];
    model.integral = [NSString stringWithFormat:@"%@",dict[@"integral"]];
    model.pay_time = [NSString stringWithFormat:@"%@",dict[@"pay_time"]];
    model.status = [NSString stringWithFormat:@"%@",dict[@"status"]];


    NSArray *array = dict[@"details"];
    
    NSMutableArray *detailsArr = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i ++) {
        NSDictionary *detailsdict = array[i];
        OrderListModel *models = [[OrderListModel alloc]init];
        NSMutableString *sKeyStr = [[NSMutableString alloc]init];
        models.detailsnum = [NSString stringWithFormat:@"%@",detailsdict[@"num"]];
        models.detailsimg = [NSString stringWithFormat:@"%@%@",imgServer,detailsdict[@"img"]];
        models.detailshipping_free = [NSString stringWithFormat:@"%@",detailsdict[@"shipping_free"]];
        models.detailsname = [NSString stringWithFormat:@"%@",detailsdict[@"name"]];
        models.detailsprice = [NSString stringWithFormat:@"%@",detailsdict[@"price"]];
        NSArray *jArr = detailsdict[@"attr_value"];
        
        for (int j = 0; j < [jArr count]; j ++) {
            if (j == [jArr count] - 1)
                [sKeyStr appendString:[NSString stringWithFormat:@"%@",jArr[j]]];
            else
                [sKeyStr appendString:[NSString stringWithFormat:@"%@-",jArr[j]]];
        }
        
        models.detailsggStr = [NSString stringWithString:sKeyStr];
        
        models.tatolMamey = [NSString stringWithFormat:@"%ld",[detailsdict[@"num"] integerValue] *[detailsdict[@"price"] integerValue]];
        
        [detailsArr addObject:models];
    }

    NSDictionary *userDict = dict[@"userinfo"];

    model.area = [NSString stringWithFormat:@"%@",userDict[@"area"]];
    
    model.province = [NSString stringWithFormat:@"%@",userDict[@"province"]];
    model.city = [NSString stringWithFormat:@"%@",userDict[@"city"]];
    model.address = [NSString stringWithFormat:@"%@",userDict[@"address"]];
    model.mobile = [NSString stringWithFormat:@"%@",userDict[@"mobile"]];
    model.name = [NSString stringWithFormat:@"%@",userDict[@"name"]];
    
    model.listArr = detailsArr;

    return model;
}


+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
