//
//  UserInfoAndContentTableViewCell.m
//  
//
//  Created by air on 15/12/16.
//
//

#import "UserInfoAndContentTableViewCell.h"
#import "BUImageRes.h"
#import "JYQueueView.h"
#import "YYKit.h"
#import "WBStatusHelper.h"
#import "WBStatusLayout.h"
#import "WBStatusComposeTextParser.h"
#import "JYCommonTool.h"
@implementation UserInfoAndContentTableViewCell
{
    IBOutlet UIView *_containerView;
//    IBOutlet YYTextView *_contentTv;
    IBOutlet UIButton *_markBtn;
    IBOutlet UILabel *_markLb;
    IBOutlet UIButton *_imgBtn;
    IBOutlet UILabel *_contentLb;
    UIView *_rightMarkView;//右上角视图
    JYQueueView *_queueView;
    IBOutlet UILabel *_titleLb;
    IBOutlet UIImageView *_imgV;
    BUImageRes *_curImgRes;
    NSInteger _objRow;
    UIButton *_selectBtn;
    YYLabel *_contentYYLb;
    UILongPressGestureRecognizer *_lpGes;
}
- (void)awakeFromNib {
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _containerView.width = __SCREEN_SIZE.width;
    _contentLb.width = __SCREEN_SIZE.width - 10 - _contentLb.x;
//    _contentTv.width = __SCREEN_SIZE.width - 10 - _contentLb.x;
//    if (!_contentYYLb) {
    [_contentYYLb removeFromSuperview];
    _contentYYLb = nil;
          [self initYYlable];
//    }
//    else
//    {
//    
//    }
        if([dataDic[@"cellStatus"] integerValue]== 1)
    {
        _containerView.x = 44;
        _selectBtn = (UIButton *)[self viewWithTag:991];
        if (!_selectBtn) {
            _selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 13, 24, 24)];
            _selectBtn.tag = 991;
            [_selectBtn setImage:[UIImage imageContentWithFileName:@"NoPitchOn---Assistor@2x"] forState:UIControlStateNormal];
            [_selectBtn setImage:[UIImage imageContentWithFileName:@"pitchOn---Assistor@2x"] forState:UIControlStateSelected];
            [_selectBtn addTarget:self action:@selector(selectBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_selectBtn];
        }
       _selectBtn.selected = [dataDic[@"isSelect"] boolValue];
    }
    else
    {
        _containerView.x = 0;
    }
     _curImgRes.isValid = NO;
    id img = dataDic[@"img"];
    [_imgV imageWithContent:@"defaultHead1@2x"];
    if (img&&[img isKindOfClass:[BUImageRes class]]) {
      BUImageRes *imgRes = img;
        imgRes.isValid = YES;
        _curImgRes = imgRes;
//        _imgV.backgroundColor = [UIColor blueColor];
        [imgRes displayRemoteImage:_imgV imageName:@"defaultHead1@2x" thumb:YES];
    }
    _titleLb.width = 10;
    _titleLb.text = dataDic[@"title"];
    [_titleLb sizeToFit];
//     [self initTextView];
    _contentLb.text = dataDic[@"content"];
    
    if (dataDic[@"limitCount"]) {
        _contentLb.numberOfLines = [dataDic[@"limitCount"] integerValue];
//        _contentTv.userInteractionEnabled = YES;
//         _contentTv.text =  dataDic[@"content"];
        NSString *content =  dataDic[@"content"];
       NSArray *arr = [JYCommonTool getLinkValue:content];
         NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",content]];
        [mStr addAttribute:NSForegroundColorAttributeName value: kUIColorFromRGB(color_0x303030) range:NSMakeRange(0, mStr.length)];
        for (NSValue *v in arr) {
            //        NSValue *v = obj;
            NSRange range;
            [v getValue:&range];
//            NSRange aRange = NSMakeRange(2, name.length);
           
            [mStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
            YYTextHighlight *highlight = [YYTextHighlight new];
//            [highlight setBorder:border];
            highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//                [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
//                NSLog(@"xfffddd");
                if(self.tapLinkAction)
                {
                    self.tapLinkAction(@{@"phone":[text.string substringWithRange:range]});
                }
            };
            [mStr setTextHighlight:highlight range:range];

//            _contentYYLb.text = content;
        }
         _contentYYLb.attributedText = mStr;
        _contentYYLb.numberOfLines = 0;
//        _contentYYLb.height = 24;
//       NSTextCheckingResult *r = [JYCommonTool parseString:content withPattern:@"^[0-9]{7,23}$"];
//        content
//        _contentYYLb.hidden = YES;
        
         if(!_lpGes)
         {
             _lpGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
         }
        [_contentYYLb addGestureRecognizer:_lpGes];

    }
    else{
           _contentYYLb.numberOfLines = 5;
      _contentYYLb.text =  dataDic[@"content"];
                _contentLb.numberOfLines = 5;
    }
    if (dataDic[@"rightViewMode"]) {
        [self addRightMarkView:[dataDic[@"rightViewMode"] integerValue]];
    }
    else{
        [self removeRightMarkView];
    }
    if (dataDic[@"limitInfo"]) {
        [self addIconViews:dataDic[@"limitInfo"] withX:_titleLb.width + 10 + _titleLb.x];
    }
    else{
        [self removeIconViews];
    }
    _objRow = [dataDic[@"row"] integerValue];
    [self fitContentSize];
