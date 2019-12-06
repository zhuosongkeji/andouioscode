//
//  RedPacketView.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/4.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PacketModel.h"

typedef void(^cancelBlock)(void);
typedef void(^finishBlock)(float money);

NS_ASSUME_NONNULL_BEGIN

@interface RedPacketView : UIViewController

+(instancetype)ShowRedpacketWithData:(PacketModel *)data cancelBlock:(cancelBlock)cancelBlock finishBlock:(finishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
