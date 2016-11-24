//
//  CustomButton.m
//  RRCP
//
//  Created by 人人操盘 on 16/6/7.
//  Copyright © 2016年 renrencaopan. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(self.frame, point))
    {
        return NO;
    }
    return [super pointInside:point withEvent:event];
}

@end
