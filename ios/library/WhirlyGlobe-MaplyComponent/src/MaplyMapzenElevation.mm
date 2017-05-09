//
//  MaplyMapzenElevation.mm
//  WhirlyGlobeMaplyComponent
//
//  Created by Steve Gifford on 5/3/17.
//  Copyright © 2017 mousebird consulting. All rights reserved.
//

#import "MaplyMapzenElevation.h"
#import "UIImage+Stuff.h"
#import "WhirlyGlobe.h"

using namespace WhirlyKit;

@interface MaplyRemoteTileElevationMapzenInfo : MaplyRemoteTileElevationInfo

- (nonnull instancetype)initWithURL:(NSString *__nonnull)baseURL minZoom:(int)minZoom maxZoom:(int)maxZoom;

@end

@implementation MaplyRemoteTileElevationMapzenInfo

- (nonnull instancetype)initWithURL:(NSString *__nonnull)baseURL minZoom:(int)minZoom maxZoom:(int)maxZoom
{
    self = [super initWithBaseURL:baseURL ext:@"" minZoom:minZoom maxZoom:maxZoom];
    
    return self;
}

- (NSURLRequest *)requestForTile:(MaplyTileID)tileID
{
    int y = ((int)(1<<tileID.level)-tileID.y)-1;
//    int y = tileID.y;
    NSMutableURLRequest *urlReq = nil;
    
    // x/y/z substitution
    NSString *fullURLStr = [[[self.baseURL stringByReplacingOccurrencesOfString:@"{z}" withString:[@(tileID.level) stringValue]]
                   stringByReplacingOccurrencesOfString:@"{x}" withString:[@(tileID.x) stringValue]]
                  stringByReplacingOccurrencesOfString:@"{y}" withString:[@(y) stringValue]];
    
    urlReq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullURLStr]];
    if (self.timeOut != 0.0)
        [urlReq setTimeoutInterval:self.timeOut];
    
    NSLog(@"Requesting elevation tile: %@",urlReq);
    
    return urlReq;
}

@end

@implementation MaplyRemoteTileElevationMapzenSource

- (id)initWithURL:(NSString *)url minZoom:(int)minZoom maxZoom:(int)maxZoom
{
    MaplyRemoteTileElevationMapzenInfo *info = [[MaplyRemoteTileElevationMapzenInfo alloc] initWithURL:url minZoom:minZoom maxZoom:maxZoom];
    
    return [super initWithInfo:info];
}

- (MaplyElevationChunk *)decodeElevationData:(NSData *)data
{
    // Tease out the elevation values from the raw PNG and turn it into shorts
    UIImage *pngImage = [UIImage imageWithData:data];
    unsigned int width,height;
    NSData *rawPngData = [pngImage rawDataRetWidth:&width height:&height];
    unsigned short *rawPngShorts = (unsigned short *)[rawPngData bytes];
    if (width != 260 || height != 260)
    {
        NSLog(@"Got Mapzen tile with wrong size.");
        return nil;
    }
    
    // Convert the data and save it
    unsigned int targetWidth = 257;
    
    float minElev = 1e10;
    float maxElev = -1e10;
    std::vector<float> elevs(targetWidth*targetWidth);
    std::vector<float> norms(3*targetWidth*targetWidth);
    for (unsigned int xx=0;xx<targetWidth;xx++)
        for (unsigned int yy=0;yy<targetWidth;yy++)
        {
            unsigned short srcVal = rawPngShorts[((yy+2)*width)+(xx+2)];
            uint32_t r = ((srcVal >> 0)  & 0xFF);
            uint32_t g = ((srcVal >> 8)  & 0xFF);
            uint32_t b = ((srcVal >> 16) & 0xFF);
            uint32_t a = ((srcVal >> 24) & 0xFF);
            float elev = (r * 256 + g + b / 256.0) - 32768.0;
            minElev = std::min(minElev,elev);
            maxElev = std::max(maxElev,elev);
            int idx = yy*targetWidth+xx;
            elevs[idx] = elev;
            Point3f norm(0.0,0.0,1.0);
            norms[3*idx+0] = norm.x();
            norms[3*idx+1] = norm.y();
            norms[3*idx+2] = norm.z();
        }
    
    MaplyElevationGridChunk *elevWrapper = [[MaplyElevationGridChunk alloc] initWithFixedGridSizeX:targetWidth sizeY:targetWidth elev:&elevs[0] norm:&norms[0]] ;
    
    NSLog(@"Loaded elevation set, minElev = %f, maxElev = %f",minElev,maxElev);
    
    return elevWrapper;
}

@end
