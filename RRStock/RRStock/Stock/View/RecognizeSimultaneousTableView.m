//
//  RecognizeSimultaneousTableView.m
//  RRCP
//
//  Created by 人人操盘 on 16/4/21.
//  Copyright © 2016年 renrencaopan. All rights reserved.
//

#import "RecognizeSimultaneousTableView.h"

@implementation RecognizeSimultaneousTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
