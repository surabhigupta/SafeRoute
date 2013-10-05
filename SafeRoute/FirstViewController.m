//
//  FirstViewController.m
//  SafeRoute
//
//  Created by John Luttig on 10/5/13.
//  Copyright (c) 2013 LuttigDev. All rights reserved.
//

#import "FirstViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#define ACCESS_KEY_ID          @"CHANGE ME"
#define SECRET_KEY             @"CHANGE ME"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize gMapView, locationField, destinationField, mapButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:37.36
                                                            longitude: -122.0
                                                                 zoom:10];
    
    gMapView = [GMSMapView mapWithFrame:CGRectMake(0, 130, self.view.frame.size.width, self.view.frame.size.height-150) camera:camera];
    [self.view addSubview:gMapView];
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    gMapView.myLocationEnabled = YES;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(37.36, -122.0);
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
    CLGeocoder *geocoder1 = [[CLGeocoder alloc] init];
    CLGeocoder *geocoder2 = [[CLGeocoder alloc] init];
    NSString *locationName = [locationField text];
    NSString *destinationName = [destinationField text];
    NSLog(@"locName: %@", locationName);
    NSLog(@"destName: %@", destinationName);
    //__block NSArray *locationMarks = [[NSArray alloc] init];
    //__block NSArray *destinationMarks = [[NSArray alloc] init];
    __block CLPlacemark *placemarkA;
    __block CLPlacemark *placemarkB;
    
    [geocoder1 geocodeAddressString:locationName completionHandler:^(NSArray *placemarks, NSError *error) {
        placemarkA = [placemarks objectAtIndex:0];
    }];
    [geocoder2 geocodeAddressString:destinationName completionHandler:^(NSArray *placemarks, NSError *error) {
        placemarkB = [placemarks objectAtIndex:0];
    }];
    CLLocationCoordinate2D locA = placemarkA.location.coordinate;
    CLLocationCoordinate2D locB = placemarkB.location.coordinate;
    
    
//    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil] : nil;
//    NSMutableArray *ad = [results objectForKey:@"routes"];
//    NSMutableArray *legs = [[ad objectAtIndex:0] objectForKey:@"legs"];
//    NSMutableArray *steps = [[legs objectAtIndex:0] objectForKey:@"steps"];
//    //    NSLog(@"Data3 %@", data3);
//    for(int i = 0; i<steps.count;i++){
//        NSLog(@"Start %@", [[steps objectAtIndex:i] objectForKey:@"start_location"]);
//        NSLog(@"End %@", [[steps objectAtIndex:i] objectForKey:@"end_location"]);
//    }
    GMSMutablePath *path = [[GMSMutablePath alloc] init];
    [path addCoordinate:CLLocationCoordinate2DMake(37.36, -122.1)];
    [path addCoordinate:CLLocationCoordinate2DMake(37.40, -122.12)];
    [path addCoordinate:CLLocationCoordinate2DMake(37.45, -122.13)];
    [path addCoordinate:CLLocationCoordinate2DMake(37.47, -122.145)];
    [path addCoordinate:CLLocationCoordinate2DMake(37.48, -122.15)];
    
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    
    polyline.map = gMapView;

}

-(void) addPolyLineFromString:(NSString*)string
{
    const char *bytes = [string UTF8String];
    NSUInteger length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSUInteger idx = 0;
    
    //NSUInteger count = length / 4;
    //CLLocationCoordinate2D *coords = calloc(count, sizeof(CLLocationCoordinate2D));
    GMSMutablePath *path = [[GMSMutablePath alloc] init];
    //NSUInteger coordIdx = 0;
    
    float latitude = 0;
    float longitude = 0;
    while (idx < length) {
        char byte = 0;
        int res = 0;
        char shift = 0;
        
        do {
            byte = bytes[idx++] - 63;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLat = ((res & 1) ? ~(res >> 1) : (res >> 1));
        latitude += deltaLat;
        
        shift = 0;
        res = 0;
        
        do {
            byte = bytes[idx++] - 0x3F;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLon = ((res & 1) ? ~(res >> 1) : (res >> 1));
        longitude += deltaLon;
        
        float finalLat = latitude * 1E-5;
        float finalLon = longitude * 1E-5;
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(finalLat, finalLon);
        //coords[coordIdx++] = coord;
        [path addCoordinate:coord];
        
//        if (coordIdx == count) {
//            NSUInteger newCount = count + 10;
//            coords = realloc(coords, newCount * sizeof(CLLocationCoordinate2D));
//            count = newCount;
//        }
    }
    //Polyline *polyline = [MKPolyline polylineWithCoordinates:coords count:coordIdx]; free(coords);
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.map = gMapView;
}

@end
