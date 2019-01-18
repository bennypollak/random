//
//  MainViewController.h
//  Random
//
//  Created by Benny Pollak on 7/10/13.
//  Copyright (c) 2013 Alben Software. All rights reserved.
//

#import "FlipsideViewController.h"
#import "CanvasView.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet CanvasView *canvas;
@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UISwitch *repeatSw;
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)btnAct:(id)sender;
- (IBAction)rstAction:(id)sender;
- (IBAction)launchFeedback:(id)sender;

@end
