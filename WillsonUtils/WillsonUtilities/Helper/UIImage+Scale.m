//
//  UIImage+Scale.m
//  qieqie
//
//  Created by Paul on 14-4-16.
//  Copyright (c) 2014年 paulzhou. All rights reserved.
//

#import "UIImage+Scale.h"
#import "SDImageCache.h"

@implementation UIImage (FromFile)



+ (UIImage *)imageLoadFromCache:(NSString *)strUrl
{
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:strUrl];
    return image;
}

- (UIImage *)scaledCopyOfSizeMin:(CGSize)newSize {
    CGImageRef imgRef = self.CGImage;
	
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
	
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > newSize.width || height > newSize.height) {
        CGFloat ratio = width/height;
        CGFloat ratio2 = newSize.width/newSize.height;
        
        if (ratio < ratio2) {
            bounds.size.height = newSize.height;
            bounds.size.width = bounds.size.height * ratio;
        } else {
            bounds.size.width = newSize.width;
            bounds.size.height = bounds.size.width / ratio;
        }
    }
	
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = self.imageOrientation;
    switch(orient) {
			
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
			
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
			
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
			
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
			
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
			
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
			
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
			
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
			
        default:
            //[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
			break;
    }
	
    UIGraphicsBeginImageContext(bounds.size);
	
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
	
    CGContextConcatCTM(context, transform);
	
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return imageCopy;
}

- (UIImage *)scaledCopyOfSizeMax:(CGSize)newSize {
    CGImageRef imgRef = self.CGImage;
	
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
	
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > newSize.width || height > newSize.height) {
        CGFloat ratio = width/height;
        CGFloat ratio2 = newSize.width/newSize.height;
        
        if (ratio > ratio2) {
            bounds.size.height = newSize.height;
            bounds.size.width = bounds.size.height * ratio;
        } else {
            bounds.size.width = newSize.width;
            bounds.size.height = bounds.size.width / ratio;
        }
    }
	
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = self.imageOrientation;
    switch(orient) {
			
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
			
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
			
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
			
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
			
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
			
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
			
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
			
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
			
        default:
            //[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
			break;
    }
	
    UIGraphicsBeginImageContext(bounds.size);
	
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
	
    CGContextConcatCTM(context, transform);
	
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return imageCopy;
}

- (UIImage*)toGetMaximumPicture:(CGSize)newSize {
    //    if([HDDelegateIMP needLog]) {
    //        //abcd//NSLog(@"startSize%@",NSStringFromCGSize(newSize));
    //    }
    ////abcd//NSLog(@"----------------");
    float IMAGE_WIDTH = newSize.width;
    float IMAGE_HEIGHT = newSize.height;

    //    if([HDDelegateIMP needLog]) {
    //        //abcd//NSLog(@"%f,%f",IMAGE_HEIGHT,IMAGE_WIDTH);
    //    }

    UIImage* image = self;
    //    if([HDDelegateIMP needLog]) {
    //        //abcd//NSLog(@"imageSize%@",NSStringFromCGSize(image.size));
    //    }

    CGRect imageRect;
    CGSize imageSize;

    if (image.size.width / IMAGE_WIDTH == image.size.height / IMAGE_HEIGHT) {
        imageSize = image.size;
        imageRect =
            CGRectMake(0, 0, image.size.width,
                       image.size.height);  // CGRectMake(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);//
    }

    else if (image.size.width >= IMAGE_WIDTH && image.size.height >= IMAGE_HEIGHT) {
        if (image.size.width / IMAGE_WIDTH > image.size.height / IMAGE_HEIGHT) {
            imageSize =
                CGSizeMake(IMAGE_WIDTH * image.size.height / IMAGE_HEIGHT, image.size.height);
            imageRect = CGRectMake((image.size.width - imageSize.width) / 2, 0, imageSize.width,
                                   imageSize.height);

        } else {
            imageSize = CGSizeMake(image.size.width, IMAGE_HEIGHT * image.size.width / IMAGE_WIDTH);
            imageRect = CGRectMake(0, (image.size.height - imageSize.height) / 2, imageSize.width,
                                   imageSize.height);
        }
    } else if (image.size.width < IMAGE_WIDTH && image.size.height < IMAGE_HEIGHT) {
        if (IMAGE_WIDTH / image.size.width > IMAGE_HEIGHT / image.size.height) {
            imageSize = CGSizeMake(image.size.width, IMAGE_HEIGHT * image.size.width / IMAGE_WIDTH);
            imageRect = CGRectMake(0, (IMAGE_HEIGHT - imageSize.height) / 2, imageSize.width,
                                   imageSize.height);
        } else {
            imageSize =
                CGSizeMake(IMAGE_WIDTH * image.size.height / IMAGE_HEIGHT, image.size.height);
            imageRect = CGRectMake((IMAGE_WIDTH - imageSize.width) / 2, 0, imageSize.width,
                                   imageSize.height);
        }
    } else if (image.size.width >= IMAGE_WIDTH && image.size.height < IMAGE_HEIGHT) {
        imageSize = CGSizeMake(IMAGE_WIDTH * image.size.height / IMAGE_HEIGHT, image.size.height);
        imageRect =
            CGRectMake((IMAGE_WIDTH - imageSize.width) / 2, 0, imageSize.width, imageSize.height);
    } else {
        imageSize = CGSizeMake(image.size.width, IMAGE_HEIGHT * image.size.width / IMAGE_WIDTH);
        imageRect = CGRectMake(0, (image.size.height - imageSize.height) / 2, imageSize.width,
                               imageSize.height);
    }
#if 1
    // imageRect.size = newSize;
    CGImageRef imageRef = image.CGImage;
    CGImageRef subIMageRef = CGImageCreateWithImageInRect(imageRef, imageRect);
    //    UIGraphicsBeginImageContext(imageSize);
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextDrawImage(context, imageRect, subIMageRef);
    UIImage* newImage2 = [UIImage imageWithCGImage:subIMageRef];
    CGImageRelease(subIMageRef);
    //    UIGraphicsEndImageContext();

    //    if([HDDelegateIMP needLog]) {
    //        //abcd//NSLog(@"endNewImageSize%@  ==== %@",NSStringFromCGSize(newImage.size),
    //        NSStringFromCGRect(imageRect));
    //    }

    CGSize size = CGSizeMake(IMAGE_WIDTH * 2, IMAGE_HEIGHT * 2);
    UIGraphicsBeginImageContext(size);
    [newImage2 drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
#else
    CGSize size = imageRect.size;  // CGSizeMake(IMAGE_WIDTH * 2, IMAGE_HEIGHT * 2);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

#endif
    return newImage;
}

@end
