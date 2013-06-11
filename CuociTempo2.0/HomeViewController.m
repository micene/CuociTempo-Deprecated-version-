//
//  HomeViewController.m
//  CuociTempo2.0
//
//  Created by Supermix on 04/06/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import "HomeViewController.h"
#import "TypeImageView.h"
#import "DataManager.h"
#import "ListaTipoTableViewController.h"
#import "PesoViewController.h"

#define DIMENSION 50

@interface HomeViewController (){
    
    int tag;
}

@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[DataManager sharedClass]setup];

    self.typeImage = @[@"Carne",@"Pesce",@"Verdure",@"Uovo",@"Frutta"];
    
    [self creaFinestra];
        
}


-(void)creaFinestra{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if(![prefs objectForKey:@"primoAvvio"]){
        
        for(int i = 0; i < self.typeImage.count; i++){
            
            self.type = [[TypeImageView alloc] initWithFrame:CGRectMake(rand()%300, rand()%300, DIMENSION, DIMENSION)];
            
            self.type.image =  [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.typeImage[i]]];
            
            self.type.tag = i;
            
            self.bottone = [UIButton buttonWithType:UIButtonTypeCustom];
            
            self.bottone.tag = i;
            
            self.bottone.frame = self.type.bounds;
            
            [self.bottone addTarget:self action:@selector(premuto:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.type addSubview:self.bottone];
            
            [self.view addSubview:self.type];
            
            [prefs setObject:NSStringFromCGRect(self.type.frame) forKey:[NSString stringWithFormat:@"frame%i",i]];
        
            [prefs setObject:[NSNumber numberWithBool:YES] forKey:@"primoAvvio"];

        }
        
    }else{
    
        for(int i = 0; i < self.typeImage.count; i++){
            
            self.type = [[TypeImageView alloc] initWithFrame:CGRectFromString([prefs objectForKey:[NSString stringWithFormat:@"frame%i",i]])];
            
            self.type.tag = i;
            
            self.type.image =  [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.typeImage[i]]];
            
            self.bottone = [UIButton buttonWithType:UIButtonTypeCustom];
            
            self.bottone.tag = i;
            
            self.bottone.frame = self.type.bounds;
                        
            [self.bottone addTarget:self action:@selector(premuto:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.type addSubview:self.bottone];
            
            [self.view addSubview:self.type];
            
        }
    
    }
        
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    //verifichiamo ql "segue" vogliamo visualizzare attraverso  identifier
    if ([segue.identifier isEqualToString:@"tipo"]) {
        
        ListaTipoTableViewController * lista_tipo = [segue destinationViewController];
        
        NSLog(@"tag %i\n%@",tag,self.typeImage[tag]);
                
        lista_tipo.title = self.typeImage[tag];
        
    }else if([segue.identifier isEqualToString:@"peso"]){
                
        PesoViewController *peso = segue.destinationViewController;
        
        peso.alimento = [[DataManager sharedClass] dammiAlimentoCompleto:self.typeImage[tag]];
        
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(IBAction)premuto:(id)sender
{
    
    NSLog(@"sender%i",[sender tag]);
    
    tag = [sender tag]; 
    
    if([sender tag] <= 2)
        [self performSegueWithIdentifier:@"tipo" sender:self];
    
    else
        [self performSegueWithIdentifier:@"peso" sender:self];
        
    
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
