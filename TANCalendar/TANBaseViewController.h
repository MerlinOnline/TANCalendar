//
//  TANBaseViewController.h
//  TANCalendar
//
//  Created by merrill on 2017/8/15.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImage+TANImage.h"

#define kScreenSize [UIScreen mainScreen].bounds.size
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenScale [UIScreen mainScreen].bounds.size.width / 375.0

#define RGB(r,g,b) [UIColor rgbColorWithRed:r green:g blue:b]
#define RGBA(r,g,b,a) [UIColor rgbColorWithRed:r green:g blue:b alpha:a]
#define RGB_HEX(rgb) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0]
#define RGBA_HEX(rgb,a) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:a]

@interface TANBaseViewController : UIViewController

- (void)loadAppStoreController;

@end
