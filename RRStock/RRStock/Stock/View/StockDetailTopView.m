//
//  StockDetailTopView.m
//  RRCP
//
//  Created by 人人操盘 on 16/8/22.
//  Copyright © 2016年 renrencaopan. All rights reserved.
//

#import "StockDetailTopView.h"

@interface StockDetailTopView ()

//实时价格
@property(nonatomic, weak) CustomLabel *RealTimePrice;

//今开
@property(nonatomic, weak) CustomLabel *jinOpenPrice;

//今开标题
@property(nonatomic, weak) CustomLabel *jinOpenPriceTitle;

//昨开
@property(nonatomic, weak) CustomLabel *zuoOpenPrice;

@property(nonatomic, weak) CustomLabel *zuoOpenPriceTitle;

//成交量
@property(nonatomic, weak) CustomLabel *chengJiaoLiang;

@property(nonatomic, weak) CustomLabel *chengJiaoLiangTitle;

//换手率
@property(nonatomic, weak) CustomLabel *huanShouLv;

@property(nonatomic, weak) CustomLabel *huanShouLvTitle;

//最高价
@property(nonatomic, weak) CustomLabel *zuiGaoPrice;

@property(nonatomic, weak) CustomLabel *zuiGaoPriceTitle;

//最低价
@property(nonatomic, weak) CustomLabel *zuiDiPrice;

@property(nonatomic, weak) CustomLabel *zuiDiPriceTitle;

//成交额
@property(nonatomic, weak) CustomLabel *chengJiaoE;

@property(nonatomic, weak) CustomLabel *chengJiaoETitle;

//内盘
@property(nonatomic, weak) CustomLabel *neiPanLiang;

@property(nonatomic, weak) CustomLabel *neiPanLiangTitle;

//外盘
@property(nonatomic, weak) CustomLabel *waiPanLiang;

@property(nonatomic, weak) CustomLabel *waiPanLiangTitle;

//总市值
@property(nonatomic, weak) CustomLabel *zongShiZhi;

@property(nonatomic, weak) CustomLabel *zongShiZhiTitle;

//市盈率
@property(nonatomic, weak) CustomLabel *shiYingLv;

@property(nonatomic, weak) CustomLabel *shiYingLvTitle;

//振幅
@property(nonatomic, weak) CustomLabel *zhenFu;

@property(nonatomic, weak) CustomLabel *zhenFuTitle;

//流通市值
@property(nonatomic, weak) CustomLabel *liuTongShiZhi;

@property(nonatomic, weak) CustomLabel *liuTongShiZhiTitle;

@end

@implementation StockDetailTopView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self makeView];
  }
  return self;
}

