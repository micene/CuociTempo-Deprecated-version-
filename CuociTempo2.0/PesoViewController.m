//
//  PesoViewController.m
//  CuociTempo2.0
//
//  Created by Supermix on 20/04/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import "PesoViewController.h"
#import "Alimento.h"
#import "TimerViewController.h"

@interface PesoViewController ()
@end

@implementation PesoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.navigationItem.title = self.alimento.nome;
    
   // NSLog(@"PesoViewController - k250: %@, k500:%@, k1000:%@",self.alimento.cottura250,self.alimento.cottura500,self.alimento.cottura1000);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selezionaPeso:(UISegmentedControl*)sender {
    
    self.peso = sender.selectedSegmentIndex;

}

-(int)qualePesoHaiScelto{
    
    return self.peso;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //verifichiamo ql "segue" vogliamo visualizzare attraverso  identifier
    if ([segue.identifier isEqualToString:@"run"]) {
        
        TimerViewController* timer = segue.destinationViewController;
        
        timer.title = self.alimento.nome;
        
        timer.alimento = self.alimento;
        
        timer.peso = self.peso;
    }
    
}

@end
