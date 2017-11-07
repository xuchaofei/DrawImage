//
//  FlowerView.m
//  DrawImage
//
//  Created by csm on 2017/10/26.
//  Copyright © 2017年 YiJu. All rights reserved.
//

#import "FlowerView.h"

@implementation FlowerView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setNeedsLayout];
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    CGSize size = self.bounds.size;
    CGFloat margin = 10;

    CGFloat radius = rintf(MIN(size.height - margin, size.width - margin)/4);
    CGFloat xOffset,yOffset;
    CGFloat offset = rintf((size.height - size.width)/2);
    if (offset > 0) {
        xOffset = rint(margin/2);
        yOffset = offset;
    }else{
        xOffset = -offset;
        yOffset = rint(margin/2);
    }

    [[UIColor redColor] setFill];
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(radius*2+xOffset, radius+yOffset) radius:radius startAngle:-M_PI endAngle:0 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius*3+xOffset, radius*2+yOffset) radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius*2+xOffset, radius*3+yOffset) radius:radius startAngle:0 endAngle:M_PI clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius+xOffset, radius*2+yOffset) radius:radius startAngle:M_PI_2 endAngle:-M_PI_2 clockwise:YES];
    [path closePath];
    [path fill];
    
//    CGContextRef ref = UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(ref, 10., 100.);
//    CGContextAddLineToPoint(ref, 200., 100.);
//    CGContextStrokePath(ref);
//    CGContextSetRGBFillColor(ref, 0, 0.25, 0, 0.5);
//
//    CGContextMoveToPoint(ref, 10., 105.5);
//    CGContextAddLineToPoint(ref, 200., 105.5);
//    CGContextStrokePath(ref);

}

@end
