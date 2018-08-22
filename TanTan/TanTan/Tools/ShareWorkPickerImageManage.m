//
//  ShareWorkPickerImageManage.m
//  ShareWork
//
//  Created by 周发明 on 2018/5/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShareWorkPickerImageManage.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ShareWorkPickerImageManage()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, assign)BOOL canEdit;
@property(nonatomic, weak)UIViewController *currentVC;
@property(nonatomic,copy)ShareWorkPickerImageManageBlock finishBlock;
@end

@implementation ShareWorkPickerImageManage

+ (instancetype)manager{
    static ShareWorkPickerImageManage *_ShareWorkPickerImageManageInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ShareWorkPickerImageManageInstance = [[ShareWorkPickerImageManage alloc] init];
    });
    return _ShareWorkPickerImageManageInstance;
}

-(void)showToViewController:(UIViewController *)vc canEdit:(BOOL)canEdit finishBlock:(ShareWorkPickerImageManageBlock)finishBlock{
    self.currentVC = vc;
    self.canEdit = canEdit;
    self.finishBlock = finishBlock;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"照片" message:@"请选择来源" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = canEdit;
        [self.currentVC presentViewController:imagePicker animated:YES completion:nil];
    }];
    [alert addAction:action];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = canEdit;
        [self.currentVC presentViewController:imagePicker animated:YES completion:nil];
    }];
    [alert addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action2];
    [vc presentViewController:alert animated:YES completion:nil];
}



-(void)showToViewController:(UIViewController *)vc  onlyCameraCanEdit:(BOOL)canEdit finishBlock:(ShareWorkPickerImageManageBlock)finishBlock{
    self.currentVC = vc;
    self.canEdit = canEdit;
    self.finishBlock = finishBlock;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"照片" message:@"请选择来源" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = canEdit;
        [self.currentVC presentViewController:imagePicker animated:YES completion:nil];
    }];
    [alert addAction:action];
   
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action2];
    [vc presentViewController:alert animated:YES completion:nil];
}




#pragma mark -
#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image;
    if (self.canEdit) {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if (self.finishBlock) {
        self.finishBlock(image);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
