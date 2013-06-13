//
//  TypeImageView.m
//  CuociTempo2.0
//
//  Created by Supermix on 05/06/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import "TypeImageView.h"

@implementation TypeImageView{
    
    UIView *piece;
    
    CGPoint prevLocation;

}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(sposta:)];

        [self setUserInteractionEnabled:YES];
        
        [self addGestureRecognizer:self.pan];
        
    }
    
    return self;

}

-(void)sposta:(UIPanGestureRecognizer*)sender
{
    piece  = [sender view]; //estrae la view sotto il gesture recognizer

    //appena inizio a spostare l'img
    if (sender.state == UIGestureRecognizerStateBegan)

        //salvo la locazione dell immagine prima di spostarla
        prevLocation = piece.center;
        
    //se l'img e cambiata o "finito"
    if ((sender.state == UIGestureRecognizerStateChanged)) {
        
        CGPoint traslation = [sender translationInView:[piece superview]]; //calcola la traslazione dell "piece" dalla superview

        [piece setCenter:CGPointMake([piece center].x + traslation.x,      //calcola l'offset e "centra" l'immagine
                                         [piece center].y+traslation.y)];
        
        [sender setTranslation:CGPointZero inView:[piece superview]]; //azzera la traslazione
        
        
        

    }
    
    //se ho finito d spostare l'img
    if(sender.state == UIGestureRecognizerStateEnded){
        
        //se l'img e out of bounds torna automaticamente alla sua locazione precedenter
        if(piece.frame.origin.x <0 || piece.frame.origin.y < 0 || (piece.frame.origin.x + self.frame.size.width) > self.superview.frame.size.width || (piece.frame.origin.y + self.frame.size.height) > self.superview.frame.size.height)
            
            [piece setCenter:prevLocation];
        
        for(int i = 0;i<self.superview.subviews.count;i++)
        {
            
            CGRect locationOtherView = CGRectFromString([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"frame%i",i]]);
            
            if(i == piece.tag) continue;
            
            float distanza = sqrtf(powf((piece.frame.origin.x - locationOtherView.origin.x), 2) + powf((piece.frame.origin.y - locationOtherView.origin.y), 2));
            
           // NSLog(@"distanza = %.0f",distanza);
            
            if(distanza<self.frame.size.width)
                [piece setCenter:prevLocation]; 
        
        }
        
            
        NSString * frame = NSStringFromCGRect([self frame]);
        
        [[NSUserDefaults standardUserDefaults] setObject:frame forKey:[NSString stringWithFormat:@"frame%i",piece.tag]];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    
    }
    
}

@end