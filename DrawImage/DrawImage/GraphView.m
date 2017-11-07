//
//  GraphView.m
//  DrawImage
//
//  Created by csm on 2017/10/26.
//  Copyright © 2017年 YiJu. All rights reserved.
//

#import "GraphView.h"

@interface GraphView ()
@property (nonatomic,readwrite,strong) NSMutableArray * values;
@property (nonatomic,readwrite,strong) dispatch_source_t timer;

@end

const CGFloat kXScale = 5.0;
const CGFloat kYScale = 100.0;

static inline CGAffineTransform
CGAffineTransformMakeScaleTranslate(CGFloat sx,CGFloat sy, CGFloat dx, CGFloat dy){
    return CGAffineTransformMake(sx, 0.f, 0.f, sy, dx, dy);
};

@implementation GraphView

/* Core Graphics 使用 Core Foundation 内存管理机制. Core Foundation 对象需要手动保留和释放,即使启用了ARC*/



-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setRandPoint];
    }
    return self;
}

-(void)setRandPoint{
    
    self.values = [NSMutableArray array];
    
    __weak id weakself  = self;
    double delayInSeconds = 1.0;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), (unsigned)(delayInSeconds * NSEC_PER_SEC), 0);
    dispatch_source_set_event_handler(self.timer, ^{
        [weakself updateValues];
    });
    
    dispatch_resume(self.timer);
    
}

-(void)updateValues{
    
    double nextValue = sin(CFAbsoluteTimeGetCurrent()) + ((double)rand()/(double)RAND_MAX);
    [self.values addObject:[NSNumber numberWithDouble:nextValue]];
    CGSize size = self.bounds.size;
    CGFloat maxDimension = MAX(size.height, size.width);
    NSUInteger maxValues = (NSUInteger)floorl(maxDimension / kXScale);
    
    if ([self.values count] > maxValues) {
        [self.values removeObjectsInRange:NSMakeRange(0, [self.values count] - maxValues)];
    }
    
    [self setNeedsDisplay];
}



-(void)dealloc{
    dispatch_source_cancel(_timer);
    
};

/* 在drawRect方法中,UIKit和Core Graphics 可以无异常的混用,不过在drawRect:之外,Core Graphics绘制的东西会上下颠倒 .
 
   UIKit遵循ULO即Upper-left Origin,左上角为原点的坐标系统,而CoreGraphics默认使用LLO(即Lower_Left Origin,左下角为原点)的坐标系统
 
   在drawRect方法中,如果是以UIGraphicsGetCurrentContext()返回的上下文,那么一切正常了,因为已经反转过了,如果是以CGBitmapContextCreate返回的上下文,他会以左下角为原点,可以进行反向计算或者翻转上下文: 先平移上下文的高度,在使用一个负数比例进行反转
   CGContextTranslateCTM(ctx,0.0f,-1.0f);
   CGContextScaleCTM(ctx,1.0f,-1.0f);
 
   如果想让UIKit适应CoreGraphics,则应该先进行反转,在进行平移
   CGContextScaleCTM(ctx,1.0f,-1.0f);
   CGContextTranslateCTM(ctx,0.0f,-1.0f);
 
 */

-(void)drawRect:(CGRect)rect{
    
    if ([self.values count] == 0) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, 5.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat yOffset = self.bounds.size.height / 2;
    CGAffineTransform transform = CGAffineTransformMakeScaleTranslate(kXScale, kYScale, 0, yOffset);
    CGFloat y = [[self.values objectAtIndex:0] floatValue];
    CGPathMoveToPoint(path, &transform, 0, y);
    
    for (NSInteger x = 1; x < [self.values count]; x++) {
        y = [[self.values objectAtIndex:x] floatValue];
        CGPathAddLineToPoint(path, &transform, x, y);
    }
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);
    
}
@end
