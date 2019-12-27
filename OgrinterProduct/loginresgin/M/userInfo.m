//
//  userInfo.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/26.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "userInfo.h"

@interface userInfo ()<NSCoding>

@end

@implementation userInfo

/*@property (nonatomic,strong)NSString *uid;
 @property (nonatomic,strong)NSString *uName;
 @property (nonatomic,strong)NSString *uPsd;
 @property (nonatomic,strong)NSString *uAcct;
 @property (nonatomic,strong)NSString *uPhone;
*/

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.uName forKey:@"uName"];
    
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.uAcct forKey:@"uAcct"];
    
    [aCoder encodeObject:self.uPhone forKey:@"uPhone"];
    
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self = [super init]) {
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.uName = [aDecoder decodeObjectForKey:@"uName"];
        
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.uAcct = [aDecoder decodeObjectForKey:@"uAcct"];
        
        self.uPhone = [aDecoder decodeObjectForKey:@"uPhone"];
        
    }
    return self;
}

@end
