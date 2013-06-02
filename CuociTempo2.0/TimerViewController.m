//
//  TimerViewController.m
//  CuociTempo2.0
//
//  Created by Supermix on 22/04/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import "TimerViewController.h"
#import "Alimento.h"

@interface TimerViewController (){
    
    int countdown;
    
    BOOL isRunning;
    
    //creiamo una seconda primitiva per salvare il volume impostato dall'utente
    float myVolume;
    
    //battezziamo il player musicale in modo da renderlo un'oggetto globale
    AVAudioPlayer * player;

    
}

@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;

@property (weak,nonatomic) NSTimer * theTimer;

@end

@implementation TimerViewController

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
    
    countdown = [self tempoPerPeso].doubleValue* 60;

    isRunning = NO;
    
    myVolume = 0.5;

    self.countdownLabel.text = [self formattaLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//metodo per capire quale tempo di cottura per peso e da visualizzaare
-(NSString *)tempoPerPeso{
 
    NSString * qualePeso = @"";
    
    switch (self.peso) {
        case 0:
            qualePeso = self.alimento.cottura250;
            break;
        case 1:
            qualePeso = self.alimento.cottura500;
            break;
        case 2:
            qualePeso = self.alimento.cottura1000;
            break;
        default:
            break;
    }
    return qualePeso;
}

//metodo per lo start del timer
- (IBAction)start:(id)sender {
    
    if (isRunning) return; //se il run e attivo esci
    
    isRunning = true;   //il timer attivo
    
    [self tick]; //il primo tic tac lo fai a "mano"
    
    self.theTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                     target:self
                                                   selector:@selector(tick)
                                                   userInfo:nil
                                                    repeats:true];
}

- (IBAction)stop:(id)sender {
    
    if(player.isPlaying) [player stop];
    
    if(isRunning == false) return;
    
    if ([self.theTimer isValid]) [self.theTimer invalidate]; //disabilita il timer
    
    isRunning = false;
    
    countdown = [self tempoPerPeso].doubleValue*60;
    
    self.countdownLabel.text = [self formattaLabel];
    
}

-(void)tick{
    
    countdown--;
    
    //controllo timer finito
    if (countdown < 0) {
        //codice finale
        [self precaricaSuono];
        [player play];
        
        if ([self.theTimer isValid]) [self.theTimer invalidate]; //disabilita il timer
        
        isRunning = false;
        
        countdown = [self tempoPerPeso].doubleValue *60;
        
       // NSLog(@"int %i --- double %f",[self tempoPerPeso].integerValue,[self tempoPerPeso].doubleValue);
        
        return;
    }
    
    self.countdownLabel.text = [self formattaLabel];

}

-(NSString *)formattaLabel{
    
    int hours = countdown/3600;
    int minute = ((countdown/60) - hours*60);
    int second = (countdown - ((minute *60) + hours *3600));
    //NSLog(@"%i ore\n%i minuti\n %i secondi",hours,minute,second);
    return [NSString stringWithFormat:@"%02i:%02i:%02i",hours,minute,second];
}


-(void)precaricaSuono{
    
    //creiamo un oggetto NSURL vuoto
    NSURL * url;
    
    //creaimo una stringa che contiene il percorso che porta ai nostri files
    NSString * percorsoBundle = [[NSBundle mainBundle] resourcePath];
    
    //creiamo il percorso del nostro file audio unendo insieme il percorso dei files al nome del file (con uno / in mezzo)
    url = [NSURL fileURLWithPath:[percorsoBundle stringByAppendingPathComponent:@"Alarm.mp3"]];
    
    //carichiamo il suono in memoria
    player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    
    //imposto il volume iniziale
    player.volume = myVolume;
    
    //impostiamo ripetizioni infinite
    player.numberOfLoops = -1;
    
    [player prepareToPlay];
    
}


@end
