//
//  HomeCollectionViewController.h
//  CuociTempo2.0
//
//  Created by Supermix on 20/04/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewController : UICollectionViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *movePanGesture;

@property (strong, nonatomic) NSArray *typeImage;


@end
