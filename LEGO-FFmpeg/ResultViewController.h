//
//  ResultViewController.h
//  LEGO-FFmpeg
//
//  Created by 杨庆人 on 2020/8/12.
//  Copyright © 2020 杨庆人. All rights reserved.
//

#import "ViewController.h"
@class ResultControllerCell;
NS_ASSUME_NONNULL_BEGIN

@interface ResultViewController : UIViewController

@end

@interface ResultControllerCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *photo;
@end

NS_ASSUME_NONNULL_END
