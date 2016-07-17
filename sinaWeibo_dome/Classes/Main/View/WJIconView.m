//
//  WJIconView.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/17.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJIconView.h"
#import "WJUserModel.h"

@interface WJIconView ()
// 加 V 的图片
@property (nonatomic,weak) UIImageView * verifiedView;

@end
@implementation WJIconView

-(UIImageView *)verifiedView{

    if (!_verifiedView) {
        UIImageView * verifi = [[UIImageView alloc] init];
        [self addSubview:verifi];
        _verifiedView = verifi;
    }
    return _verifiedView;
}
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        // 给头像倒圆角
        self.layer.cornerRadius = 18;
        //self.layer.masksToBounds = YES;
    }
    return self;
}

-(void)setUser:(WJUserModel *)user{ //由于cell的频繁调用，故不能在这里创建imageview 需要用到懒加载

    _user = user;
    // 1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    // 2.设置加V图片
    
    switch (user.verified_type) {
        case WJUserVerifiedTypePersonal:
            //个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];

            break;
        case WJUserVerifiedTypeOrgEnterprice:
        case WJUserVerifiedTypeOrgMedia:
        case WJUserVerifiedTypeOrgWebsite:
            // 官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case WJUserVerifiedTypeDaren:
            // 微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        default:
            self.verifiedView.hidden = YES; // 没有任何认证的时候
            break;
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.verifiedView.size = self.verifiedView.image.size;
    CGFloat scale = 0.7; // 将图片的位置移除图片大小的60%
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
    
}
@end
