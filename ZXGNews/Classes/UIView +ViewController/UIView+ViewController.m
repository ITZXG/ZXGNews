//
//  BaseButton.m
//  EDU268
//
//  Created by 何可 on 15/11/4.
//  Copyright © 2015年 北京易知路科技有限公司. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next);
    
    return nil;
    
}


@end
