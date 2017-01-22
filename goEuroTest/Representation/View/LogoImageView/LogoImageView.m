//
//  LogoImageView.m
//  goEuroTest
//
//  Created by Roman Bobelyuk on 1/20/17.
//  Copyright © 2017 Roman. All rights reserved.
//

#import "LogoImageView.h"
@interface LogoImageView(){
    UIImageView *_innerImageView;
}
@end

@implementation LogoImageView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self)
        [self initWithLeftAligment];
    return self;
}

- (void)initWithLeftAligment{
    _innerImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _innerImageView.contentMode = self.contentMode;
    _innerImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_innerImageView];
}

- (UIImage *)image{
    return _innerImageView.image;
}

- (void)setImage:(UIImage *)image{
    [_innerImageView setImage:image];
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    CGSize aspectFitSize = [self aspectFitContentSize];
    
    CGRect leftAligmentFrame = CGRectMake(0, 0, aspectFitSize.width, aspectFitSize.height);
    _innerImageView.frame = leftAligmentFrame;
    self.layer.contents = nil;
}

- (CGSize) aspectFitContentSize{
    CGSize size = self.bounds.size;
    
    if (self.image == nil){
        return size;
    }
    switch (self.contentMode) {
        case UIViewContentModeScaleAspectFit:
        {
            float scalex = self.bounds.size.width / _innerImageView.image.size.width;
            float scaley = self.bounds.size.height / _innerImageView.image.size.height;
            float scale = MIN(scalex, scaley);
            
            size = CGSizeMake(_innerImageView.image.size.width * scale, _innerImageView.image.size.height * scale);
            
            break;
        }
        default:
            size = _innerImageView.image.size;
            break;
    }
    return size;
}

@end
