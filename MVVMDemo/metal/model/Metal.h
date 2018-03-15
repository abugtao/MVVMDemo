//
//  Metal.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/15.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Metal : NSObject

@property (copy , nonatomic) NSString * merchId;//商品Id

@property (copy , nonatomic) NSString * merchCode;//商品编号

@property (copy , nonatomic) NSString * name;//商品名称

@property (strong,nonatomic) NSDictionary * brand;//品牌信息

@property (copy , nonatomic) NSString * price;//商品价格

@property (copy , nonatomic) NSString * marketPrice;//市场价格

@property (copy , nonatomic) NSString * material;//商品材质(int型)

@property (copy , nonatomic) NSString * material_str;//商品材质(string)

@property (copy , nonatomic) NSString * unit;//计量单位

@property (copy , nonatomic) NSString * weight;//商品重量

@property (copy , nonatomic) NSString * goldWeight;//商品含金量

@property (copy , nonatomic) NSString * spec;//商品规格(string)

@property (copy , nonatomic) NSString * type;//1投资类, 2首饰类, 3工艺类, 4收藏类

@property (copy , nonatomic) NSString * status;//1未提交，2待审核，3审核通过，4审核不通过，5已上架，6已下架

@property (copy , nonatomic) NSString * inventory;//商品库存

@property (copy , nonatomic) NSString * graphicPath;//商品详情

@property (copy , nonatomic) NSString * supplierId;//供应商id

@property (strong,nonatomic) NSArray * pictures;//图片信息

@property (copy , nonatomic) NSString * suppAbbrName;//供应商简称

@property (copy,nonatomic)NSString *suppName;

@property (copy , nonatomic) NSString * publishTime;//发布时间

@property (copy , nonatomic) NSString * upshelfTime;//上架时间

@property (copy , nonatomic) NSString * headPic;//头图地址

@property (copy,nonatomic)NSString *quantity; //商品数量



@property (copy,nonatomic)NSString *editQuantity;//商品编辑的时候存储编辑数量


@property (assign,nonatomic) BOOL isSelected;



@property (copy,nonatomic)NSString *isPreSale; //是否预售商品：1否，2是



@property (copy,nonatomic)NSString *salesStartTime;//

@property (copy,nonatomic)NSString *salesEndTime;//

@property (copy,nonatomic) NSString * bonus; //奖金


@property (strong,nonatomic) NSDictionary * seckillInfo;//秒杀相关

@property (copy,nonatomic) NSString * systemTime; //系统时间

@end
