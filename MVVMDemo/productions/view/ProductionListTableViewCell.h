//
//  ProductionListTableViewCell.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/14.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductionListTableViewCell : UITableViewCell
@property (nonatomic,strong) RACSubject *cellSubject;
@end
