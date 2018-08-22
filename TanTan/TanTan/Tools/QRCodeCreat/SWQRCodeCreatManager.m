//
//  SWQRCodeCreatManager.m
//  ShareWork
//
//  Created by 周发明 on 2018/5/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SWQRCodeCreatManager.h"
#import <CoreImage/CoreImage.h>

@interface SWQRCodeCreatManager()
@property(nonatomic, strong)CIFilter *filter;
@property(nonatomic, strong)NSDictionary *keys;
@end

@implementation SWQRCodeCreatManager

+ (instancetype)manager{
    static SWQRCodeCreatManager *_SWQRCodeCreatManagerInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _SWQRCodeCreatManagerInstance = [[SWQRCodeCreatManager alloc] init];
    });
    return _SWQRCodeCreatManagerInstance;
}

- (CIFilter *)filter{
    if (_filter == nil) {
        _filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    }
    return _filter;
}

- (UIImage *)creatImageWithString:(NSString *)string type:(SWQRCodeCreatType)type{

    // 滤镜恢复默认设置
    [self.filter setDefaults];
    
    NSString *text = [self inputMessageWithString:string type:type];
    // 2. 给滤镜添加数据
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值
    [self.filter setValue:data forKeyPath:@"inputMessage"];
    
    // 3. 生成二维码
    CIImage *image = [self.filter outputImage];
    
    // 4. 返回二维码
    return [self createNonInterpolatedUIImageFormCIImage:image withSize:400];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (NSString *)inputMessageWithString:(NSString *)string type:(SWQRCodeCreatType)type{
    return [NSString stringWithFormat:@"%@%@", self.keys[@(type)],string];
}

- (void)handleResule:(NSString *)result success:(void(^)(NSString *text, SWQRCodeCreatType type))success{
    __block SWQRCodeCreatType type = SWQRCodeCreatTypeError;
    __block NSString *text = @"";
    [self.keys enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSString *value, BOOL * _Nonnull stop) {
        if (value.length > 0 && [result containsString:value]) {
            type = [key integerValue];
            text = [result stringByReplacingOccurrencesOfString:result withString:@""];
            *stop = YES;
        }
    }];
    if (success) {
        success(text, type);
    }
}

- (NSDictionary *)keys{
    if (_keys == nil) {
//        NSString * =
        ;
        _keys = @{
                  @(SWQRCodeCreatTypeOrderPunchCard):[NSString stringWithFormat:@"%@?subId=", [[SWNetManager manager].baseUrl stringByAppendingString:@"app/workClock/addWorkClock"]],
                  @(SWQRCodeCreatTypeApplyTeamOrGroup):@"",
                  @(SWQRCodeCreatTypeAreaPunchCard):[NSString stringWithFormat:@"%@?siteId=", [[SWNetManager manager].baseUrl stringByAppendingString:@"api/app/workClock/addWorkSiteClock"]]
//                  @(SWQRCodeCreatTypeAreaPunchCard):@"app/workClock/addWorkSiteClock",
    
                  };
    }
    return _keys;
}

@end
