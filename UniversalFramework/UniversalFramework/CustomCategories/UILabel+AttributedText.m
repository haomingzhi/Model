

#import "UILabel+AttributedText.h"

@implementation UILabel (AttributedText)


-(void)strikeout
{
    [self strikeout:0 withLength:[self.text length]];
}
-(void)strikeout:(NSInteger)start withLength:(NSInteger)length
{
    if (self.text.length == 0 ) {
        return;
    }
    NSString *text = self.text;
    length = MIN([text length], length);
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:text];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(start, length)];
    [attri addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(start, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:self.textColor range:NSMakeRange(start, length)];
    [self setAttributedText:attri];
}

-(void)richMText:(NSString *)text color:(UIColor *) color withFont:(UIFont *)font{
    
    NSRange range =[self.text rangeOfString:text];
    if (range.location == NSNotFound) {
        return ;
    }
    NSAttributedString *attrStr = self.attributedText;
    NSMutableAttributedString *str =  attrStr == NULL ? [[NSMutableAttributedString alloc] initWithString:text] : [[NSMutableAttributedString alloc ] initWithAttributedString:attrStr];
    
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    //    if (bgColor) {
    //        [str addAttribute:NSBackgroundColorAttributeName value:bgColor range:range];
    //    }
    self.attributedText = str;
    
}


-(void)richTextMany:(NSString *)text color:(UIColor *) color{
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSArray *strArr=[text componentsSeparatedByString:@" "];
    for (NSString *s in strArr) {
        NSRange range =[self.text rangeOfString:s];
        [str addAttribute:NSForegroundColorAttributeName value:color range:range];
        [str addAttribute:NSFontAttributeName value:self.font range:range];
    }
    
    NSRange range1 =[self.text rangeOfString:@"("];
    if (range1.location != NSNotFound) {
        NSRange range2 =[self.text rangeOfString:@")"];
        [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(range1.location, range2.location-range1.location+1)];
        [str addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(range1.location, range2.location-range1.location+1)];
    }
    self.attributedText = str;
}
-(NSAttributedString *)richText:(UIFont *) font text:(NSString *)richText color:(UIColor *) color
{
    NSAttributedString * atrStr = [self getAttributedString:font text:richText color:color];
    if (atrStr) {
        self.attributedText = atrStr;
    }
    return atrStr;
    
}
-(void )richText:(UIFont *) font text:(NSString *)text color:(UIColor *) color bgColor:(UIColor *) bgColor
{
    NSAttributedString * atrStr = [UILabel getAttributedString:font text:self.text rictText:text color:color bgColor:bgColor attrStr:NULL];
    if (atrStr) {
        self.attributedText = atrStr;
    }
}

-(NSAttributedString *)richText:(NSString *)text color:(UIColor *) color
{
    return [self richText:self.font text:text color:color];
}


-(NSMutableAttributedString*) getAttributedString:(UIFont *) font text:(NSString *)richText color:(UIColor *) color
{
    return [self getAttributedString:font text:richText color:color attrStr:NULL];
}

-(NSMutableAttributedString*) getAttributedString:(UIFont *) font text:(NSString *)richText color:(UIColor *) color attrStr:(NSAttributedString *)attrStr
{
    if (self.text.length ==0 || richText.length ==0) {
        return NULL;
    }
    
    return [UILabel getAttributedString:font text:self.text rictText:richText color:color attrStr:attrStr];
}

+(NSMutableAttributedString*) getAttributedString:(UIFont *) font text:(NSString *) text rictText:(NSString *)richText color:(UIColor *) color attrStr:(NSAttributedString *)attrStr
{
    return [self getAttributedString:font text:text rictText:richText color:color bgColor:NULL attrStr:attrStr];
}

+(NSMutableAttributedString*) getAttributedString:(UIFont *) font  text:(NSString *) text rictText:(NSString *)richText color:(UIColor *)  color bgColor:(UIColor *) bgColor attrStr:(NSAttributedString *)attrStr
{
    NSRange range =[text rangeOfString:richText];
    if (range.location == NSNotFound) {
        return NULL;
    }
    
    NSMutableAttributedString *str =  attrStr == NULL ? [[NSMutableAttributedString alloc] initWithString:text] : [[NSMutableAttributedString alloc ] initWithAttributedString:attrStr];
    
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    if (bgColor) {
        [str addAttribute:NSBackgroundColorAttributeName value:bgColor range:range];
    }
    return str;
}

-(NSMutableAttributedString *)getDifferFontAttributedString:(NSString *)text color:(UIColor *)color size:(float)size{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    
    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,4)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Zapfino" size:size] range:NSMakeRange(0, 4)];
    //[str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Marker Felt" size:size] range:NSMakeRange(2, 2)];
    return str;
}

