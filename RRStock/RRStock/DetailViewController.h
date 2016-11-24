//
//  DetailViewController.h
//  RRStock
//
//  Created by 曾文亮 on 16/11/24.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

