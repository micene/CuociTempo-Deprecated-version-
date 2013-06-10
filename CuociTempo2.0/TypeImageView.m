//
//  TypeImageView.m
//  CuociTempo2.0
//
//  Created by Supermix on 05/06/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import "TypeImageView.h"
#import "HomeViewController.h"

@implementation TypeImageView{
    
    UIView *piece;

}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(sposta:)];

//        self.touch = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tocca:)];
        
        self.touch.numberOfTapsRequired = 1;
        
        self.touch.delegate  = self;
        
        [self setUserInteractionEnabled:YES];
        
        [self addGestureRecognizer:self.pan];
        
    }
    
    return self;

}

/*-(UIPanGestureRecognizer *)pan{
    
    if (_pan) {
        NSLog(@"esisto");
        return _pan;
    }
    
    _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gesture:)];
    // [_pan setDelegate:self];
    return _pan;
}*/

-(void)sposta:(UIPanGestureRecognizer*)sender
{
    
    //se l'img e cambiata o "finito"
    if ((sender.state == UIGestureRecognizerStateChanged)) {
        
        piece  = [sender view]; //estrae la view sotto il gesture recognizer
        
        CGPoint traslation = [sender translationInView:[piece superview]]; //calcola la traslazione dell "piece" dalla superview
        
        [piece setCenter:CGPointMake([piece center].x + traslation.x,      //calcola l'offset e "centra" l'immagine
                                         [piece center].y+traslation.y)];
        
        [sender setTranslation:CGPointZero inView:[piece superview]]; //azzera la traslazione
            
    }
    
    if(sender.state == UIGestureRecognizerStateEnded){
        
        NSString * frame = NSStringFromCGRect([self frame]);
        
        [[NSUserDefaults standardUserDefaults] setObject:frame forKey:[NSString stringWithFormat:@"frame%i",piece.tag]];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
    }

}

-(void)tocca:(UITapGestureRecognizer*)sender{

    
}

@end