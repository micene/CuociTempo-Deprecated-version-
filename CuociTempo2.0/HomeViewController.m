//
//  HomeViewController.m
//  CuociTempo2.0
//
//  Created by Supermix on 04/06/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import "HomeViewController.h"
#import "TypeImageView.h"

#define DIMENSION 50

@interface HomeViewController ()
{
 
    NSMutableArray * arrayType ;    
    float x;
    float y;
    
}
@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.typeImage = @[@"Carne.jpg",@"Pesce.jpg",@"Frutta.jpg",@"Uovo.jpg",@"Verdure.jpg"];
    
    [self creaFinestra];
    
   
    
}


-(void)creaFinestra{
    
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if(![prefs objectForKey:@"primoAvvio"]){
        
        for(int i = 0; i < self.typeImage.count; i++){
            
            self.type = [[TypeImageView alloc] initWithFrame:CGRectMake(rand()%300, rand()%300, DIMENSION, DIMENSION)];
            
            self.type.image =  [UIImage imageNamed:self.typeImage[i]];
            
            self.type.tag = i;
            
            NSLog(@"i%i - %@",i,NSStringFromCGRect(self.type.frame));
            
            [self.view addSubview:self.type];
            
            [prefs setObject:NSStringFromCGRect(self.type.frame) forKey:[NSString stringWithFormat:@"frame%i",i]];
        
            [prefs setObject:[NSNumber numberWithBool:YES] forKey:@"primoAvvio"];

        
        }
    
    }else{
    
        for(int i = 0; i < self.typeImage.count; i++){
            
            self.type = [[TypeImageView alloc] initWithFrame:CGRectFromString([prefs objectForKey:[NSString stringWithFormat:@"frame%i",i]])];
            
            self.type.tag = i;
            
            self.type.image =  [UIImage imageNamed:self.typeImage[i]];

            [self.view addSubview:self.type];
            
        }
        
    }

    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*@synthesize pan = _pan;

-(UIPanGestureRecognizer *)pan{
    
    if (_pan) {
        NSLog(@"sadasd");
        return _pan;
    }
    
    _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gesture:)];
   // [_pan setDelegate:self];
    return _pan;
}

-(void)gesture:(UIPanGestureRecognizer *)gest{
    
    NSLog(@"ahaha");
    //se l'img e cambiata o "finito"
    if ((gest.state == UIGestureRecognizerStateChanged)|| (gest.state == UIGestureRecognizerStateEnded)) {
        
        UIView * piece = [gest view]; //estrae la view sotto il gesture recognizer
        
        
        CGPoint traslation = [gest translationInView:[piece superview]]; //calcola la traslazione dell "piece" dalla superview
        
        [piece setCenter:CGPointMake([piece center].x + traslation.x,      //calcola l'offset e "centra" l'immagine
                                     [piece center].y+traslation.y)];
        
        NSLog(@"piece x %.2f - y %.2f",[piece center].x,[piece center].y);
        
        [gest setTranslation:CGPointZero inView:[piece superview]]; //azzera la traslazione
        
        
    }
    
    
}*/

/*- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    
    //se l'img e cambiata o "finito"
    if ((sender.state == UIGestureRecognizerStateChanged)) {
        
//        NSLog(@"p");
        
        UIView * piece = [sender view]; //estrae la view sotto il gesture recognizer
        
        
        CGPoint traslation = [sender translationInView:[piece superview]]; //calcola la traslazione dell "piece" dalla superview
        
       [piece setCenter:CGPointMake([piece center].x + traslation.x,      //calcola l'offset e "centra" l'immagine
                                        [piece center].y+traslation.y)];
        
       // NSLog(@"piece x %.2f - y %.2f",[piece center].x,[piece center].y);
        
        [sender setTranslation:CGPointZero inView:[piece superview]]; //azzera la traslazione
        
        
    }
    
    if(sender.state == UIGestureRecognizerStateEnded){
        
        [[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGRect([self.typeImageView frame]) forKey:@"frame"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
}*/

@end
