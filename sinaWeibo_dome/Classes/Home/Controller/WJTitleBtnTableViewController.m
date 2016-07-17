//
//  WJTitleBtnTableViewController.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/17.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJTitleBtnTableViewController.h"

@interface WJTitleBtnTableViewController ()

@end

@implementation WJTitleBtnTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = WJRGBAColor(96, 96, 96, 0.4);
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"密友";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"全部";
    }else{
    
        cell.textLabel.text = @"其他";
    }
    
    return cell;
}

@end
