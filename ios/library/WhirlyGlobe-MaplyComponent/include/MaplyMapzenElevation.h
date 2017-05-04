//
//  MaplyMapzenElevation.h
//  WhirlyGlobeMaplyComponent
//
//  Created by Steve Gifford on 5/3/17.
//  Copyright © 2017 mousebird consulting. All rights reserved.
//

#import "MaplyTileSource.h"
#import "MaplyCoordinateSystem.h"
#import "MaplyElevationSource.h"
#import "MaplyRemoteTileElevationSource.h"

/** This elevation source handles Mapzen elevation tiles.
  */
@interface MaplyRemoteTileElevationMapzenSource : MaplyRemoteTileElevationSource

/** Initialize with a URL contain {x}, {y}, and {z}.
  */
- (id)initWithURL:(NSString *)url minZoom:(int)minZoom maxZoom:(int)maxZoom;

@end
