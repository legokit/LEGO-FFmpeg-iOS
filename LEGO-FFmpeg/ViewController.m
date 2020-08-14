//
//  ViewController.m
//  LEGO-FFmpeg
//
//  Created by 杨庆人 on 2020/8/12.
//  Copyright © 2020 杨庆人. All rights reserved.
//

#import "ViewController.h"
#import "ffmpeg.h"
#import "ResultViewController.h"
#import "LEGOAVPlayerView.h"

@interface ViewController ()
@property (nonatomic, strong) LEGOAVPlayerView *playerView;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;
@property (nonatomic, strong) UIButton *button5;
@property (nonatomic, strong) UIButton *button6;
@property (nonatomic, strong) UIButton *button7;

@end

@implementation ViewController

- (UIButton *)button1
{
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitle:@"生成图片帧(movie->images)" forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button1.titleLabel.font = [UIFont systemFontOfSize:15];
        _button1.frame = CGRectMake(self.view.bounds.size.width / 2.0 - 200/2.0, CGRectGetMaxY(self.playerView.frame) + 20, 200, 30);
        [_button1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}

- (UIButton *)button2
{
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:@"生成图片帧(0:0:01-0:0:02)" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button2.titleLabel.font = [UIFont systemFontOfSize:15];
        _button2.frame = CGRectMake(self.view.bounds.size.width / 2.0 - 200/2.0, CGRectGetMaxY(self.button1.frame) + 20, 200, 30);
        [_button2 addTarget:self action:@selector(button2Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}

- (UIButton *)button3
{
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button3 setTitle:@"截取视频（movie->movie）" forState:UIControlStateNormal];
        [_button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button3.titleLabel.font = [UIFont systemFontOfSize:15];
        _button3.frame = CGRectMake(self.view.bounds.size.width / 2.0 - 200/2.0, CGRectGetMaxY(self.button2.frame) + 20, 200, 30);
        [_button3 addTarget:self action:@selector(button3Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button3;
}

- (UIButton *)button4
{
    if (!_button4) {
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button4 setTitle:@"合成视频(movie->images->movie)" forState:UIControlStateNormal];
        [_button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button4.titleLabel.font = [UIFont systemFontOfSize:15];
        _button4.frame = CGRectMake(self.view.bounds.size.width / 2.0 - 300/2.0, CGRectGetMaxY(self.button3.frame) + 20, 300, 30);
        [_button4 addTarget:self action:@selector(button4Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button4;
}

- (UIButton *)button5
{
    if (!_button5) {
        _button5 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button5 setTitle:@"分离视频/音频（moive->video/audio）" forState:UIControlStateNormal];
        [_button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button5.titleLabel.font = [UIFont systemFontOfSize:15];
        _button5.frame = CGRectMake(self.view.bounds.size.width / 2.0 - 300/2.0, CGRectGetMaxY(self.button4.frame) + 20, 300, 30);
        [_button5 addTarget:self action:@selector(button5Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button5;
}

- (UIButton *)button6
{
    if (!_button6) {
        _button6 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button6 setTitle:@"视频分辨率裁剪" forState:UIControlStateNormal];
        [_button6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button6.titleLabel.font = [UIFont systemFontOfSize:15];
        _button6.frame = CGRectMake(self.view.bounds.size.width / 2.0 - 200/2.0, CGRectGetMaxY(self.button5.frame) + 20, 200, 30);
        [_button6 addTarget:self action:@selector(button6Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button6;
}

- (UIButton *)button7
{
    if (!_button7) {
        _button7 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button7 setTitle:@"贴图" forState:UIControlStateNormal];
        [_button7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button7.titleLabel.font = [UIFont systemFontOfSize:15];
        _button7.frame = CGRectMake(self.view.bounds.size.width / 2.0 - 200/2.0, CGRectGetMaxY(self.button6.frame) + 20, 200, 30);
        [_button7 addTarget:self action:@selector(button7Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button7;
}

- (LEGOAVPlayerView *)playerView
{
    if (!_playerView) {
        _playerView = [[LEGOAVPlayerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width / 4.0 *3)];
    }
    return _playerView;
}

- (void)button1Click:(id)sender
{
    [self cleanFFmpegPathCache];
    
    /** https://ffmpeg.org/ffmpeg-all.html */
    
//    主要参数： -i 输入流 -f 输出格式 -ss 开始时间 -t 持续时间 -to 用于指定视频文件在什么时间结束
    
//    视频参数： -r 帧率，默认25 -s 分辨率
    
    self.view.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 截取视频帧（movie->image）
        NSString *inputPath = [[NSBundle mainBundle] pathForResource:@"LEGO-FFmpeg" ofType:@"MOV"];
        NSString *outpath = [NSString stringWithFormat:@"%@/%@",[self.class getFFmpegPathCache],@"image%d.jpg"];
    //    NSString *commanString = [NSString stringWithFormat:@"ffmpeg -i %s -r 20 %s", inputPath.UTF8String, outpath.UTF8String];
        NSString *commanString = [NSString stringWithFormat:@"ffmpeg -i %s -r 20 -s 800x600 -f image2 %s", inputPath.UTF8String, outpath.UTF8String];   // 注意此处比例要与数据源相同，不然会变形，若想不同，请先使用 crop 命令
        [self runCmd:commanString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            ResultViewController *vc = [[ResultViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
            self.view.userInteractionEnabled = YES;
        });
    });
}

- (void)button2Click:(id)sender
{
    [self cleanFFmpegPathCache];
    
    self.view.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 截取某一段视频帧（movie->image）（-ss 开始时间，-t 持续时间）
        NSString *inputPath = [[NSBundle mainBundle] pathForResource:@"LEGO-FFmpeg" ofType:@"MOV"];
        NSString *outpath = [NSString stringWithFormat:@"%@/%@",[self.class getFFmpegPathCache],@"image%d.jpg"];
        NSString *commanString = [NSString stringWithFormat:@"ffmpeg -i %s -y -f image2 -ss 1 -t 1 %s", inputPath.UTF8String, outpath.UTF8String];
        [self runCmd:commanString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            ResultViewController *vc = [[ResultViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
            self.view.userInteractionEnabled = YES;
        });
    });

}

- (void)button3Click:(id)sender
{
    [self cleanFFmpegPathCache];
    
    self.view.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 截取一段视频（movie->movie）（-ss 开始时间，-t 持续时间）
        NSString *inputPath = [[NSBundle mainBundle] pathForResource:@"LEGO-FFmpeg" ofType:@"MOV"];
        NSString *outpath = [NSString stringWithFormat:@"%@/%@",[self.class getFFmpegPathCache],@"movie001.mp4"];
        NSString *commanString = [NSString stringWithFormat:@"ffmpeg -ss 0:0:1 -t 0:0:1 -i %s -vcodec copy -acodec copy %s", inputPath.UTF8String, outpath.UTF8String];
        [self runCmd:commanString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.playerView setPlayerItemWithUrl:[NSURL fileURLWithPath:outpath]];
            self.view.userInteractionEnabled = YES;
        });
    });

}

- (void)button4Click:(id)sender {
    [self cleanFFmpegPathCache];
    
    self.view.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //  视频帧转换成视频（images->movie）
        NSString *inputPath = [[NSBundle mainBundle] pathForResource:@"LEGO-FFmpeg" ofType:@"MOV"];
        NSString *outpath = [NSString stringWithFormat:@"%@/%@",[self.class getFFmpegPathCache],@"image%d.jpg"];
        NSString *commanString = [NSString stringWithFormat:@"ffmpeg -i %s -r 20 %s", inputPath.UTF8String, outpath.UTF8String];
        [self runCmd:commanString];
        NSString *moviePath = [NSString stringWithFormat:@"%@/%@",[self.class getFFmpegPathCache],@"movie001.mp4"];
        commanString = [NSString stringWithFormat:@"ffmpeg -f image2 -i %s %s", outpath.UTF8String, moviePath.UTF8String];
        [self runCmd:commanString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.playerView setPlayerItemWithUrl:[NSURL fileURLWithPath:moviePath]];
            self.view.userInteractionEnabled = YES;
        });
    });
    
}

- (void)button5Click:(id)sender {
    [self cleanFFmpegPathCache];
    
    self.view.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    //     分离视频音频流
    //     分离视频流
        NSString *inputPath = [[NSBundle mainBundle] pathForResource:@"LEGO-FFmpeg" ofType:@"MOV"];
        NSString *outpath = [NSString stringWithFormat:@"%@/%@",[self.class getFFmpegPathCache],@"movie001.mov"];
        NSString *commanString = [NSString stringWithFormat:@"ffmpeg -i %s -vcodec copy -an %s", inputPath.UTF8String, outpath.UTF8String];
        [self runCmd:commanString];

        //    // 分离音频流
        //    NSString *inputPath = [[NSBundle mainBundle] pathForResource:@"LEGO-FFmpeg" ofType:@"MOV"];
        //    NSString *outpath = [NSString stringWithFormat:@"%@/%@",[self.class getFFmpegPathCache],@"music001.mp3"];
        //    NSString *commanString = [NSString stringWithFormat:@"ffmpeg -i %s -acodec copy -vn %s", inputPath.UTF8String, outpath.UTF8String];
        //    [self runCmd:commanString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.playerView setPlayerItemWithUrl:[NSURL fileURLWithPath:outpath]];
            self.view.userInteractionEnabled = YES;
        });
    });

}

- (void)button6Click:(id)sender {
    [self cleanFFmpegPathCache];
    
    self.view.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 视频分辨率裁剪
    //    char *filter = "crop=400:300:12:13";   // w:h:x:y
    //    char *filter = "crop=100:100";  // center
        char *filter = "crop=2/3*in_w:2/3*in_h";  //ratio
        NSString *inputPath = [[NSBundle mainBundle] pathForResource:@"LEGO-FFmpeg" ofType:@"MOV"];
        NSString *outpath = [NSString stringWithFormat:@"%@/%@",[self.class getFFmpegPathCache],@"movie001.mov"];
        NSString *commanString = [NSString stringWithFormat:@"ffmpeg -i %s -vf %s %s", inputPath.UTF8String, filter, outpath.UTF8String];
        [self runCmd:commanString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.playerView setPlayerItemWithUrl:[NSURL fileURLWithPath:outpath]];
            self.view.userInteractionEnabled = YES;
        });
    });
    
}

