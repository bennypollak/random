//
//  MainViewController.m
//  Random
//
//  Created by Benny Pollak on 7/10/13.
//  Copyright (c) 2013 Alben Software. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () {
    NSTimer *timer;
    char randstate[2048];
    int count;
    BOOL running;
}

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initRandomNumberGenerator];
    count = 0;
    [_canvas setup];
    [_canvas setNeedsDisplay];
    [self updateDisplay];
    running = NO;

}
-(void)viewDidAppear:(BOOL)animated
{
    [_canvas setNeedsDisplay];
    [self updateDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

-(void)initRandomNumberGenerator {
	if(initstate(time(NULL), randstate, 256)==NULL){
		//printf("Error\n");
	}else{
		//printf("Success\n");
	}
	return;
}

-(void)startTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(elapsedCB) userInfo:nil repeats:YES];

}
-(void) elapsedCB {
    [_canvas upWithRnd:((double)random()) / RAND_MAX repeat:_repeatSw.on];
    [_canvas setNeedsDisplay];
    [self updateDisplay];
    count++;
}
-(void)updateDisplay
{
    _lbl.text = [NSString stringWithFormat:@"Views %d seen %d unseen %d",
                 count, _canvas.count-_canvas.empty,_canvas.empty];
    _lbl1.text = [NSString stringWithFormat:@"Views %2.2f%% unseen %2.2f%%",
                  100.0*(double)count/_canvas.count, 100.0*(double)_canvas.empty/_canvas.count];
    
}

- (IBAction)btnAct:(id)sender {
    if (!running) {
        [self startTimer];
        [_btn setTitle:@"Pause" forState:UIControlStateNormal];
        running = YES;
    } else {
        [timer invalidate];
        [_btn setTitle:@"Start" forState:UIControlStateNormal];
        running = NO;
    }
}

- (IBAction)rstAction:(id)sender {
    [_canvas reset];
    [_canvas setNeedsDisplay];
    count = 0;
    [self updateDisplay];
}

- (IBAction)launchFeedback:(id)sender {
}
@end