//     _containerView.height = _contentLb.height + 4 + _contentLb.y;
//     self.height = _containerView.height;
}

-(void)longPressAction:(UIGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateBegan) {
        if (self.longPressLinkAction) {
            self.longPressLinkAction(nil);
        }
    }
}

//-(NSInteger)getYYtextViewLineNumber:(YYTextView*)textView
//{
////    NSInteger maxLineNum = 4;
//    NSString *textString = @"Text";
//    CGSize fontSize = [textString sizeWithAttributes:@{NSFontAttributeName:textView.font}];
//    
//    NSString* newText = textView.text;//[textView.text stringByReplacingCharactersInRange:range withString:text];
//    CGSize tallerSize = CGSizeMake(textView.frame.size.width,990);
//    
//    CGSize newSize = [newText boundingRectWithSize:tallerSize
//                                           options:NSStringDrawingUsesLineFragmentOrigin
//                                        attributes:@{NSFontAttributeName: textView.font}
//                                           context:nil].size;
//    NSInteger newLineNum = MAX(1, (newSize.height)/ (fontSize.height)) ;
//    return newLineNum;
//}

-(void)selectBtnHandle:(UIButton *)btn
{
    if (_selectBtnHandle) {
        _selectBtnHandle(@{@"row":@(_objRow),@"sender":btn});
    }
}

//-(void)lastLineHandle:(NSInteger)limitCount
//{
//    if (_contentTv.textLayout.lines.count < limitCount) {
//        return;
//    }
//    YYTextLine *line =  _contentTv.textLayout.lines[limitCount - 1];
//    NSRange range = line.range;
//    range.location = range.location + range.length - 3;
//    range.length = _contentTv.attributedText.string.length - range.location;
////    YYTextRange *tRange = [YYTextRange rangeWithRange:range];
////    _contentTv.textLayout.container.maximumNumberOfRows = 5;
////    _contentTv.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_contentTv.attributedText.string] ];//[_contentTv.attributedText.string stringByReplacingCharactersInRange:range withString:@"..."];
//}

//-(CGFloat)getYYtextViewHeight:(YYTextView*)textView withLimitLineNum:(NSInteger)nums
//{
//// CGSize fontSize = [textView.text sizeWithAttributes:@{NSFontAttributeName:textView.font}];
//   
//    CGFloat height;
//     WBTextLinePositionModifier *modifier = _contentTv.linePositionModifier;
//    if (nums == 0) {
//       height = textView.contentSize.height;
//    }
//    else
//    {
//      height = MIN(textView.contentSize.height + 4, [modifier heightForLineCount:nums]) ;
//    }
//   
//   
//   
//    return height;
//}

-(void)fitContentSize
{
//    _contentTv.hidden = YES;

    //_titleLb.text = content;
    [_contentLb sizeToFit];
    _contentLb.height = MAX(_contentLb.height, 20);
//    _contentTv.width = _contentLb.width;
    
//    _contentTv.text = _contentLb.text;
    CGFloat height = 4;
     NSInteger row = _contentYYLb.textLayout.lines.count;
    if (_contentLb.numberOfLines == 5) {
//        [self lastLineHandle:5];
//       _contentTv.height = [self getYYtextViewHeight:_contentTv withLimitLineNum:5];
       
        _contentYYLb.numberOfLines = 5;
//        WBTextLinePositionModifier *modifier = _contentYYLb.linePositionModifier;
       
         [_contentYYLb sizeToFit];
 //[_contentYYLb.textLayout lineCountForRow:5];
       _contentYYLb.height = MAX(row * (_contentYYLb.font.lineHeight + 8), _contentYYLb.height);
         _containerView.height = _contentYYLb.height + height + _contentYYLb.y;
    }
    else
    {
         [_contentYYLb sizeToFit];
//    _contentTv.height = [self getYYtextViewHeight:_contentTv withLimitLineNum:0];
        _contentYYLb.height = MAX(row * (_contentYYLb.font.lineHeight + 8), _contentYYLb.height);
         _containerView.height = _contentYYLb.height + height + _contentYYLb.y;
    }
   
    self.height = _containerView.height;
}

