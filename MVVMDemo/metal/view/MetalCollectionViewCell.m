//
//  MetalCollectionViewCell.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/15.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "MetalCollectionViewCell.h"
#import "Metal.h"
@interface MetalCollectionViewCell()
@property (nonatomic,strong) UIImageView * picImageView;

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UILabel * priceLabel;

@property (nonatomic,strong) UILabel * originPriceLabel;

@property (nonatomic,strong) Metal * model;
@end
@implementation MetalCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 1;
    self.layer.borderColor = UIColorFromRGB(0xe1e1e1).CGColor;
    
    self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width)];
    [self.contentView addSubview:self.picImageView];
    
    
    self.nameLabel = [UILabel labelWithTextColor:UIColorFromRGB(0x333333) font:DiyFont(13) textAlignment:NSTextAlignmentLeft text:@""];
    [self.contentView addSubview:self.nameLabel];
    
    
    self.priceLabel = [UILabel labelWithTextColor:UIColorFromRGB(0xd10000) font:DiyFont(14) textAlignment:NSTextAlignmentCenter text:@""];
    [self.contentView addSubview:self.priceLabel];
    
    
    self.originPriceLabel = [UILabel labelWithTextColor:UIColorFromRGB(0x909090) font:DiyFont(12) textAlignment:NSTextAlignmentCenter text:@""];
    [self.contentView addSubview:self.originPriceLabel];
    
    self.cellSubject = [RACSubject subject];
    [self.cellSubject subscribeNext:^(Metal *model) {
        NSString *urlStr = @"";
        if (model.pictures.count>0) {
            urlStr = [[model.pictures firstObject] objectForKey:@"thumbnailPath"];
        }
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@""]];
        
        self.nameLabel.text = model.name;
        [self.nameLabel sizeToFit];
        self.nameLabel.width = self.width -20;
        self.nameLabel.left = 10;
        self.nameLabel.top = self.picImageView.bottom + 10;
        
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
        [self.priceLabel sizeToFit];
        self.priceLabel.left = self.nameLabel.left;
        self.priceLabel.bottom = self.height - 7;
        
        if ([model.marketPrice floatValue]>0) {
            _originPriceLabel.hidden = NO;
            _originPriceLabel.text = [NSString stringWithFormat:@"¥%@",model.marketPrice];
            [_originPriceLabel sizeToFit];
            _originPriceLabel.left = self.priceLabel.right + 8;
            _originPriceLabel.center = CGPointMake(_originPriceLabel.center.x, self.priceLabel.center.y);
        }else{
            _originPriceLabel.hidden = YES;
            
        }

        
    }];
    
    
}

@end
