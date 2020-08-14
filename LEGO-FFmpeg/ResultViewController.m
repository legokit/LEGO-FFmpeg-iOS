//
//  ResultViewController.m
//  LEGO-FFmpeg
//
//  Created by 杨庆人 on 2020/8/12.
//  Copyright © 2020 杨庆人. All rights reserved.
//

#import "ResultViewController.h"
#import "ViewController.h"

@interface ResultViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ResultViewController

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowlayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        flowlayout.minimumLineSpacing = 10;
        flowlayout.minimumInteritemSpacing = 10;
        flowlayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 2.0 - 50, [UIScreen mainScreen].bounds.size.width / 2.0 - 50);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[ResultControllerCell class] forCellWithReuseIdentifier:@"ResultControllerCell"];
        _collectionView.backgroundColor = UIColor.whiteColor;
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        _dataArray = [NSMutableArray arrayWithArray:[fileManager contentsOfDirectoryAtPath:[ViewController getFFmpegPathCache] error:nil]];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ResultControllerCell *cell = (ResultControllerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ResultControllerCell" forIndexPath:indexPath];
    NSString *imageName = self.dataArray[indexPath.row];
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",[ViewController getFFmpegPathCache],imageName]];
    cell.photo = image;
    return cell;
}

@end

@interface ResultControllerCell ()
@property (nonatomic, strong) UIImageView *photoView;
@end

@implementation ResultControllerCell

- (UIImageView *)photoView
{
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _photoView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.photoView];
        self.photoView.frame = self.bounds;
    }
    return self;
}

- (void)setPhoto:(UIImage *)photo
{
    _photo = photo;
    self.photoView.image = photo;
}

@end

