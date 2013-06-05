//
//  HomeCollectionViewController.m
//  CuociTempo2.0
//
//  Created by Supermix on 20/04/13.
//  Copyright (c) 2013 Stefano. All rights reserved.
//

#import "HomeCollectionViewController.h"
#import "Alimento.h"
#import "DataManager.h"
#import "TypeCell.h"
#import "ListaTipoTableViewController.h"
#import "ListaCompletaViewController.h"
#import "PesoViewController.h"

@interface HomeCollectionViewController ()
{
    int indice;
}
@end

@implementation HomeCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[DataManager sharedClass]setup];
    
    self.typeImage = @[@"Carne",@"Pesce",@"Frutta",@"Uovo"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Collection View Data Sources

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.typeImage.count;
    
}

// The cell that is returned must be retrieved from a call to - dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSString * cella = @"cell";

    TypeCell * cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   // NSLog(@"%@",cell.reuseIdentifier);
    
    UIImage *typeImage = [[UIImage alloc] init];
    typeImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[self.typeImage objectAtIndex:indexPath.row]]];
    
    cell.myTypeImageView.image = typeImage;
    
    return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
   // NSLog(@"didsewe %i",indexPath.row);
    
    indice = indexPath.row;
    
    if(indexPath.row <= 1)
        
        [self performSegueWithIdentifier:@"tipo" sender:collectionView.indexPathsForSelectedItems];
    
    else
        [self performSegueWithIdentifier:@"peso" sender:collectionView.indexPathsForSelectedItems];
    
}

//questa è l'azione collegata al gesture recognizer di tipo Pan (tocca-e-muovi)
- (IBAction)moveCell:(UIPanGestureRecognizer *)sender {

        
    //controlliamo che lo stato della gesture sia tutto meno che begin
    if ((sender.state == UIGestureRecognizerStateChanged)
        || (sender.state == UIGestureRecognizerStateEnded)) {
        
        //estraiamo la view della gesture
        UICollectionView *piece = (UICollectionView*)[sender view];
        
        //creaimo un punto ce ci servirà per la traslazione calcolando la traslazione del recognizer rispetto alla view principale
        CGPoint translation = [sender translationInView:[piece superview]];
        
        //spostiamo il centro della view del recognizer sommando il punto (x o y) alla traslazione
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        
        //infine azzeriamo la traslazione in modo che al tocco successivo il recognizer sia azzerato
        [sender setTranslation:CGPointZero inView:[piece superview]];
        
       /* CGPoint newCenter = piece.center;
        
        float x = newCenter.x;
        
        float y = newCenter.y;
        
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setFloat:x forKey:@"COORD X"];
        [userDefaults setFloat:y forKey:@"COORD Y"];
        
        [userDefaults synchronize];
        
        NSLog(@"%f , %f",x,y);*/
        
    }
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
   // NSLog(@"%@",segue.identifier);
    
    if ([segue.identifier isEqualToString:@"lista"] ) {
        
        ListaCompletaViewController* lista_completa = segue.destinationViewController;
        
        lista_completa.sezioni = self.typeImage;
        
    }else{

        if([segue.identifier isEqualToString:@"tipo"]){
            
            ListaTipoTableViewController * lista_tipo = [segue destinationViewController];
            
            lista_tipo.title = self.typeImage[indice];
            
        }else if([segue.identifier isEqualToString:@"peso"]){
            
            NSLog(@"indice  %i",indice);
            
            PesoViewController *peso = segue.destinationViewController;
            
            peso.alimento = [[DataManager sharedClass] dammiAlimentoCompleto:self.typeImage[indice]];
            
        }

    }
}
@end
