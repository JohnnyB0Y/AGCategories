//
//  TestNSFileManagerViewController.m
//  AGCategories
//
//  Created by JohnnyB0Y on 2019/1/23.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "TestNSFileManagerViewController.h"
#import "AGCategories.h"

@interface TestNSFileManagerViewController ()

@end

@implementation TestNSFileManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *dirPathOfDocument = [fileManager ag_dirPathOfDocument];
    NSString *dirPathOfPreferences = [fileManager ag_dirPathOfPreferences];
    NSString *dirPathOfCaches = [fileManager ag_dirPathOfCaches];
    NSString *dirPathOfTemporary = [fileManager ag_dirPathOfTemporary];
    NSString *dirPathOfLibrary = [fileManager ag_dirPathOfLibrary];
    
    NSString *dirError = @"获取路径出错！";
    NSAssert(dirPathOfDocument != nil, dirError);
    NSAssert(dirPathOfPreferences != nil, dirError);
    NSAssert(dirPathOfCaches != nil, dirError);
    NSAssert(dirPathOfTemporary != nil, dirError);
    NSAssert(dirPathOfLibrary != nil, dirError);
    
    // 数据可能会变，打印路径，自己计算。
    NSUInteger bitSize = [fileManager ag_sizeOfBitWithFolderPath:dirPathOfLibrary error:nil]; // 269296
    NSUInteger byteSize = [fileManager ag_sizeOfByteWithFolderPath:dirPathOfLibrary error:nil]; // 33662
    double kiloByte = [fileManager ag_sizeOfKiloByteWithFolderPath:dirPathOfLibrary error:nil]; // 33.6619~
    double megaByte = [fileManager ag_sizeOfMegaByteWithFolderPath:dirPathOfLibrary error:nil]; // 0.0336619~
    double gigaByte = [fileManager ag_sizeOfGigaByteWithFolderPath:dirPathOfLibrary error:nil]; // 0.0000336619~
    
    NSLog(@"Library all file, bitSize: %ld - byteSize: %ld - kiloByte: %f - megaByte: %f - gigaByte: %f", bitSize, byteSize, kiloByte, megaByte, gigaByte);
    
    // ignore .ktx file
    byteSize = [fileManager ag_sizeOfByteWithFolderPath:dirPathOfLibrary ignore:@[@"ktx"] error:nil];
    NSLog(@"Ignore .ktx file, byteSize: %ld", byteSize);
    
    // contain .ktx file
    byteSize = [fileManager ag_sizeOfByteWithFolderPath:dirPathOfLibrary contain:@[@"ktx"] error:nil];
    NSLog(@"Contain .ktx file, byteSize: %ld", byteSize);
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
