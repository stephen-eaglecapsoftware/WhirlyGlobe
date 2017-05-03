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
    GeographyClassTestCase *gctc = [[GeographyClassTestCase alloc] init];
    [gctc setUpWithGlobe:globeVC];
    
    [globeVC setTiltMinHeight:0.001 maxHeight:0.04 minTilt:1.40 maxTilt:0.0];
    globeVC.frameInterval = 2;  // 30fps
    
    globeVC.clearColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    
    MaplyRemoteTileElevationMazpenSource *mapzenElev =
    [[MaplyRemoteTileElevationMazpenSource alloc]
     initWithURL@"http://tile.dev.mapzen.com/mapzen/terrain/v1/256/terrarium/{z}/{x}/{y}.png?api_key=mapzen-mR9dA5q" minZoom:0 maxZoom:22];
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)  objectAtIndex:0];
    mapzenElev = [NSString stringWithFormat:@"%@/mapzenElev/",cacheDir]
    globeVC.elevDelegate = mapzenElev;
    
    // Don't forget to turn on the z buffer permanently
    [globeVC setHints:@{kMaplyRenderHintZBuffer: @(YES)}];
    
//    MaplyPagingElevationTestTileSource *tileSource  =[[MaplyPagingElevationTestTileSource alloc] initWithCoordSys:[[MaplySphericalMercator alloc]initWebStandard] minZoom:0 maxZoom:10 elevSource:cesiumElev];
//    MaplyQuadPagingLayer *layer = [[MaplyQuadPagingLayer alloc]initWithCoordSystem:tileSource.coordSys delegate:tileSource];
//    layer.importance  = 128*128;
//    layer.singleLevelLoading = false;
//    [globeVC addLayer:layer];
//    layer.drawPriority = 0;//BaseEarthPriority;
    
    //Animate slowly into position
    [globeVC animateToPosition:MaplyCoordinateMakeWithDegrees(-3.6704803, 40.5023056) time:5.0];
}

@end
