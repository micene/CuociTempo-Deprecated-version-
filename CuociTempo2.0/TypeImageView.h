//
//  TypeImageView.h
//  CuociTempo2.0
//
//  Created by Supermix on 05/06/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewController;

@interface TypeImageView : UIImageView <UIGestureRecognizerDelegate>

@property (retain,nonatomic) UIPanGestureRecognizer * pan;

@property (retain,nonatomic) UIButton * bottone;

@end