- (void)button7Click:(id)sender
{
    [self cleanFFmpegPathCache];
    
    self.view.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //贴图
        NSString *inputPath = [[NSBundle mainBundle] pathForResource:@"LEGO-FFmpeg" ofType:@"MOV"];
        NSString *outpath = [NSString stringWithFormat:@"%@/%@",[self.class getFFmpegPathCache],@"movie001.mov"];
        NSString *commanString = [NSString stringWithFormat:@"ffmpeg -i %s -i %s -filter_complex overlay=x=150:y=150 -f mp4 %s", inputPath.UTF8String, [[NSBundle mainBundle] pathForResource:@"LEGO-xxx.jpg" ofType:nil].UTF8String, outpath.UTF8String];
        [self runCmd:commanString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.playerView setPlayerItemWithUrl:[NSURL fileURLWithPath:outpath]];
            self.view.userInteractionEnabled = YES;
        });
    });

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FFmpeg";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    [self.view addSubview:self.button3];
    [self.view addSubview:self.button4];
    [self.view addSubview:self.button5];
    [self.view addSubview:self.button6];
    [self.view addSubview:self.button7];
    
    [self.view addSubview:self.playerView];
    
    [self.playerView setPlayerItemWithUrl:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"LEGO-FFmpeg" ofType:@"MOV"]]];
    
    self.view.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self button1Click:nil];
    });
    
    // Do any additional setup after loading the view.
}

