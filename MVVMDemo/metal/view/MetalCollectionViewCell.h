//
//  MetalCollectionViewCell.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/15.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetalCollectionViewCell : UICollectionViewCell


@property (nonatomic,strong) RACSubject * cellSubject;
@end