-(void)addRightMarkView:(NSInteger)type//给右上角加上对应的视图
{
    [_rightMarkView removeFromSuperview];
    switch (type) {
        case 0://添加更多按钮
        {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(__SCREEN_SIZE.width - 10 - 45, 4, 45, 30)];
            btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
//            btn.backgroundColor = [UIColor redColor];
//            [btn setTitle:@"..." forState:UIControlStateNormal];
            [btn setImage:[UIImage imageContentWithFileName:@"moreAssistor@2x"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
            _rightMarkView = btn;
            [_containerView addSubview:_rightMarkView];
        }
            break;
        case 1://发布文字
        {
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(__SCREEN_SIZE.width - 10 - 55, 4, 55, 30)];
            lb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
//            lb.backgroundColor = [UIColor yellowColor];
            _rightMarkView = lb;
            lb.text = @"发布中";
            lb.textColor = kUIColorFromRGB(color_0xf44d36);
            lb.font = [UIFont systemFontOfSize:14];
             lb.textAlignment = NSTextAlignmentCenter;
            [_containerView addSubview:_rightMarkView];
        }
            break;
        case 2://合作标志
        {
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(__SCREEN_SIZE.width - 10 - 86, 4, 86, 24)];
            lb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
//            lb.backgroundColor = [UIColor blueColor];
            lb.textAlignment = NSTextAlignmentCenter;
            lb.text = @"合作已失效";
            lb.font = [UIFont systemFontOfSize:12];
            lb.textColor = kUIColorFromRGB(color_0x999999);
            _rightMarkView = lb;
            [_containerView addSubview:_rightMarkView];
        }
            break;
        default:
            break;
    }
}

-(void)removeRightMarkView//删除右上角视图
{
    if (_rightMarkView) {
        [_rightMarkView removeFromSuperview];
        _rightMarkView = nil;
    }
}

-(void)addIconViews:(NSArray *)arr withX:(float)x//加入权限限制的图标标志
{
     [_queueView removeAllView];
    if (!_queueView) {
        _queueView = [[JYQueueView alloc] init];
        _queueView.paddingX = 0;
       
        [_containerView addSubview:_queueView];
    }
    _queueView.frame = CGRectMake(x, 10, 100, 26);
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
     [_queueView addViewToListView:990 + idx withImgName:obj];
    }];
    
}

- (IBAction)moreAction:(id)sender {
    if (_moreAction) {
        _moreAction(@{@"row":@(_objRow)});
    }
}

-(void)initYYlable
{
    _contentYYLb = [[YYLabel alloc] initWithFrame:CGRectMake(60, 28, 280, 1990)];
    _contentYYLb.font = [UIFont systemFontOfSize:16];
    WBStatusComposeTextParser *parser = [WBStatusComposeTextParser new];
    parser.font = [UIFont systemFontOfSize:16];
    _contentYYLb.textParser = parser;
 _contentYYLb.textColor = kUIColorFromRGB(color_0x303030);
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:16];
    modifier.paddingTop = 9;
    modifier.paddingBottom = 6;
    modifier.lineHeightMultiple = 1.5;
    _contentYYLb.linePositionModifier = modifier;
    _contentYYLb.width = __SCREEN_SIZE.width - 10 - _contentYYLb.x;
    [_containerView addSubview:_contentYYLb];
}


//-(void)initTextView
//{
//    _contentTv.dataDetectorTypes = UIDataDetectorTypeLink;
//    _contentTv.showsVerticalScrollIndicator = NO;
//    _contentTv.alwaysBounceVertical = NO;
//    _contentTv.allowsCopyAttributedString = YES;
//    _contentTv.font = [UIFont systemFontOfSize:14];
//    _contentTv.textColor = kUIColorFromRGB(color_0x303030);
//  WBStatusComposeTextParser *parser = [WBStatusComposeTextParser new];
//    parser.font = [UIFont systemFontOfSize:14];
//    _contentTv.textParser = parser;
//    _contentTv.editable = NO;
//    _contentTv.userInteractionEnabled = NO;
////    _contentTv.textContainerInset = UIEdgeInsetsMake(0, 0, 12, 0);
////    _contentTv.delegate = self;
////    _contentTv.inputAccessoryView = [UIView new];
////    _contentTv.borderColor = kUIColorFromRGB(color_0xcdcdcd);
////    _contentTv.borderWidth = 0.5;
////    _contentTv.layer.cornerRadius = 8;
////    _contentTv.returnKeyType = UIReturnKeySend;
//    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
//    modifier.font = [UIFont fontWithName:@"Heiti SC" size:14];
//    modifier.paddingTop = 3;
//    modifier.paddingBottom = 3;
//    modifier.lineHeightMultiple = 1.5;
//    _contentTv.linePositionModifier = modifier;
//
//}

-(void)removeIconView:(NSInteger)index
{
    [_queueView removeViewFromListViewWithTag:index + 990];
}

-(void)removeIconViews//删除所有权限限制的图标标志
{
    if (_queueView) {
        [_queueView removeAllView];
        [_queueView removeFromSuperview];
        _queueView = nil;
    }
}

- (IBAction)imgBtnHandle:(id)sender {
    if (self.handleAction) {
        self.handleAction(sender);
    }
}

- (void)textView:(YYTextView *)textView didTapHighlight:(YYTextHighlight *)highlight inRange:(NSRange)characterRange rect:(CGRect)rect
{
//    [CommonAPI managerWithVC:self] showConfirmView:@"" withMsg:<#(NSString *)#>;
    NSLog(@"textView tap");
}


@end
