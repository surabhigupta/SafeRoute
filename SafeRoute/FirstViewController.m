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
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    
    gMapView = [GMSMapView mapWithFrame:CGRectMake(0, 130, self.view.frame.size.width, self.view.frame.size.height-150) camera:camera];
    [self.view addSubview:gMapView];
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    gMapView.myLocationEnabled = YES;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = gMapView;
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