+ (NSString *)getFFmpegPathCache {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *videoCache = [[paths firstObject] stringByAppendingPathComponent:@"ffmpeg"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:videoCache isDirectory:&isDir];
    if (!(isDir == YES && existed == YES) ) {
        [fileManager createDirectoryAtPath:videoCache withIntermediateDirectories:YES attributes:nil error:nil];
    };
    return videoCache;
}

- (void)cleanFFmpegPathCache {
    NSString *ffmpeg = [self.class getFFmpegPathCache];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:ffmpeg]) {
        BOOL success = [fileManager removeItemAtPath:ffmpeg error:nil];
        NSLog(@"清空文件，success=%d",success);
    }
}

- (void)runCmd:(NSString *)commandStr {
    NSArray *argv_array = [commandStr componentsSeparatedByString:(@" ")];
    int argc = (int)argv_array.count;
    char** argv = (char**)malloc(sizeof(char*)*argc);
    for(int i=0; i < argc; i++) {
        argv[i] = (char*)malloc(sizeof(char)*1024);
        strcpy(argv[i],[[argv_array objectAtIndex:i] UTF8String]);
    }
    // 打印日志
    NSString *finalCommand = @"运行参数:";
    for (NSString *temp in argv_array) {
        finalCommand = [finalCommand stringByAppendingFormat:@"%@",temp];
    }
    NSLog(@"%@",finalCommand);
    
    ffmpeg_main(argc,argv);
}





@end
