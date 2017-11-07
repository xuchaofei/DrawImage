//
//  RiderPDFView.h
//  DrawImage
//
//  Created by csm on 2017/10/27.
//  Copyright © 2017年 YiJu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RiderPDFView : UIView

-(instancetype)initWithFrame:(CGRect)frame documentRef:(CGPDFDocumentRef)documentRef andPageNumber:(NSInteger)pageNum;

@end
