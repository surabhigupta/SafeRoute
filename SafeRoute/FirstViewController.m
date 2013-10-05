//
//  FirstViewController.m
//  SafeRoute
//
//  Created by John Luttig on 10/5/13.
//  Copyright (c) 2013 LuttigDev. All rights reserved.
//

#import "FirstViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize gMapView, locationField, destinationField, mapButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:28.654601
                                                            longitude:77.234389
                                                                 zoom:10];
    
    gMapView = [GMSMapView mapWithFrame:CGRectMake(0, 130, self.view.frame.size.width, self.view.frame.size.height-150) camera:camera];
    [self.view addSubview:gMapView];
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    gMapView.myLocationEnabled = YES;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(28.654601,77.234389);
    marker.title = @"Chandni Chowk Area";
    marker.snippet = @"India";
    marker.map = gMapView;
    UIColor *THREAT_LEVEL1_COLOR = [UIColor colorWithRed:(253/255.0f) green:(65/255.0f) blue:(1/255.0f) alpha:0.7];
    UIColor *THREAT_LEVEL2_COLOR = [UIColor colorWithRed:(230/255.0f) green:(98/255.0f) blue:(11/255.0f) alpha:0.5];

    [self createCircleWithColor:THREAT_LEVEL1_COLOR withRadius:750 atPosition:CLLocationCoordinate2DMake(28.654601,77.234389)];
    [self createCircleWithColor:THREAT_LEVEL2_COLOR withRadius:500 atPosition:CLLocationCoordinate2DMake(28.554601,77.234389)];
}

-(void)createCircleWithColor:(UIColor*)color withRadius:(float) radius atPosition: (CLLocationCoordinate2D) position {
    GMSCircle *circle = [[GMSCircle alloc] init];
    [circle setMap: gMapView];
    [circle setPosition: position];
    [circle setFillColor: color];
    [circle setRadius: radius];
    [circle setZIndex: 10];
    [circle setStrokeWidth: 1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)map:(id)sender
{
    
}

@end
