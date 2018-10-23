//
//  JYAbstractTableViewCell.m
//  TestTableView
//
//  Created by wujiayuan on 15/8/29.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _userData = dataDic[BaseTableViewCell_userData];
    for (NSString *key in dataDic.allKeys) {
        if ([key isEqualToString: BaseTableViewCell_separatorInset]) {
            NSValue *v = dataDic[@"separatorInset"];
            UIEdgeInsets s;
            [v getValue:&s];
            if (v) {
                self.separatorInset = s;
            }
        }
        else if ([key isEqualToString:BaseTableViewCell_height])
        {
            self.height = [dataDic[@"height"] floatValue];
        }
        else
        {
            if ([self isExists:key])
            {
                [self setValue:dataDic[key] forKey:key];
            }
            else if ([key containsString:@"."]) {
                [self setValue:dataDic[key] forKeyPath:key];
            }
        }
    }
}

-(id)heightOfCell
{
    return @(self.height);
}

@end
