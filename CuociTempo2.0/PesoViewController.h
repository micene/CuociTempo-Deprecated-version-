//
//  PesoViewController.h
//  CuociTempo2.0
//
//  Created by Supermix on 20/04/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Alimento;

@interface PesoViewController : UIViewController

@property (strong,nonatomic)Alimento* alimento;
@property (assign,nonatomic)int peso;

@end
