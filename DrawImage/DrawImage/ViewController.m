//
//  ViewController.m
//  DrawImage
//
//  Created by csm on 2017/10/26.
//  Copyright © 2017年 YiJu. All rights reserved.
//

#import "ViewController.h"
#import "FlowerView.h"
#import "FlowerTransformView.h"
#import "GraphView.h"
#import "RiderPDFView.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


   // FlowerView * view = [[FlowerView alloc]initWithFrame:self.view.bounds];
   // [self.view addSubview:view];

//    FlowerTransformView * transformView = [[FlowerTransformView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:transformView];
    
    GraphView * graphView = [[GraphView alloc]initWithFrame:self.view.bounds];
    graphView.contentMode = UIViewContentModeRight;
    [self.view addSubview:graphView];
    
   /*
   //加载查看本地PDF文件
    CFURLRef pdfUrl = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("Swift.pdf"), NULL, NULL);
    CGPDFDocumentRef document = CGPDFDocumentCreateWithURL(pdfUrl);
    
    CFRelease(pdfUrl);

    //转换查看网络pdf文件
    NSURL*url = [NSURL URLWithString:@"http://leal.oss-cn-beijing.aliyuncs.com/YongHu/BaoXian/123.pdf"];//将传入的字符串转化为一个NSURL地址
    CFURLRef refURL = (__bridge_retained CFURLRef)url;//将的到的NSURL转化为CFURLRefrefURL备用
    
    CGPDFDocumentRef document = CGPDFDocumentCreateWithURL(refURL);//通过CFURLRefrefURL获取文件内容

    RiderPDFView * riderView = [[RiderPDFView alloc]initWithFrame:CGRectMake(50, 100, ScreenWidth-100, ScreenHeight-200) documentRef:document andPageNumber:1];
    
    [self.view addSubview:riderView];
    
    CFRelease(refURL);//过河拆桥，释放使用完毕的CFURLRefrefURL，这个东西并不接受自动内存管理，所以要手动释放
    */

  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