- (void)makeView {
  self.backgroundColor = [UIColor colorWithRed:28 / 255.0
                                         green:47 / 255.0
                                          blue:65 / 255.0
                                         alpha:1.0];

  CustomLabel *RealTimePrice =
      [CustomLabel setCustomLabelText:@"22.88"
                                 font:40
                            textColor:[UIColor colorWithRateRed]];
  [self addSubview:RealTimePrice];
  self.RealTimePrice = RealTimePrice;

  CustomLabel *jinOpenPriceTitle =
      [CustomLabel setCustomLabelText:@"今开"
                                 font:11
                            textColor:[UIColor colorWithWhite153]];
  [self addSubview:jinOpenPriceTitle];
  self.jinOpenPriceTitle = jinOpenPriceTitle;

  CustomLabel *jinOpenPrice =
      [CustomLabel setCustomLabelText:@"21.90"
                                 font:11
                            textColor:[UIColor whiteColor]];
  [self addSubview:jinOpenPrice];
  self.jinOpenPrice = jinOpenPrice;

  CustomLabel *zuoOpenPriceTitle =
      [CustomLabel setCustomLabelText:@"昨收"
                                 font:11
                            textColor:[UIColor colorWithWhite153]];
  [self addSubview:zuoOpenPriceTitle];
  self.zuoOpenPriceTitle = zuoOpenPriceTitle;

  CustomLabel *zuoOpenPrice =
      [CustomLabel setCustomLabelText:@"21.90"
                                 font:11
                            textColor:[UIColor whiteColor]];
  [self addSubview:zuoOpenPrice];
  self.zuoOpenPrice = zuoOpenPrice;

  CustomLabel *chengJiaoLiangTitle =
      [CustomLabel setCustomLabelText:@"成交量"
                                 font:11
                            textColor:[UIColor colorWithWhite153]];
  [self addSubview:chengJiaoLiangTitle];
  self.chengJiaoLiangTitle = chengJiaoLiangTitle;

  CustomLabel *chengJiaoLiang =
      [CustomLabel setCustomLabelText:@"38.85万手"
                                 font:11
                            textColor:[UIColor whiteColor]];
  [self addSubview:chengJiaoLiang];
  self.chengJiaoLiang = chengJiaoLiang;

  CustomLabel *huanShouLvTitle =
      [CustomLabel setCustomLabelText:@"换手率"
                                 font:11
                            textColor:[UIColor colorWithWhite153]];
  [self addSubview:huanShouLvTitle];
  self.huanShouLvTitle = huanShouLvTitle;

  CustomLabel *huanShouLv =
      [CustomLabel setCustomLabelText:@"10.22%"
                                 font:11
                            textColor:[UIColor whiteColor]];
  [self addSubview:huanShouLv];
  self.huanShouLv = huanShouLv;

  CustomLabel *zuiGaoPriceTitle =
      [CustomLabel setCustomLabelText:@"最高"
                                 font:11
                            textColor:[UIColor colorWithWhite153]];
  [self addSubview:zuiGaoPriceTitle];
  self.zuiGaoPriceTitle = zuiGaoPriceTitle;

  CustomLabel *zuiGaoPrice =
      [CustomLabel setCustomLabelText:@"10.22"
                                 font:11
                            textColor:[UIColor whiteColor]];
  [self addSubview:zuiGaoPrice];
  self.zuiGaoPrice = zuiGaoPrice;

  CustomLabel *zuiDiPriceTitle =
      [CustomLabel setCustomLabelText:@"最低"
                                 font:11
                            textColor:[UIColor colorWithWhite153]];
  [self addSubview:zuiDiPriceTitle];
  self.zuiDiPriceTitle = zuiDiPriceTitle;

  CustomLabel *zuiDiPrice =
      [CustomLabel setCustomLabelText:@"10.22"
                                 font:11
                            textColor:[UIColor whiteColor]];
  [self addSubview:zuiDiPrice];
  self.zuiDiPrice = zuiDiPrice;

  CustomLabel *chengJiaoETitle =
      [CustomLabel setCustomLabelText:@"成交额"
                                 font:11
                            textColor:[UIColor colorWithWhite153]];
  [self addSubview:chengJiaoETitle];
  self.chengJiaoETitle = chengJiaoETitle;

  CustomLabel *chengJiaoE =
      [CustomLabel setCustomLabelText:@"10.22亿"
                                 font:11
                            textColor:[UIColor whiteColor]];
  [self addSubview:chengJiaoE];
  self.chengJiaoE = chengJiaoE;

  CustomLabel *neiPanLiangTitle =
      [CustomLabel setCustomLabelText:@"内盘"
                                 font:11
                            textColor:[UIColor colorWithWhite153]];
  [self addSubview:neiPanLiangTitle];
  self.neiPanLiangTitle = neiPanLiangTitle;

  CustomLabel *neiPanLiang =
      [CustomLabel setCustomLabelText:@"53.00"
                                 font:11
                            textColor:[UIColor whiteColor]];
  [self addSubview:neiPanLiang];
  self.neiPanLiang = neiPanLiang;

  CustomLabel *waiPanLiangTitle =
      [CustomLabel setCustomLabelText:@"外盘"
                                 font:11
                            textColor:[UIColor colorWithWhite153]];
  [self addSubview:waiPanLiangTitle];
  self.waiPanLiangTitle = waiPanLiangTitle;

  CustomLabel *waiPanLiang =
      [CustomLabel setCustomLabelText:@"53.00"
                                 font:11
                            textColor:[UIColor whiteColor]];
  [self addSubview:waiPanLiang];
  self.waiPanLiang = waiPanLiang;

  CustomLabel *zongShiZhiTitle =
      [CustomLabel setCustomLabelText:@"总市值"
                                 font:11
                            textColor:[UIColor colorWithWhite153]];
  [self addSubview:zongShiZhiTitle];
  self.zongShiZhiTitle = zongShiZhiTitle;

  CustomLabel *zongShiZhi =
      [CustomLabel setCustomLabelText:@"53.0亿"
                                 font:11
                            textColor:[UIColor whiteColor]];
  [self addSubview:zongShiZhi];
  self.zongShiZhi = zongShiZhi;

  CustomLabel *shiYingLvTitle =
      [CustomLabel setCustomLabelText:@"市盈率"
                                 font:11
                            textColor:[UIColor colorWithWhite153]];
  [self addSubview:shiYingLvTitle];
  self.shiYingLvTitle = shiYingLvTitle;

  CustomLabel *shiYingLv =
      [CustomLabel setCustomLabelText:@"53.00"
                                 font:11
                            textColor:[UIColor whiteColor]];
  [self addSubview:shiYingLv];
  self.shiYingLv = shiYingLv;

  CustomLabel *zhenFuTitle =
      [CustomLabel setCustomLabelText:@"振幅"
                                 font:11
                            textColor:[UIColor colorWithWhite153]];
  [self addSubview:zhenFuTitle];
  self.zhenFuTitle = zhenFuTitle;

  CustomLabel *zhenFu = [CustomLabel setCustomLabelText:@"5.38%"
                                                   font:11
                                              textColor:[UIColor whiteColor]];
  [self addSubview:zhenFu];
  self.zhenFu = zhenFu;

  CustomLabel *liuTongShiZhiTitle =
      [CustomLabel setCustomLabelText:@"流通市值"
                                 font:11
                            textColor:[UIColor colorWithWhite153]];
  [self addSubview:liuTongShiZhiTitle];
  self.liuTongShiZhiTitle = liuTongShiZhiTitle;

  CustomLabel *liuTongShiZhi =
      [CustomLabel setCustomLabelText:@"87.0亿"
                                 font:11
                            textColor:[UIColor whiteColor]];
  [self addSubview:liuTongShiZhi];
  self.liuTongShiZhi = liuTongShiZhi;

  [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
  [super updateConstraints];

  WEAKSELF(weakSelf);
  [self.RealTimePrice mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf).offset(30);
    make.top.equalTo(weakSelf).offset(10);
  }];

  [self.jinOpenPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakSelf).offset(10);
    make.left.equalTo(weakSelf.mas_centerX).offset(10);
  }];

  [self.jinOpenPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakSelf.jinOpenPriceTitle.mas_bottom).offset(5);
    make.left.equalTo(weakSelf.jinOpenPriceTitle);
  }];

  [self.chengJiaoLiangTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakSelf.jinOpenPrice.mas_bottom).offset(5);
    make.left.equalTo(weakSelf.jinOpenPriceTitle);
  }];

  [self.chengJiaoLiang mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakSelf.chengJiaoLiangTitle.mas_bottom).offset(5);
    make.left.equalTo(weakSelf.chengJiaoLiangTitle);
  }];

  [self.zuoOpenPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakSelf.jinOpenPriceTitle);
    make.right.equalTo(weakSelf).offset(-50);
  }];

  [self.zuoOpenPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakSelf.zuoOpenPriceTitle.mas_bottom).offset(5);
    make.left.equalTo(weakSelf.zuoOpenPriceTitle);
  }];

  [self.huanShouLvTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakSelf.zuoOpenPrice.mas_bottom).offset(5);
    make.left.equalTo(weakSelf.zuoOpenPrice);
  }];

  [self.huanShouLv mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakSelf.huanShouLvTitle.mas_bottom).offset(5);
    make.left.equalTo(weakSelf.zuoOpenPriceTitle);
  }];

  [self.zuiGaoPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf).offset(15);
    make.top.equalTo(weakSelf.chengJiaoLiang.mas_bottom).offset(20);
  }];

  [self.neiPanLiangTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf.zuiGaoPriceTitle);
    make.top.equalTo(weakSelf.zuiGaoPriceTitle.mas_bottom).offset(10);
  }];

  [self.shiYingLvTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf.neiPanLiangTitle);
    make.top.equalTo(weakSelf.neiPanLiangTitle.mas_bottom).offset(10);
  }];

  [self.zuiGaoPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf.shiYingLvTitle.mas_right).offset(10);
    make.centerY.equalTo(weakSelf.zuiGaoPriceTitle);
  }];

  [self.neiPanLiang mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf.zuiGaoPrice);
    make.centerY.equalTo(weakSelf.neiPanLiangTitle);
  }];

  [self.shiYingLv mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf.zuiGaoPrice);
    make.centerY.equalTo(weakSelf.shiYingLvTitle);
  }];

  [self.zuiDiPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(weakSelf.mas_centerX).offset(-10);
    make.centerY.equalTo(weakSelf.zuiGaoPriceTitle);
  }];

  [self.zuiDiPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf.mas_centerX).offset(10);
    make.centerY.equalTo(weakSelf.zuiGaoPriceTitle);
  }];

  [self.waiPanLiangTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf.zuiDiPriceTitle);
    make.centerY.equalTo(weakSelf.neiPanLiangTitle);
  }];

  [self.zhenFuTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf.zuiDiPriceTitle);
    make.centerY.equalTo(weakSelf.shiYingLvTitle);
  }];

  [self.zhenFu mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(weakSelf.zhenFuTitle);
    make.right.equalTo(weakSelf.zuiDiPrice);
  }];

  [self.waiPanLiang mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(weakSelf.waiPanLiangTitle);
    make.right.equalTo(weakSelf.zuiDiPrice);
  }];

  [self.chengJiaoE mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(weakSelf).offset(-15);
    make.centerY.equalTo(weakSelf.zuiGaoPriceTitle);
  }];

  [self.chengJiaoETitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(weakSelf.chengJiaoE.mas_left).offset(-25);
    make.centerY.equalTo(weakSelf.zuiGaoPriceTitle);
  }];

  [self.zongShiZhiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf.chengJiaoETitle);
    make.centerY.equalTo(weakSelf.neiPanLiangTitle);
  }];

  [self.zongShiZhi mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf.chengJiaoE);
    make.centerY.equalTo(weakSelf.zongShiZhiTitle);
  }];

  [self.liuTongShiZhiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf.chengJiaoETitle);
    make.centerY.equalTo(weakSelf.shiYingLvTitle);
  }];

  [self.liuTongShiZhi mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakSelf.chengJiaoE);
    make.centerY.equalTo(weakSelf.liuTongShiZhiTitle);
  }];
}

@end
