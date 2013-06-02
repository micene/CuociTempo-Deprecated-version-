//
//  DataManager.h
//  CuociTempo2.0
//
//  Created by Supermix on 20/04/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Alimento;

@interface DataManager : NSObject

+(DataManager*)sharedClass;

-(void)setup;

-(void)creaAlimento:(NSString*)tipo
               nome:(NSString*)nome
         cottura250:(NSString*)cottura250
         cottura500:(NSString*)cottura500
        cottura1000:(NSString*)cottura1000;

-(int)quanteCelleDevoFare;

-(int)quanteCelleTipoDevoFare:(NSString*)nome_tipo;

-(NSString*)dammiNomePerCella:(int)cella;

-(NSString*)dammiNomePerTipo:(int)cella tipo:(NSString*)nome_tipo;

-(Alimento*)dammiAlimentoCompleto:(int)cella nome:(NSString*)tipo;

-(Alimento*)dammiAlimentoCompleto:(NSString*)tipo;
@end
