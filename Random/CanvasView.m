//
//  CanvasView.m
//  Random
//
//  Created by Benny Pollak on 7/10/13.
//  Copyright (c) 2013 Alben Software. All rights reserved.
//

#import "CanvasView.h"

@interface CanvasView () {
    int *values;
    int rows, cols;
    BOOL initialized;
    NSArray *colors;
    int size;
    int width;
}

@end

@implementation CanvasView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}
-(void)setup
{
    initialized = NO;
    
}
-(void)initialize
{
    initialized = YES;
    colors = [NSArray arrayWithObjects:[UIColor whiteColor],[UIColor grayColor],[UIColor brownColor],[UIColor greenColor],[UIColor cyanColor],[UIColor yellowColor],[UIColor orangeColor],[UIColor magentaColor],[UIColor redColor],[UIColor blueColor],[UIColor purpleColor],nil];
    size = self.frame.size.width/320*4;
    width = self.frame.size.width;
    rows = cols = 80;
    _count = cols*rows;
    values = (int*)calloc(_count, sizeof(int));
    _empty = _count;
}
-(void)upWithRnd:(double)rnd repeat:(BOOL)repeat
{
    int val = rnd * (rows*cols);
    if (!repeat) {
        int nval = val;
        while (values[nval]) {
            nval++;
            if (nval >= _count) {
                nval = 0;
            }
            if (nval == val) break;
        }
        val = nval;
    }
    _empty -= values[val] == 0;
    values[val]++;
}
-(void)reset
{
    for (int i = 0; i < _count; i++) {
        values[i] = 0;
    }
    _empty = _count;
}

- (void)drawRect:(CGRect)rect {
    if (!initialized) {
        [self initialize];
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rrect = rect;
    rrect = CGRectMake(0, 0, size, size);
    int p = 0;
    for (int r = 0; r < rows; r++) {
        rrect.origin.x = r*size;
        for (int c = 0; c < cols; c++) {
            rrect.origin.y = width-(c+1)*size;
            int val = values[p++];
            if (val >= colors.count) val = colors.count-1;
            [(UIColor*)[colors objectAtIndex:val] set];
            CGContextFillRect(context, rrect);
        }
    }
    [[UIColor blackColor] set];
    CGContextFillRect(context, CGRectMake(0, width+3*size-3*size, width, 3*size));
    for (int i = 0; i < colors.count; i++) {       
        [(UIColor*)[colors objectAtIndex:i] set];
        CGContextFillRect(context, CGRectMake(i*2*size, width + 3*size  -2*size,2*size,2*size));
    }
}


@end
