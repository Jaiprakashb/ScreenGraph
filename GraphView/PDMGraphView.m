//
//  PDMGraphView.m
//  ScreenGraph
//
//  Created by jaiprakash bokhare on 27/01/14.
//  Copyright (c) 2014 padmin. All rights reserved.
//

#import "PDMGraphView.h"

@implementation PDMGraphView
{
  unsigned int _interval;
  UIColor      *_lineColor;
  UIColor      *_textColor;
  UIFont       *_textFont;
}

@dynamic interval;
@dynamic lineColor;
@dynamic textColor;
@dynamic textFont;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
      self->_interval  = DefaultInterval;
      self->_lineColor = DefaultLineColor;
      self->_textColor = DefaultTextColor;
      self->_textFont  = DefaultFont;
    }
  
    return self;
}

- (unsigned int) interval
{
  return self->_interval;
}

- (void) setInterval:(unsigned int)interval
{
  if(self->_interval != interval)
  {
    self->_interval = interval;
    
    [self setNeedsDisplay];
  }
}

- (UIColor*) lineColor
{
  return self->_lineColor;
}

- (void) setLineColor:(UIColor *)lineColor
{
  if(![self->_lineColor isEqual:lineColor])
  {
    self->_lineColor = lineColor;
    [self setNeedsDisplay];
  }
}

- (UIColor*) textColor
{
  return self->_textColor;
}

- (void) setTextColor:(UIColor *)textColor
{
  if(![self->_textColor isEqual:textColor])
  {
    self->_textColor = textColor;
  }
}

- (UIFont*) textFont
{
  return self->_textFont;
}

- (void) setTextFont:(UIFont *)textFont
{
  if(![self->_textFont isEqual:textFont])
  {
    self->_textFont = textFont;
  
    [self setNeedsDisplay];
  }
}

+ (PDMGraphView*) visibleGraphView
{
    for(UIView *subview in [UIApplication sharedApplication].keyWindow.subviews)
    {
      
      if([subview isKindOfClass:[PDMGraphView class]])
        return (PDMGraphView*)subview;
    }
  
  return nil;
}

+(void) show
{
  UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
  
  PDMGraphView *graphView = [[PDMGraphView alloc] initWithFrame:CGRectMake(0, 0, keyWindow.frame.size.width, keyWindow.frame.size.height)];
  
  [keyWindow addSubview:graphView];
  
  graphView.backgroundColor = [UIColor clearColor];
  graphView.userInteractionEnabled = NO;
}

+(void) remove
{
  PDMGraphView *graphView = nil;
  
  for(UIView *subView in [UIApplication sharedApplication].keyWindow.subviews)
  {
    if([subView isKindOfClass:[PDMGraphView class]])
    {
      graphView = (PDMGraphView*)subView;
      break;
    }
  }
  
  [graphView removeFromSuperview];
}

- (void) drawXAxisOnContext:(CGContextRef) context
{
  for(int x = self->_interval; x <= self.frame.size.width; x += self->_interval)
  {
    CGContextSetStrokeColorWithColor(context, self->_lineColor.CGColor);
    CGContextSetLineWidth(context, 0.5f);

    CGContextMoveToPoint(context, x, 0);
    CGContextAddLineToPoint(context, x, self.frame.size.height);

    CGContextStrokePath(context);
    
    [[NSString stringWithFormat:@"%d", x] drawAtPoint:CGPointMake(x, 0)
                                       withAttributes:@{NSFontAttributeName:self->_textFont,
                                                        NSForegroundColorAttributeName : self->_textColor}];
  }
}

- (void) drawYAxisOnContext:(CGContextRef) context
{
  for(int y = self->_interval; y <= self.frame.size.height; y += self->_interval)
  {
    CGContextSetStrokeColorWithColor(context, self->_lineColor.CGColor);
    CGContextSetLineWidth(context, 0.5f);

    CGContextMoveToPoint(context, 0, y);
    CGContextAddLineToPoint(context, self.frame.size.width, y);

    CGContextStrokePath(context);

    [[NSString stringWithFormat:@"%d", y] drawAtPoint:CGPointMake(0, y)
                                       withAttributes:@{NSFontAttributeName:self->_textFont,
                                                        NSForegroundColorAttributeName : self->_textColor}];
  }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSaveGState(context);
  CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1 green:1 blue:0 alpha:0.5f].CGColor);
  CGContextSetLineWidth(context, 0.5f);

  [self drawXAxisOnContext:context];
  [self drawYAxisOnContext:context];
  
  CGContextStrokePath(context);
  
  CGContextRestoreGState(context);
}

@end
