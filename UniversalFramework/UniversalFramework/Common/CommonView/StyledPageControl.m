//
//  PageControl.m
//  PageControlDemo
//
/**
 * Created by honcheng on 5/14/11.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining 
 * a copy of this software and associated documentation files (the 
 * "Software"), to deal in the Software without restriction, including 
 * without limitation the rights to use, copy, modify, merge, publish, 
 * distribute, sublicense, and/or sell copies of the Software, and to 
 * permit persons to whom the Software is furnished to do so, subject 
 * to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be 
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT 
 * WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR 
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
 * SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
 * IN CONNECTION WITH THE SOFTWARE OR 
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author 		Muh Hon Cheng <honcheng@gmail.com> http://twitter.com/honcheng
 * @copyright	2011	Muh Hon Cheng
 * 
 */

#import "StyledPageControl.h"


@implementation StyledPageControl


#define COLOR_GRAYISHBLUE [UIColor colorWithRed:128/255.0 green:130/255.0 blue:133/255.0 alpha:1]
#define COLOR_GRAY [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.strokeWidth = 2;
        self.gapWidth = 10;
        self.diameter = 12;
        self.pageControlStyle = PageControlStyleDefault;
        self.coreNormalColor = COLOR_GRAYISHBLUE;
        self.coreSelectedColor = self.pageControlStyle==PageControlStyleStrokedCircle || self.pageControlStyle==PageControlStyleWithPageNumber ? COLOR_GRAYISHBLUE :COLOR_GRAY;
        self.strokeNormalColor = self.pageControlStyle==PageControlStyleDefault ? self.coreNormalColor :COLOR_GRAYISHBLUE;
        self.strokeSelectedColor = self.pageControlStyle==PageControlStyleStrokedCircle || self.pageControlStyle==PageControlStyleWithPageNumber ?COLOR_GRAYISHBLUE :(self.pageControlStyle==PageControlStyleDefault ? self.coreSelectedColor : COLOR_GRAY);
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

