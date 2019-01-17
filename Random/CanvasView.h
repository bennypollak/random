//
//  CanvasView.h
//  Random
//
//  Created by Benny Pollak on 7/10/13.
//  Copyright (c) 2013 Alben Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanvasView : UIView
-(void)setup;
-(void)upWithRnd:(double)rnd repeat:(BOOL)repeat;
@property int empty;
@property int count;
-(void)reset;
@end
