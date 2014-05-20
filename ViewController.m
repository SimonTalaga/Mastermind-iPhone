//
//  ViewController.m
//  Mastermind v4
//
//  Created by Prof on 21/02/14.
//  Copyright (c) 2014 Prof. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    difficulty = 6; // On met par défaut la difficulté à 4, 4 chiffres à deviner !
    _userinput.placeholder = [NSString stringWithFormat:@"Entrez %i chiffres", difficulty];
    _result.editable = NO;
    NSNumber *tirage = [[NSNumber alloc]initWithLong:[self getRandNumber:difficulty]];
    // toGuess = [tirage stringValue]; 
    
    toGuess = [[tirage stringValue] retain]; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [toGuess release]; // release decremente retainCount sur l'objet NSSting pointe par toGuess
    [_userinput release];
    [_result release];
    [super dealloc];
}

// La difficulté est rentrée et le nombre de chiffre du nombre sorti en est fonction
- (long)getRandNumber:(int)digits {
    long nombre;
    
    switch (digits) {
        case 4:
            nombre = arc4random() % 9000 + 1000;
            break;
        case 5:
            nombre = arc4random() % 90000 + 10000;
            break;
        case 6:
            nombre = arc4random() % 900000 + 100000;
            break;
        case 7:
            nombre = arc4random() % 9000000 + 1000000;
            break;
        case 8:
            nombre = arc4random() % 90000000 + 10000000;
            break;
        case 9:
            nombre = arc4random() % 900000000 + 100000000;
            break;
        case 10:
            nombre = arc4random() % 9000000000 + 1000000000;
            break;
            
        default: nombre = 1000;
            break;
    }
    
    return nombre;
}

- (IBAction)newGame:(id)sender {
    
    
    // Nouveau tirage
    _result.text = nil;
    [toGuess release];
    NSNumber *tirage = [[NSNumber alloc]initWithLong:[self getRandNumber:difficulty]];
    toGuess = [[tirage stringValue] retain];
    
    
    UIAlertView *popup = [[UIAlertView alloc] initWithTitle:@"Nouvelle partie"
                                                    message:@"Une nouvelle combinaison a été tirée"
                                                   delegate:self
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [popup show];
    [popup release];
    
}

- (IBAction)showSolution:(id)sender {
    
    UIAlertView *popup = [[UIAlertView alloc] initWithTitle:@"Solution"
                                                    message: [NSString stringWithFormat:@"La solution était : %@",toGuess]
                                                   delegate:self
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [popup show];
    [popup release];
    
}

- (IBAction)correction:(id)sender {
    
    [_userinput resignFirstResponder];
    
    if (_userinput.text.length != difficulty)
    {
        UIAlertView *popup = [[UIAlertView alloc] initWithTitle:@"Echec"
                                                        message:[NSString stringWithFormat:@"Veuillez entrer %i chiffres !", difficulty]
                                                       delegate:self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [popup show];
        [popup release];
    }
    
    else
    {
        ////////////////////////////////
        //                            //
        //  Algorithme de correction  //
        //                            //
        ////////////////////////////////
        
        if (!(_userinput.text.intValue == toGuess.intValue)) {
            
            int nbWellPlaced = 0;
            int nbIllPlaced = 0;
            
            NSMutableString *wellPlaced = [[NSMutableString alloc]initWithString:@""];
            // On crée autant les étoiles en fonction de la difficulté
            for (int i = 0; i < difficulty; i++) {
                [wellPlaced appendString:@"*"];
                NSLog(@"%@", wellPlaced);
            }
            
            
            
            // On commence par tester les bien placés
            for (int i = 0; i < difficulty; i++)
            {
                NSLog(@"%i", i);
                if ([_userinput.text characterAtIndex:i] == [toGuess characterAtIndex:i]) {
                    nbWellPlaced++;
                    [wellPlaced replaceCharactersInRange:NSMakeRange(i, 1) withString: [NSString stringWithFormat:@"%c", [toGuess characterAtIndex:i]]];
                }
                
            }
            
            // On connait les bien placés, dont la position est dans wellPlaced
            for (int i = 0; i < difficulty; i++)
            {
                NSLog(@"%i", i);
                // Si le nombre est bien placé, on le saute dans la première boucle
                if ([wellPlaced characterAtIndex:i] == '*')
                {
                    for (int j = 0; j < difficulty; j++)
                    {
                        // ... Et dans la deuxième pour ne pas le compter plusieurs fois !
                        if ([_userinput.text characterAtIndex:i] == [toGuess characterAtIndex:j] && [wellPlaced characterAtIndex:j] == '*')
                        {
                            nbIllPlaced++;
                        }
                    }
                }
            }
            
            // On récupère l'ancienne valeur de la TextView
            NSString* cache = [NSString stringWithString:_result.text];
            // On l'ajoute au nouveau contenu
            _result.text = [NSString stringWithFormat:@"%@ - Bien placés : %i - %@ - Mal placés : %i\n%@", _userinput.text, nbWellPlaced, wellPlaced, nbIllPlaced, cache];
            
        }
        
        else
        {
            // Le joueur a gagné
            NSString* cache = [NSString stringWithString:_result.text];
            _result.text = [NSString stringWithFormat:@"%@Bravo ! Le nombre était bel et bien %@", cache, toGuess];
            
        }
    }
}

- (IBAction)backgroundTouched:(id)sender
{
       [_userinput resignFirstResponder];
}

- (IBAction)chooseDifficulty:(id)sender {
}

@end