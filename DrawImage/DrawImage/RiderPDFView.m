//
//  RiderPDFView.m
//  DrawImage
//
//  Created by csm on 2017/10/27.
//  Copyright © 2017年 YiJu. All rights reserved.
//

#import "RiderPDFView.h"

@interface RiderPDFView (){
    
    CGPDFDocumentRef  _documentRef;//用它来记录传递进来的PDF资源数据
    NSInteger  _pageNum;//记录需要显示页码

}
@end

@implementation RiderPDFView

-(instancetype)initWithFrame:(CGRect)frame documentRef:(CGPDFDocumentRef)documentRef andPageNumber:(NSInteger)pageNum{
    
    if (self = [super initWithFrame:frame]) {
        
        _documentRef = documentRef;
        
        _pageNum = pageNum;
        
        [self setNeedsDisplay];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
  return self;
    
}

- (void)drawRect:(CGRect)rect{
    
    [self drawPDFIncontext:UIGraphicsGetCurrentContext()];
}

-(void)drawPDFIncontext:(CGContextRef )context{
    
    CGContextTranslateCTM(context, 0.0, self.frame.size.height);
    
    CGContextScaleCTM(context,1.0, -1.0);
    
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(_documentRef, _pageNum);
    
    //记录当前环境,以免多次绘制
    CGContextSaveGState(context);
    
    CGAffineTransform  transform = CGPDFPageGetDrawingTransform(pageRef, kCGPDFCropBox, self.bounds, 0, true);
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawPDFPage(context, pageRef);
    
    //重新启动记录的环境
    CGContextRestoreGState(context);
    
    //更改当前的上下文
   // UIGraphicsPushContext(<#CGContextRef  _Nonnull context#>)
    //UIGraphicsPopContext()
}


@end