- (void)onTapped:(UITapGestureRecognizer*)gesture
{
    CGPoint touchPoint = [gesture locationInView:[gesture view]];
    
    if (touchPoint.x < self.frame.size.width/2)
    {
        // move left
        if (self.currentPage>0)
        {
            self.currentPage -= 1;
        }
        
    }
    else
    {
        // move right
        if (self.currentPage<self.numberOfPages-1)
        {
            self.currentPage += 1;
        }
    }
    [self setNeedsDisplay];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)drawRect:(CGRect)rect
{
    
    // Drawing code
    if (_hidesForSinglePage && self.numberOfPages==1)
	{
		return;
	}
	
	CGContextRef myContext = UIGraphicsGetCurrentContext();
	
	NSInteger gap = self.gapWidth;
    float diameter = self.diameter - 2*self.strokeWidth;
    
    if (self.pageControlStyle==PageControlStyleThumb)
    {
        if (self.thumbImage && self.selectedThumbImage)
        {
            diameter = self.thumbImage.size.width;
        }
    }
	
	NSInteger total_width = self.numberOfPages*diameter + (self.numberOfPages-1)*gap;
	
	if (total_width>self.frame.size.width)
	{
		while (total_width>self.frame.size.width)
		{
			diameter -= 2;
			gap = diameter + 2;
			while (total_width>self.frame.size.width) 
			{
				gap -= 1;
				total_width = self.numberOfPages*diameter + (self.numberOfPages-1)*gap;
				
				if (gap==2)
				{
					
					total_width = self.numberOfPages*diameter + (self.numberOfPages-1)*gap;
                    break;
				}
			}
			
			if (diameter==2)
			{
				
				total_width = self.numberOfPages*diameter + (self.numberOfPages-1)*gap;
                break;
			}
		}
		
		
	}
	
	int i;
	for (i=0; i<self.numberOfPages; i++)
	{
		int x = (self.frame.size.width-total_width)/2 + i*(diameter+gap);

        if (self.pageControlStyle==PageControlStyleDefault)
        {
            if (i==self.currentPage)
            {
                CGContextSetFillColorWithColor(myContext, [_coreSelectedColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
                CGContextSetStrokeColorWithColor(myContext, [_strokeSelectedColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
            }
            else
            {
                CGContextSetFillColorWithColor(myContext, [_coreNormalColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
                CGContextSetStrokeColorWithColor(myContext, [_strokeNormalColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
            }
        }
        else if (self.pageControlStyle==PageControlStyleStrokedCircle)
        {
            CGContextSetLineWidth(myContext, self.strokeWidth);
            if (i==self.currentPage)
            {
                CGContextSetFillColorWithColor(myContext, [_coreSelectedColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
                CGContextSetStrokeColorWithColor(myContext, [_strokeSelectedColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
            }
            else
            {
                CGContextSetStrokeColorWithColor(myContext, [_strokeNormalColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
            }
        }
        else if (self.pageControlStyle==PageControlStyleWithPageNumber)
        {
            CGContextSetLineWidth(myContext, self.strokeWidth);
            if (i==self.currentPage)
            {
                int _currentPageDiameter = diameter*1.6;
                x = (self.frame.size.width-total_width)/2 + i*(diameter+gap) - (_currentPageDiameter-diameter)/2;
                CGContextSetFillColorWithColor(myContext, [_coreSelectedColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-_currentPageDiameter)/2,_currentPageDiameter,_currentPageDiameter));
                CGContextSetStrokeColorWithColor(myContext, [_strokeSelectedColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-_currentPageDiameter)/2,_currentPageDiameter,_currentPageDiameter));
            
                NSString *pageNumber = [NSString stringWithFormat:@"%i", i+1];
                CGContextSetFillColorWithColor(myContext, [[UIColor whiteColor] CGColor]);
                
                NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
                paragraph.alignment = NSTextAlignmentCenter;
                paragraph.lineBreakMode = NSLineBreakByCharWrapping;
                
                [pageNumber drawInRect:CGRectMake(x,(self.frame.size.height-_currentPageDiameter)/2-1,_currentPageDiameter,_currentPageDiameter) withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:_currentPageDiameter-2],NSParagraphStyleAttributeName:paragraph}];
            }
            else
            {
                CGContextSetStrokeColorWithColor(myContext, [_strokeNormalColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
            }
        }
        else if (self.pageControlStyle==PageControlStylePressed1 || self.pageControlStyle==PageControlStylePressed2)
        {
            if (self.pageControlStyle==PageControlStylePressed1)
            {
                CGContextSetFillColorWithColor(myContext, [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2-1,diameter,diameter));
            }
            else if (self.pageControlStyle==PageControlStylePressed2)
            {
                CGContextSetFillColorWithColor(myContext, [[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2+1,diameter,diameter));
            }
            
            
            if (i==_currentPage)
            {
                CGContextSetFillColorWithColor(myContext, [_coreSelectedColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
                CGContextSetStrokeColorWithColor(myContext, [_strokeSelectedColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
            }
            else
            {
                CGContextSetFillColorWithColor(myContext, [_coreNormalColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
                CGContextSetStrokeColorWithColor(myContext, [_strokeNormalColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
            }
        }
        else if (self.pageControlStyle==PageControlStyleThumb)
        {
            if (self.thumbImage && self.selectedThumbImage)
            {
                if (i==_currentPage)
                {
                    [self.selectedThumbImage drawInRect:CGRectMake(x,(self.frame.size.height-self.selectedThumbImage.size.height)/2,self.selectedThumbImage.size.width,self.selectedThumbImage.size.height)];
                }
                else
                {
                    [self.thumbImage drawInRect:CGRectMake(x,(self.frame.size.height-self.thumbImage.size.height)/2,self.thumbImage.size.width,self.thumbImage.size.height)];
                }
            }
        }
	}
}






- (void)setPageControlStyle:(PageControlStyle)style
{
    _pageControlStyle = style;
    [self setNeedsDisplay];
}

- (void)setCurrentPage:(int)page
{
    _currentPage = page;
    [self setNeedsDisplay];
}



- (void)setNumberOfPages:(NSInteger)numOfPages
{
    _numberOfPages = numOfPages;
    [self setNeedsDisplay];
}




@end
