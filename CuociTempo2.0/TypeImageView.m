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

    if (sender.state == UIGestureRecognizerStateBegan) 

        prevLocation = piece.center;

    //se l'img e cambiata o "finito"
    if ((sender.state == UIGestureRecognizerStateChanged)) {
        
        CGPoint traslation = [sender translationInView:[piece superview]]; //calcola la traslazione dell "piece" dalla superview

        [piece setCenter:CGPointMake([piece center].x + traslation.x,      //calcola l'offset e "centra" l'immagine
                                         [piece center].y+traslation.y)];
        
        [sender setTranslation:CGPointZero inView:[piece superview]]; //azzera la traslazione
        

    }
    
    if(sender.state == UIGestureRecognizerStateEnded){
        
        if(piece.frame.origin.x <0 || piece.frame.origin.y < 0 || (piece.frame.origin.x) > 270 || (piece.frame.origin.y) > 369)
            
            [piece setCenter:prevLocation];
            
        NSString * frame = NSStringFromCGRect([self frame]);
        
        [[NSUserDefaults standardUserDefaults] setObject:frame forKey:[NSString stringWithFormat:@"frame%i",piece.tag]];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    
    }
    
}

@end