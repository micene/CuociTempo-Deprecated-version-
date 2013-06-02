//
//  DataManager.m
//  CuociTempo2.0
//
//  Created by Supermix on 20/04/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import "DataManager.h"

#import "Alimento.h"

@implementation DataManager

static DataManager* sharedClassInstance = nil;

+(DataManager *)sharedClass{
    
    @synchronized(self){
        if(!sharedClassInstance){
            
            sharedClassInstance = [[DataManager alloc]init];
        
        }
        
        return sharedClassInstance;
    }
}

-(void)setup{
    
    NSArray* records = [Alimento MR_findAll];
    
    if(records.count < 1){
        
        [self creaAlimento:@"Carne" nome:@"Manzo" cottura250:@"1" cottura500:@"2.5" cottura1000:@"3"];
        
        [self creaAlimento:@"Carne" nome:@"Vitello" cottura250:@"2" cottura500:@"3" cottura1000:@"4"];

        [self creaAlimento:@"Pesce" nome:@"Triglia" cottura250:@"4" cottura500:@"5" cottura1000:@"6"];
        
        [self creaAlimento:@"Pesce" nome:@"Nasello" cottura250:@"4" cottura500:@"5" cottura1000:@"6"];

        [self creaAlimento:@"Frutta" nome:@"Frutta" cottura250:@"4" cottura500:@"5" cottura1000:@"6"];

        [self creaAlimento:@"Uovo" nome:@"Uovo" cottura250:@"4" cottura500:@"5" cottura1000:@"6"];

        
    }
}

-(void)creaAlimento:(NSString *)tipo
               nome:(NSString*)nome
         cottura250:(NSString*)cottura250
         cottura500:(NSString*)cottura500
        cottura1000:(NSString*)cottura1000{

    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    Alimento * alimento = [Alimento MR_createInContext:localContext];
     
    alimento.tipo = tipo;
    alimento.nome = nome;
    alimento.cottura250 = cottura250;
    alimento.cottura500 = cottura500;
    alimento.cottura1000 = cottura1000;
        
    [localContext MR_saveOnlySelfAndWait];
    
}

-(int)quanteCelleDevoFare{
    
    NSArray * records = [Alimento MR_findAll];
     return records.count;
    
}

-(int)quanteCelleTipoDevoFare:(NSString*)nome_tipo{
    
    NSArray * records = [Alimento MR_findByAttribute:@"tipo" withValue:nome_tipo];
    
    return records.count;
}


-(NSString*)dammiNomePerCella:(int)cella{
    
    NSArray * records = [Alimento MR_findAllSortedBy:@"tipo" ascending:YES];
    
    Alimento * alimento = records[cella];
    
    return [NSString stringWithFormat:@"%@",
            alimento.nome];
    
}

-(NSString*)dammiNomePerTipo:(int)cella tipo:(NSString*)nome_tipo{
    
    NSArray* records = [Alimento MR_findByAttribute:@"tipo" withValue:nome_tipo];
    
    Alimento *alimento = records[cella];
    
    return alimento.nome;
    
}


-(Alimento*)dammiAlimentoCompleto:(int)cella nome:(NSString*)tipo{
    
    NSArray * records = [Alimento MR_findByAttribute:@"tipo" withValue:tipo];
    
    Alimento * alimento = records[cella];

    return alimento;
}

-(Alimento*)dammiAlimentoCompleto:(NSString*)tipo{
    
    NSArray * records = [Alimento MR_findByAttribute:@"tipo" withValue:tipo];
    
    int c = records.count;
    
    NSLog(@"records %i",records.count);
    
    Alimento * alimento = records[c-1];
    
    return  alimento;
}

@end

