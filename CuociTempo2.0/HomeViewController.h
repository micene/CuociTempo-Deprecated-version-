//
//  HomeViewController.h
//  CuociTempo2.0
//
//  Created by Supermix on 04/06/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TypeImageView;

@interface HomeViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong,nonatomic) TypeImageView * type;

@property (strong, nonatomic) NSArray *typeImage;

@property (retain,nonatomic) UIButton * bottone;



@end
