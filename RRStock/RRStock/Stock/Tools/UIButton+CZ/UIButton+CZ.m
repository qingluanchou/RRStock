//
//  UIButton+CZ.m
//  RRCP
//
//  Created by 人人操盘 on 15/11/23.
//  Copyright © 2015年 renrencaopan. All rights reserved.
//

#import "UIButton+CZ.h"

@implementation UIButton (CZ)

+ (UIButton *)setCustomButton:(NSString *)title backGroundColor:(UIColor *)backGroundColor backGroundImage:(UIImage *)image textColor:(UIColor *)textColor textFont:(CGFloat)font
{
    UIButton *customButton = [[UIButton alloc] init];
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitleColor:textColor forState:UIControlStateNormal];
    [customButton setBackgroundImage:image forState:UIControlStateNormal];
    [customButton setBackgroundColor:backGroundColor];
    customButton.titleLabel.font = [UIFont systemFontOfSize:font];
    return customButton;
}

+ (UIButton *)setIcon:(UIImage *)image setSelectedIcon:(UIImage *)selectedImage sethighLightIcon:(UIImage *)highLightImage{
    UIButton *customButton = [[UIButton alloc] init];
    [customButton setImage:image  forState:UIControlStateNormal];
    [customButton setImage:selectedImage forState:UIControlStateSelected];
    [customButton setImage:highLightImage forState:UIControlStateHighlighted];
    return customButton;
}

//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    
//    CGFloat x = contentRect.origin.x;
//    CGRect customRect = CGRectMake(x + 5, contentRect.origin.y, contentRect.size.width, contentRect.size.height);
//    
//    return customRect;
//}


@end
