//
//  MapzenElevationTestCase.m
//  AutoTester
//
//  Created by Steve Gifford on 5/3/17.
//  Copyright © 2017 mousebird consulting. All rights reserved.
//

#import "MapzenElevationTestCase.h"
#import "MaplyPagingElevationTestTileSource.h"
#import "MaplyRemoteTileElevationSource.h"
#import "MaplyCoordinateSystem.h"
#import "WhirlyGlobeComponent.h"
#import "GeographyClassTestCase.h"



@implementation MapzenElevationTestCase
{
    MaplyRemoteTileElevationMapzenSource *mapzenElev;
    MaplyElevationSourceTester *elevSource;
}


- (instancetype)init
{
    if (self = [super init]) {
        self.name = @"Mapzen Elevation";
        self.captureDelay = 5;
        self.implementations = MaplyTestCaseOptionGlobe;
    }
    
    return self;
}


- (void)setUpWithGlobe:(WhirlyGlobeViewController *)globeVC
{
    NSString * baseCacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * cartodbTilesCacheDir = [NSString stringWithFormat:@"%@/stamentiles/", baseCacheDir];
    int maxZoom = 15;
    MaplyRemoteTileSource *tileSource = [[MaplyRemoteTileSource alloc] initWithBaseURL:@"http://tile.stamen.com/watercolor/" ext:@"png" minZoom:0 maxZoom:maxZoom];
    tileSource.cacheDir = cartodbTilesCacheDir;
    MaplyQuadImageTilesLayer *layer = [[MaplyQuadImageTilesLayer alloc] initWithCoordSystem:tileSource.coordSys tileSource:tileSource];
    layer.handleEdges = true;
    layer.coverPoles = true;
    layer.requireElev = true;
    layer.drawPriority = 0;
    
    [globeVC setTiltMinHeight:0.001 maxHeight:0.04 minTilt:1.40 maxTilt:0.0];
    globeVC.frameInterval = 2;  // 30fps
    
    globeVC.clearColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    
    mapzenElev =
    [[MaplyRemoteTileElevationMapzenSource alloc]
     initWithURL:@"http://tile.dev.mapzen.com/mapzen/terrain/v1/260/terrarium/{z}/{x}/{y}.png?api_key=mapzen-mR9dA5q" minZoom:0 maxZoom:0];
//    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)  objectAtIndex:0];
//    mapzenElev.cacheDir = [NSString stringWithFormat:@"%@/mapzenElev260/",cacheDir];
    globeVC.elevDelegate = mapzenElev;

    // Sine wave elevation
//    elevSource = [[MaplyElevationSourceTester alloc] init];
//    globeVC.elevDelegate = elevSource;
    
    [globeVC addLayer:layer];

    // Don't forget to turn on the z buffer permanently
    [globeVC setHints:@{kMaplyRenderHintZBuffer: @(YES)}];
    
    //Animate slowly into position
//    [globeVC animateToPosition:MaplyCoordinateMakeWithDegrees(-3.6704803, 40.5023056) time:5.0];
}

@end
