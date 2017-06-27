//
//  UIColor+ImageGetColor.h
//  YQW
//
//  Created by Sunshine on 2017/6/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/ES1/glext.h>

@interface UIView (GetImgae)

-(UIImage *)imageRepresentation;

@end

@interface UIColor (ImageGetColor)

+ (UIColor*) getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image;

@end


@interface UIImage (Tint)

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

@end
