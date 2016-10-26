//
//  LoadInitialData.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 24/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "LoadInitialData.h"


@implementation LoadInitialData

- (void)loadInitialData
{
    //get app delegate
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CarModel *car1=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car1 setBrand:@"Acura"];
    [car1 setYear:@"2007"];
    [car1 setModel:@"RDX Technology"];
    
    CarModel *car2=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car2 setBrand:@"Alfa Romeo"];
    [car2 setYear:@"2015"];
    [car2 setModel:@"4C Base"];
    
    CarModel *car3=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car3 setBrand:@"Aston Martin"];
    [car3 setYear:@"2016"];
    [car3 setModel:@"Vanquish"];
    
    CarModel *car4=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car4 setBrand:@"Audi"];
    [car4 setYear:@"2007"];
    [car4 setModel:@"Q7 3.6 Premium"];
    
    CarModel *car5=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car5 setBrand:@"Bently"];
    [car5 setYear:@"2013"];
    [car5 setModel:@"Mulsanne Base"];
    
    CarModel *car6=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car6 setBrand:@"BMW"];
    [car6 setYear:@"2003"];
    [car6 setModel:@"Z8"];
    
    CarModel *car7=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car7 setBrand:@"Bugatti"];
    [car7 setYear:@"2012"];
    [car7 setModel:@"Veyron 16.4 Super Sport"];
    
    CarModel *car8=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car8 setBrand:@"Buick"];
    [car8 setYear:@"2011"];
    [car8 setModel:@"Enclave 1XL"];
    
    CarModel *car9=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car9 setBrand:@"Cadillac"];
    [car9 setYear:@"2015"];
    [car9 setModel:@"XTS Premium"];
    
    CarModel *car10=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car10 setBrand:@"Chervolet"];
    [car10 setYear:@"2017"];
    [car10 setModel:@"Traverse FWD"];
    
    CarModel *car11=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car11 setBrand:@"Chrysler"];
    [car11 setYear:@"2010"];
    [car11 setModel:@"PT Cruiser Classic"];
    
    CarModel *car12=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car12 setBrand:@"Daewoo"];
    [car12 setYear:@"2001"];
    [car12 setModel:@"Lanos S"];
    
    CarModel *car13=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car13 setBrand:@"Dodge"];
    [car13 setYear:@"2007"];
    [car13 setModel:@"Grand Caravan SE"];
    
    CarModel *car14=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car14 setBrand:@"Ferrari"];
    [car14 setYear:@"2014"];
    [car14 setModel:@"LaFerrari"];
    
    CarModel *car15=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car15 setBrand:@"FIAT"];
    [car15 setYear:@"2012"];
    [car15 setModel:@"500 Pop"];
    
    CarModel *car16=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car16 setBrand:@"Fisker"];
    [car16 setYear:@"2012"];
    [car16 setModel:@"Karma EcoSport"];
    
    CarModel *car17=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car17 setBrand:@"Ford"];
    [car17 setYear:@"2005"];
    [car17 setModel:@"Mustang Base"];
    
    CarModel *car18=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car18 setBrand:@"Genesis"];
    [car18 setYear:@"2017"];
    [car18 setModel:@"G80 3.8"];
    
    CarModel *car19=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car19 setBrand:@"GMC"];
    [car19 setYear:@"2013"];
    [car19 setModel:@"Terrain SLE-1"];
    
    CarModel *car20=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car20 setBrand:@"Honda"];
    [car20 setYear:@"2008"];
    [car20 setModel:@"CR-V LX"];
    
    CarModel *car21=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car21 setBrand:@"Hummer"];
    [car21 setYear:@"2006"];
    [car21 setModel:@"H1 Alpha Open Top"];
    
    CarModel *car22=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car22 setBrand:@"Hyundai"];
    [car22 setYear:@"2012"];
    [car22 setModel:@"Sonata GLS"];
    
    CarModel *car23=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car23 setBrand:@"Infiniti"];
    [car23 setYear:@"2010"];
    [car23 setModel:@"G37 Journey"];
    
    CarModel *car24=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car24 setBrand:@"Jaguar"];
    [car24 setYear:@"2006"];
    [car24 setModel:@"S-Type R"];
    
    CarModel *car25=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car25 setBrand:@"Jeep"];
    [car25 setYear:@"2008"];
    [car25 setModel:@"Wrangler X"];
    
    CarModel *car26=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car26 setBrand:@"Kia"];
    [car26 setYear:@"2016"];
    [car26 setModel:@"K900 Luxury"];
    
    CarModel *car27=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car27 setBrand:@"Lamborghini"];
    [car27 setYear:@"2016"];
    [car27 setModel:@"Aventador"];
    
    CarModel *car28=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car28 setBrand:@"Land Rover"];
    [car28 setYear:@"2013"];
    [car28 setModel:@"LR4 Base"];
    
    CarModel *car29=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car29 setBrand:@"Lexus"];
    [car29 setYear:@"2005"];
    [car29 setModel:@"RX 330 STD"];
    
    CarModel *car30=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car30 setBrand:@"Lincoln"];
    [car30 setYear:@"2007"];
    [car30 setModel:@"MKX"];
    
    CarModel *car31=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car31 setBrand:@"Lotus"];
    [car31 setYear:@"2010"];
    [car31 setModel:@"Elise"];
    
    CarModel *car32=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car32 setBrand:@"Maserati"];
    [car32 setYear:@"2016"];
    [car32 setModel:@"GranTurismo Sport"];
    
    CarModel *car33=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car33 setBrand:@"Maybach"];
    [car33 setYear:@"2009"];
    [car33 setModel:@"Type 62 S"];
    
    CarModel *car34=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car34 setBrand:@"Mazada"];
    [car34 setYear:@"2010"];
    [car34 setModel:@"Mazda3 S"];
    
    CarModel *car35=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car35 setBrand:@"McLaren"];
    [car35 setYear:@"2014"];
    [car35 setModel:@"Plug-In Hybrid"];
    
    CarModel *car36=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car36 setBrand:@"Mercedes-Benz"];
    [car36 setYear:@"2011"];
    [car36 setModel:@"GL550 4MATIC"];
    
    CarModel *car37=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car37 setBrand:@"Mercury"];
    [car37 setYear:@"2003"];
    [car37 setModel:@"Grand Marquis LS"];
    
    CarModel *car38=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car38 setBrand:@"Mini"];
    [car38 setYear:@"2007"];
    [car38 setModel:@"Cooper S"];
    
    CarModel *car39=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car39 setBrand:@"Mitsubishi"];
    [car39 setYear:@"2007"];
    [car39 setModel:@"Galant ES"];
    
    CarModel *car40=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car40 setBrand:@"Nissan"];
    [car40 setYear:@"2009"];
    [car40 setModel:@"GT-R Premium"];
    
    CarModel *car41=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car41 setBrand:@"Pontiac"];
    [car41 setYear:@"2005"];
    [car41 setModel:@"Grand Prix GT"];
    
    CarModel *car42=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car42 setBrand:@"Porsche"];
    [car42 setYear:@"2015"];
    [car42 setModel:@"918 Spyder"];
    
    CarModel *car43=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car43 setBrand:@"RAM"];
    [car43 setYear:@"2016"];
    [car43 setModel:@"1500 Sport"];
    
    CarModel *car44=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car44 setBrand:@"Rolls-Royce"];
    [car44 setYear:@"2011"];
    [car44 setModel:@"Ghost"];
    
    CarModel *car45=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car45 setBrand:@"Saab"];
    [car45 setYear:@"2006"];
    [car45 setModel:@"9-3 2.0T"];
    
    CarModel *car46=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car46 setBrand:@"Saturn"];
    [car46 setYear:@"2008"];
    [car46 setModel:@"Sky Red Line"];
    
    CarModel *car47=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car47 setBrand:@"Scion"];
    [car47 setYear:@"2013"];
    [car47 setModel:@"FR-S"];
    
    CarModel *car48=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car48 setBrand:@"Smart"];
    [car48 setYear:@"2016"];
    [car48 setModel:@"ForTwo Pure"];
    
    CarModel *car49=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car49 setBrand:@"Subaru"];
    [car49 setYear:@"2010"];
    [car49 setModel:@"Impreza 2.5 i"];
    
    CarModel *car50=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car50 setBrand:@"Suzki"];
    [car50 setYear:@"2004"];
    [car50 setModel:@"XL7"];
    
    CarModel *car51=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car51 setBrand:@"Tesla"];
    [car51 setYear:@"2016"];
    [car51 setModel:@"Model X P90D"];
    
    CarModel *car52=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car52 setBrand:@"Toyota"];
    [car52 setYear:@"2013"];
    [car52 setModel:@"Camry LE"];
    
    CarModel *car53=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car53 setBrand:@"Volkswagen"];
    [car53 setYear:@"2013"];
    [car53 setModel:@"Passat 2.5 SE"];
    
    CarModel *car54=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    [car54 setBrand:@"Volvo"];
    [car54 setYear:@"2004"];
    [car54 setModel:@"S40"];
    
    NSError *error;
    BOOL isSaveSuccess = [self.myDelegate.managedObjectContext save:&error];
    
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else {
        NSLog(@"Save successful!");
    }
    
}

@end
