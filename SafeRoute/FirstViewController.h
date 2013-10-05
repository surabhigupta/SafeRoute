//
//  FirstViewController.h
//  SafeRoute
//
//  Created by John Luttig on 10/5/13.
//  Copyright (c) 2013 LuttigDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface FirstViewController : UIViewController {
    //GMSMapView *mapView_;
}

@property (nonatomic, retain) GMSMapView *gMapView;
@property (nonatomic, retain) IBOutlet UITextField *locationField;
@property (nonatomic, retain) IBOutlet UITextField *destinationField;
@property (nonatomic, retain) IBOutlet UIButton *mapButton;

@end
