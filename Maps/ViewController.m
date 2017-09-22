//
//  ViewController.m
//  Maps
//
//  Created by Kevin on 7/19/16.
//  Copyright © 2016 Kevin Skompinski. All rights reserved.
//


#import "MapKit/MapKit.h"
#import "ViewController.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) MKPointAnnotation *aAnno;
@property (strong, nonatomic) MKPointAnnotation *bAnno;
@property (strong, nonatomic) MKPointAnnotation *cAnno;
@property (strong, nonatomic) MKPointAnnotation *currentAnno;
@property (weak, nonatomic) IBOutlet UISwitch *switchField;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL mapIsMoving;

@end

@implementation ViewController

- (void)viewDidLoad {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.mapIsMoving = NO;
    [super viewDidLoad];
    [self addAnnotations];
}
- (IBAction)switchChanged:(id)sender {
    if(self.switchField.isOn){
        self.mapView.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
    }
    else{
        self.mapView.showsUserLocation = NO;
        [self.locationManager stopUpdatingLocation];
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    self.currentAnno.coordinate = locations.lastObject.coordinate;
    if (self.mapIsMoving == NO){
        [self centerMap:self.currentAnno];
    }
    
}

- (IBAction)ButtonATapped:(id)sender {
    [self centerMap:self.aAnno];
}

- (IBAction)ButtonBTapped:(id)sender {
    [self centerMap:self.bAnno];
}

- (IBAction)ButtonCTapped:(id)sender {
    [self centerMap:self.cAnno];
}

- (void)centerMap:(MKPointAnnotation *)centerPoint{
    [self.mapView setCenterCoordinate:centerPoint.coordinate animated:YES];
}

- (void)addAnnotations{
    self.aAnno = [[MKPointAnnotation alloc] init];
    self.aAnno.coordinate = CLLocationCoordinate2DMake(40.7128, -74.0059);
    self.aAnno.title = @"New York City";
    
    self.bAnno = [[MKPointAnnotation alloc] init];
    self.bAnno.coordinate = CLLocationCoordinate2DMake(38.9072, -77.0369);
    self.bAnno.title = @"Washington DC";
    
    self.cAnno = [[MKPointAnnotation alloc] init];
    self.cAnno.coordinate = CLLocationCoordinate2DMake(39.7392, -104.9903);
    self.cAnno.title = @"Denver";
    
    self.currentAnno = [[MKPointAnnotation alloc] init];
    self.currentAnno.coordinate = CLLocationCoordinate2DMake(0.0, 0.0);
    self.currentAnno.title = @"My Location";
    
    [self.mapView addAnnotations:@[self.aAnno, self.bAnno, self.cAnno]];
}

- (void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    self.mapIsMoving = YES;
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    self.mapIsMoving = NO;
}

@end
