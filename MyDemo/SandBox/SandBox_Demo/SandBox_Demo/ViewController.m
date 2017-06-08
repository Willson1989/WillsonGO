//
//  ViewController.m
//  SandBox_Demo
//
//  Created by WillHelen on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //获取程序的Home路径
    NSString *homePath = NSHomeDirectory();
    NSLog(@"Home Path   :%@",homePath);
    
    //获取documents目录
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [docPaths objectAtIndex:0];
    NSLog(@"Documents   :%@",docPath);
    
    //获取cache路径
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    NSLog(@"Cache       :%@",cachePath);
    
    //获取Library路径
    NSArray *libPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libPath = [libPaths objectAtIndex:0];
    NSLog(@"Library     :%@",libPath);
    
    //获取temp路径
    NSString *tmpPath = NSTemporaryDirectory();
    NSLog(@"temp        :%@",tmpPath);
    
    
//    [self createDictionary];
//    [self createFile];
//    [self getAllFileNames];
    [self changerWorkPath];
    
}

//创建目录
- (void)createDictionary{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *wholePath = [path stringByAppendingPathComponent:@"MyDic01"];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager createDirectoryAtPath:wholePath withIntermediateDirectories:YES attributes:nil error:nil];
}

//在指定目录下创建文件
- (void)createFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *wholePath01 = [path stringByAppendingPathComponent:@"MyText01.txt"];
    NSString *wholePath02 = [path stringByAppendingPathComponent:@"MyText02.txt"];
    NSString *wholePath03 = [path stringByAppendingPathComponent:@"MyText03.txt"];
    
    NSString *content = @"The content of file";
    
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager createFileAtPath:wholePath01 contents:[content dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    [manager createFileAtPath:wholePath02 contents:[content dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    [manager createFileAtPath:wholePath03 contents:[content dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
}

//获取指定路径下的所有文件名
- (void)getAllFileNames{
    NSString *homePath = NSHomeDirectory();
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *allFileNames01 = [fm subpathsAtPath:homePath];
    NSArray *allFileNames02 = [fm subpathsOfDirectoryAtPath:homePath error:nil];
    NSLog(@"All files \n01 : %@\n02 : %@",allFileNames01,allFileNames02);
}

//更改当前工作目录
- (void)changerWorkPath{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *prevPath = [fm currentDirectoryPath];
    NSLog(@"path before change : %@",prevPath);
    
    NSString *homePath = NSHomeDirectory();
    [fm changeCurrentDirectoryPath:homePath];
    NSString *currPath = [fm currentDirectoryPath];
    NSLog(@"path after  change : %@",currPath);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
