//
//  ProductionListTableViewCell.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/14.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "ProductionListTableViewCell.h"
#import "ProductionModel.h"
@interface ProductionListTableViewCell()
@property (nonatomic,strong) UIImageView * picImageView;

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UILabel * priceLabel;


@end
@implementation ProductionListTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews{
    
    
    
    self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WDITH - 20, 156)];
    [self.contentView addSubview:self.picImageView];
    
    
    
    self.nameLabel = [UILabel labelWithTextColor:[UIColor blackColor] font:DiyFont(14) textAlignment:NSTextAlignmentLeft text:@""];
    [self.contentView addSubview:self.nameLabel];
    
    
    self.priceLabel = [UILabel labelWithTextColor:[UIColor blackColor] font:DiyFont(14) textAlignment:NSTextAlignmentLeft text:@""];
    [self.contentView addSubview:self.priceLabel];
    
    
    
    self.cellSubject = [RACSubject subject];
    
    
    @weakify(self)
    [self.cellSubject subscribeNext:^(ProductionModel *model) {
        @strongify(self)
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.bannerPath] placeholderImage:[UIImage imageNamed:@""]];
        
        self.nameLabel.text = model.insProductName;
        [self.nameLabel sizeToFit];
        self.nameLabel.left = 27;
        self.nameLabel.top = self.picImageView.bottom + 10;
        
        
        self.priceLabel.text = [NSString stringWithFormat:@"%.2f元起",[model.minPremium floatValue]];
        [self.priceLabel sizeToFit];
        self.priceLabel.left = 15 + 12;
        self.priceLabel.top = self.nameLabel.bottom + 10;
        
        
        
        
    }];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
