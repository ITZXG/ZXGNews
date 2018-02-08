//
//  XGPhotoBottomView.h
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/8.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    buttonDownloadType,
    buttonShareType,
    buttonLikeType
}buttonType;
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define photoBottomH  50

@interface XGPhotoBottomView : UIView

@end
