//  ViewController.h
//  Mastermind v4
//
//  Created by Simon Talaga on 21/02/14.
//  Copyright (c) 2014 Simon Talaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
@public
    NSString *toGuess;
    int difficulty;
}

@property (retain, nonatomic) IBOutlet UITextField *userinput;
@property (retain, nonatomic) IBOutlet UITextView *result;

- (IBAction)newGame:(id)sender;
- (IBAction)showSolution:(id)sender;
- (IBAction)correction:(id)sender;
- (IBAction)backgroundTouched:(id)sender;
- (long)getRandNumber:(int)digits;


@end