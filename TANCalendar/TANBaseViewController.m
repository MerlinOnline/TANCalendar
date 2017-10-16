//
//  TANBaseViewController.m
//  TANCalendar
//
//  Created by merrill on 2017/8/15.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "TANBaseViewController.h"
#import <StoreKit/StoreKit.h>
#import <Social/Social.h>



@interface TANBaseViewController ()<SKStoreProductViewControllerDelegate>

@end

@implementation TANBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNotifications];
}

- (void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidTakeScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification
                                               object:nil];

}

- (void)userDidTakeScreenshot:(NSNotification*)notification
{
    NSLog(@"检测到截屏");
    
    UIImage *image = [UIImage imageWithScreenshot];
    NSArray *images = @[image];
    UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:images applicationActivities:nil];
    [self.navigationController presentViewController:activityController animated:YES completion:nil];
}


#pragma mark - App Store 评分弹框 （方式一要求iOS 10.3 以上版本）

// 加载app 评分弹框
- (void)loadAppStoreController
{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.3) {
        //方式一：应用内弹框，只能评星级，不能写评论
        [SKStoreReviewController requestReview];
    }else{
        //方式二：deep link
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/app/id1095910968?action=write-review"]];
        
        /**
         //方式三：程序内弹出
         SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
         storeProductViewContorller.delegate = self;
         [self presentViewController:storeProductViewContorller animated:YES completion:nil];
         
         NSString *kAppId = @"1095910968";
         [storeProductViewContorller loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:kAppId} completionBlock:^(BOOL result, NSError * _Nullable error) {
         if(error){
         NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
         }else{
         // 模态弹出appstore
         }
         }];
         */
    }
}

//AppStore取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
