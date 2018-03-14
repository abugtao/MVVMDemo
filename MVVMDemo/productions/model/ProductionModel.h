//
//  ProductionModel.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/14.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductionModel : NSObject

@property (copy,nonatomic)NSString *insProductId;

@property (copy,nonatomic)NSString *bannerPath;//picurl

@property (copy,nonatomic)NSString *insProductName;

@property (copy,nonatomic)NSString *minPremium; //起购金额

@property (copy,nonatomic)NSString *productDesc;  //备注

@property (copy,nonatomic)NSString *maxInsured; //最高保额


@property (copy,nonatomic)NSString *issuId;  //保险公司id


@property (copy,nonatomic)NSString *insuranceType; //保险type

@end