-(void) setSuffix:(NSString *) suffix
{
    CGSize expectSize =  [self.text size:self.font constrainedToSize:CGSizeMake(self.width, MAXFLOAT)];
    NSMutableString *expectStr = [[NSMutableString alloc] initWithString:suffix];
    [expectStr appendString:@"..."];
    NSInteger count =0;
    if (expectSize.height > self.height && [self.text hasSuffix:suffix]) {
        NSString *tempText = [self.text substringToIndex:[self.text rangeOfString:suffix].location];
        for (int i =0;  i <tempText.length ; i++) {
            [expectStr appendString:[tempText substringWithRange:NSMakeRange(i, 1)] ];
            expectSize = [expectStr size:self.font constrainedToSize:CGSizeMake(self.width, MAXFLOAT)];
            if (expectSize.height < self.height) {
                count ++;
            }
        }
        self.text = [NSString stringWithFormat:@"%@%@%@",[self.text substringWithRange:NSMakeRange(0, count)],@"...",suffix];
    }
}

-(void)setHtmlStr:(NSString *)html
{
    NSString * htmlString = html;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    //    UILabel * myLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.attributedText = attrStr;
}

-(void)setHtmlStrHasImg:(NSString *)html
{
    //HTML文本 包含图片、文本
    //    NSString *htmlString= html;//@"< img src=http://upload-images.jianshu.io/upload_images/937405-50a8ad2d8866fc12.png>  花羊羊领取了你的红包"; //我们可以先把src对应的图片解析出来，放到本地
    //    NSRange httpRange=[htmlString rangeOfString:@"http://"]; NSRange endRange=[htmlString rangeOfString:@".png"];
    //    NSString *picString=[htmlString substringWithRange:NSMakeRange(httpRange.location, endRange.location+endRange.length-httpRange.location)]; UIImage *scaledImage;
    //    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:picString] options:nil progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
    //    {
    //        //按照字体大小缩小图片，具体实现在下文
    //        scaledImage=[self scaleImage:image font:font];
    //        NSData *imgData=UIImagePNGRepresentation(scaledImage);
    //        NSString *libPath=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,     NSUserDomainMask, YES) lastObject];     NSString *cachePath=[libPath stringByAppendingPathComponent:@"Caches"];
    //        NSString *scaledImagesPath=[cachePath stringByAppendingPathComponent:@"scaledImages"];
    //        if(![[NSFileManager defaultManager] fileExistsAtPath:scaledImagesPath]){         [[NSFileManager defaultManager] createDirectoryAtPath:scaledImagesPath withIntermediateDirectories:YES attributes:nil error:nil];     } NSString *picName=[[picString componentsSeparatedByString:@"/"] lastObject];     NSString *filePath=[scaledImagesPath stringByAppendingPathComponent:picName];     [imgData writeToFile:filePath atomically:YES]; //用空字符串替换远程图片路径
    //        htmlString=[htmlString stringByReplacingOccurrencesOfString:picString withString:@""]; }];
    ////    UILabel *label=[UILabel alloc] initWithFrame:CGRectMake(50, 200, 220, 20)]; [self.view addSubview:label];
    //    UIFont *font=[UIFont systemFontOfSize:14];
    //    self.font=font;
    //    //利用NSTextAttachment文UILabel添加图片，并调整位置实现居中对齐
    //    NSTextAttachment *attach=[[NSTextAttachment alloc] init];
    //    attach.bounds=CGRectMake(2, -(self.frame.size.height-font.pointSize)/2, 12, 14);
    //    attach.image=scaledImage;
    //    NSMutableAttributedString *componets=[[NSMutableAttributedString alloc] init];
    //    NSAttributedString *imagePart=[NSAttributedString attributedStringWithAttachment:attach];
    //    [componets appendAttributedString:imagePart];
    //    NSDictionary *optoins=@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,                             NSFontAttributeName:font}; NSData *data=[htmlString dataUsingEncoding:NSUnicodeStringEncoding]; NSAttributedString *textPart=[[NSAttributedString alloc] initWithData:data                                                                      options:optoins            documentAttributes:nil                                                                        error:nil];
    //    [componets appendAttributedString:textPart];
    //    self.attributedText=componets;
    
}

-(UIImage *)scaleImage:(UIImage *)origin font:(UIFont *)font{
    CGFloat imgH=origin.size.height;
    CGFloat imgW=origin.size.width;
    CGFloat width;
    CGFloat height;
    CGFloat fontHeight=font.pointSize;
    if(imgW>imgH)
    {
        width=fontHeight;
        height=fontHeight/imgW*imgH;
    }     else{
        height=fontHeight;
        width=fontHeight/imgH*imgW;
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [origin drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *scaledImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
