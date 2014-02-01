//
//  PDMGraphView.h
//  ScreenGraph
//
//  Created by jaiprakash bokhare on 27/01/14.
//  Copyright (c) 2014 padmin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DefaultInterval 20
#define DefaultLineColor [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:0.4f]
#define DefaultTextColor [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:1.0f]
#define DefaultFont      [UIFont systemFontOfSize:7.0f]

@interface PDMGraphView : UIView
@property(readwrite, assign) unsigned int interval;
@property(nonatomic, readwrite, strong) UIColor *lineColor;
@property(nonatomic, readwrite, strong) UIColor *textColor;
@property(nonatomic, readwrite, strong) UIFont  *textFont;

+(void) show;
+(void) remove;

+ (PDMGraphView*) visibleGraphView;

@end
