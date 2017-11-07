//
//  FlowerTransformView.m
//  DrawImage
//
//  Created by csm on 2017/10/26.
//  Copyright © 2017年 YiJu. All rights reserved.
//

#import "FlowerTransformView.h"

static inline CGAffineTransform
CGAffineTransformMakeScaleTranslate(CGFloat sx,CGFloat sy,CGFloat dx,CGFloat dy){
    return CGAffineTransformMake(sx, 0.f, 0.f, sy, dx, dy);
}

@implementation FlowerTransformView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    CGSize size = self.bounds.size;
    CGFloat margin = 10;
    
    [[UIColor greenColor] set];
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(0, -1) radius:1 startAngle:-M_PI endAngle:0 clockwise:YES];
    [path addArcWithCenter:CGPointMake(1, 0) radius:1 startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    [path addArcWithCenter:CGPointMake(0, 1) radius:1 startAngle:0 endAngle:M_PI clockwise:YES];
    [path addArcWithCenter:CGPointMake(-1, 0) radius:1 startAngle:M_PI_2 endAngle:-M_PI_2 clockwise:YES];
    [path closePath];
    
    CGFloat scale = floorf((MIN(size.height, size.width)-margin)/5);
    CGAffineTransform transform;
    transform = CGAffineTransformMakeScaleTranslate(scale, scale, size.width/2, size.height/2);
    [path applyTransform:transform];
    [path fill];
}

@end
