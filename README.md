# LEGO-FFmpeg-iOS

FFmpeg 以命令行来调用，本次静态库使用了 4.0.3 为例

1. FFmpeg 命令行：https://ffmpeg.org/ffmpeg-all.html 官方文档，对查找命令行十分有用

2. 关于如果在 mac 中生成 .a 静态库和 tool 命令行工具，可以参照这位博主的博客

    https://www.jianshu.com/p/299906d4054d 👍

    Xcode 编译问题可参照网上分享，具体问题需要具体分析

3. 关于如何方便的调用命令行，我写了一个比较简易的封装函数 (由于ffmpeg 工具 tool 类提供的是 c 接口， 所以在 iOS 中，需要进行字符串拆分)

例如：

    ffmpeg -i foo.avi -r 1 -f image2 foo-%03d.jpeg 

//    主要参数： -i 输入流 -f 输出格式 -ss 开始时间 -t 持续时间 -to 结束时间

//    视频参数： -r 帧率（默认25） -s 分辨率

    int argc = 8;
    char **arguments = calloc(argc, sizeof(char*));
    if(arguments != NULL)
    {
        arguments[0] = "ffmpeg";
        arguments[1] = "-i";
        arguments[2] = (char *)inputPath.UTF8String;
        arguments[3] = "-r";
      	arguments[4] = “1”;
	      arguments[5] = “-f”;
	      arguments[6] = “image2”;
        arguments[7] = (char *)outpath.UTF8String;
  
	ffmpeg_main(argc, arguments)
    }


为了方便使用命令行，可直接使用字符串的形式作为调用入参

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

目前的可提供例子，主要是关于视频的解码与图片相关的

.a 静态库太大没有上传

## Demonstration
![image](https://github.com/legokit/LEGO-FFmpeg-iOS/blob/master/IMG_0445.PNG)
