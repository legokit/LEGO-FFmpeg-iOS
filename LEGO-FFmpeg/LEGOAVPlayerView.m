//
//  LEGOAVPlayerView.m
//  LEGO-FFmpeg
//
//  Created by 杨庆人 on 2020/8/13.
//  Copyright © 2020 杨庆人. All rights reserved.
//

#import "LEGOAVPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface LEGOAVPlayerView()

@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@end

@implementation LEGOAVPlayerView

- (AVPlayer *)avPlayer
{
    if (!_avPlayer) {
        _avPlayer = [[AVPlayer alloc] init];
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
        CGFloat currentVolume = audioSession.outputVolume;
        _avPlayer.volume = currentVolume;
    }
    return _avPlayer;
}

- (AVPlayerLayer *)playerLayer
{
    if (!_playerLayer) {
        _playerLayer = (AVPlayerLayer *)self.layer;
        _playerLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor;
    }
    return _playerLayer;
}

+ (Class)layerClass
{
    return [AVPlayerLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.playerLayer.player = self.avPlayer;
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.avPlayer.currentItem];
    }
    return self;
}

- (void)dealloc
{
    [self.avPlayer.currentItem removeObserver:self forKeyPath:@"status"];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.avPlayer = nil;
}

- (void)setPlayerItemWithUrl:(NSURL *)playerUrl
{
    [self settingPlayerItem:[[AVPlayerItem alloc] initWithURL:playerUrl]];
}

- (void)settingPlayerItem:(AVPlayerItem *)playerItem
{
    _playerItem = playerItem;
    [self.avPlayer.currentItem removeObserver:self forKeyPath:@"status"];
    [self.avPlayer pause];
    [self.avPlayer replaceCurrentItemWithPlayerItem:playerItem];
    [self.avPlayer.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [[change objectForKey:@"new"] integerValue];
        switch (status) {
            case AVPlayerItemStatusReadyToPlay:
            {
                [self.avPlayer play];
            }
                break;
            case AVPlayerItemStatusFailed:
                NSLog(@"加载失败");
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"未知资源");
                break;
            default:
                break;
        }
    }
}

- (void)playFinished:(NSNotification *)notifi
{
    [self.playerItem seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        
    }];
    [self.avPlayer play];
}



@end
