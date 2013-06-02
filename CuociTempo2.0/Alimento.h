//
//  Alimento.h
//  CuociTempo2.0
//
//  Created by Supermix on 21/05/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Alimento : NSManagedObject

@property (nonatomic, retain) NSString * cottura250;
@property (nonatomic, retain) NSString * cottura500;
@property (nonatomic, retain) NSString * cottura1000;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * tipo;


@end
