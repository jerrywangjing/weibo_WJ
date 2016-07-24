//
//  WJDIY2TextView.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/24.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJDIY2TextView.h"

@interface WJDIY2TextView ()
/**占位label*/
@property (nonatomic,weak) UILabel * placeholder;

@end
@implementation WJDIY2TextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupPlaceholder];
        
        [WJNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];//这里的object参数需传递通知的发送者，即texView
        
        self.placeholder.textColor = self.placeholderColor ? self.placeholderColor:[UIColor grayColor];
    }
    return self;
}

-(void)setupPlaceholder{

    UILabel * placeholder = [[UILabel alloc] init];
    _placeholder = placeholder;
    //placeholder.backgroundColor = [UIColor orangeColor];
    _placeholder.numberOfLines = 0;
    [self addSubview:placeholder];
    
    
}

-(void)setPlaceholderStr:(NSString *)placeholderStr{

    _placeholderStr = placeholderStr;
    self.placeholder.text = placeholderStr;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{

    _placeholderColor = placeholderColor;
    self.placeholder.textColor = placeholderColor;
}
-(void)layoutSubviews{

    for (UIView* lab in self.subviews) {
        if ([lab isKindOfClass:[UILabel class]]) {
            lab.x = 5;
            lab.y = 8;
            lab.size = [self.placeholderStr sizeWithFont:self.placeholder.font];
        }
    }
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholder.font = font;
}

-(void)textDidChange{

    if (self.text.length > 0) {
        self.placeholder.text = @"";
    }else{
    
        self.placeholder.text = self.placeholderStr;
    }
}
@end
