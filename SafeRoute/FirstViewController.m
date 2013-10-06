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
                                                                 zoom:14];
    //GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:37.4
    //                                                      //  longitude:-122.15
                          //                                       zoom:11];
    
    gMapView = [GMSMapView mapWithFrame:CGRectMake(0, 130, self.view.frame.size.width, self.view.frame.size.height-150) camera:camera];
    [self.view addSubview:gMapView];
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate at zoom level 10
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(28.657821,77.230141);
    marker.title = @"Chandni Chowk Area";
    marker.snippet = @"India";
    marker.map = gMapView;
    UIColor *THREAT_LEVEL1_COLOR = [UIColor colorWithRed:(253/255.0f) green:(65/255.0f) blue:(1/255.0f) alpha:0.7];
    UIColor *THREAT_LEVEL2_COLOR = [UIColor colorWithRed:(230/255.0f) green:(98/255.0f) blue:(11/255.0f) alpha:0.5];

<<<<<<< HEAD
<<<<<<< HEAD
    [self createCircleWithColor:THREAT_LEVEL1_COLOR withRadius:500.00 atPosition:CLLocationCoordinate2DMake(28.654601,77.234389)];
=======
=======
>>>>>>> 7f06051390aa1a71afc5b40d394895ce9eb0f5f4
    [gMapView addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    gMapView.myLocationEnabled = YES;
    gMapView.settings.myLocationButton = YES;
    
    [self createCircleWithColor:THREAT_LEVEL1_COLOR withRadius:750.00 atPosition:CLLocationCoordinate2DMake(28.654601,77.234389)];
>>>>>>> 7f06051390aa1a71afc5b40d394895ce9eb0f5f4
    [self createCircleWithColor:THREAT_LEVEL2_COLOR withRadius:500.00 atPosition:CLLocationCoordinate2DMake(28.554601,77.234389)];
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"myLocation"] && [object isKindOfClass:[GMSMapView class]])
    {
        [self.gMapView animateToCameraPosition:[GMSCameraPosition cameraWithLatitude:self.gMapView.myLocation.coordinate.latitude
                                                                                 longitude:self.gMapView.myLocation.coordinate.longitude
                                                                                      zoom:10]];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // Implement here if the view has registered KVO
    [self.gMapView removeObserver:self forKeyPath:@"myLocation"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)map:(id)sender
{
    [self.view endEditing:YES];
    for (GMSPolyline *pline in [gMapView polylines]) {
        pline.map = nil;
    }
    NSString *locationName = [locationField text];
    NSString *destinationName = [destinationField text];
    NSLog(@"locName: %@", locationName);
    NSLog(@"destName: %@", destinationName);
    
    NSString *url = [NSString stringWithFormat:@"http://10.34.172.50:8080/SafeRouteWeb/SafeServletAPI?origin=%@&destination=%@&mode=walking", [locationName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [destinationName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", url);
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil] : nil;
    NSMutableArray *legs = [results objectForKey:@"legs"];
    NSMutableArray *steps = [[legs objectAtIndex:0] objectForKey:@"steps"];
    for(int i = 0; i<steps.count;i++){
        [self addPolyLineFromString:[[[steps objectAtIndex:i] objectForKey:@"polyline"] objectForKey:@"points"] andColor:[UIColor blueColor]];
        //NSLog(@"Start %@", [[steps objectAtIndex:i] objectForKey:@"start_location"]);
        //NSLog(@"End %@"  , [[steps objectAtIndex:i] objectForKey:@"end_location"  ]);
    }
    
    //////////
    NSString *url2 = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&mode=walking&sensor=false", [locationName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [destinationName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", url2);
    NSData *jsonData2 = [[NSString stringWithContentsOfURL:[NSURL URLWithString:url2] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *data = jsonData2 ? [NSJSONSerialization JSONObjectWithData:jsonData2 options:0 error:nil] : nil;
    NSLog(@"data: %@", data);
    //NSLog(@"results: %@", results);
    //NSMutableDictionary *data1 = [data objectFromJSONData];
    NSMutableArray *ad = [data objectForKey:@"routes"];
    NSMutableArray *data2 = [[ad objectAtIndex:0] objectForKey:@"legs"];
    NSMutableArray *steps2 = [[data2 objectAtIndex:0] objectForKey:@"steps"];
    //NSLog(@"steps: %@", steps);
    for(int i = 0; i<steps2.count;i++){
        [self addPolyLineFromString:[[[steps2 objectAtIndex:i] objectForKey:@"polyline"] objectForKey:@"points"] andColor:[UIColor redColor]];
    }
}

-(void) addPolyLineFromString:(NSString*)string andColor: (UIColor*) color
{
    //NSLog(@"adding polyline: %@", string);
    const char *bytes = [string UTF8String];
    NSUInteger length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSUInteger idx = 0;
    GMSMutablePath *path = [[GMSMutablePath alloc] init];
    
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
    }
    //polyline.map = nil;
    polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = color;
    [polyline setStrokeWidth:5.0];
    polyline.map = gMapView;
}

@end
