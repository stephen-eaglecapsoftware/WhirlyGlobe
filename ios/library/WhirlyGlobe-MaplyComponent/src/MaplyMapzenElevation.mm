//
//  MaplyMapzenElevation.mm
//  WhirlyGlobeMaplyComponent
//
//  Created by Steve Gifford on 5/3/17.
//  Copyright © 2017 mousebird consulting. All rights reserved.
//

#import "MaplyMapzenElevation.h"
#import "UIImage+Stuff.h"

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
    NSMutableData *rawData = [[NSMutableData alloc] initWithLength:sizeof(float)*targetWidth*targetWidth];
    float *rawDataFloat = (float *)[rawData bytes];
    
    for (unsigned int xx=0;xx<targetWidth;xx++)
        for (unsigned int yy=0;yy<targetWidth;yy++)
        {
            unsigned short srcVal = rawPngShorts[yy*width+xx];
            uint32_t r = ((srcVal >> 0)  & 0xFF);
            uint32_t g = ((srcVal >> 8)  & 0xFF);
            uint32_t b = ((srcVal >> 16) & 0xFF);
            float elev = (r * 256 + g + b / 256.0) - 32768.0;
            // Note: Debugging
            elev = 0.0;
            rawDataFloat[yy*targetWidth+xx] = elev;
        }
    
    MaplyElevationGridChunk *elevChunk = [[MaplyElevationGridChunk alloc] initWithGridData:rawData sizeX:targetWidth sizeY:targetWidth];
    
    NSLog(@"Decoding elevation set");
    
    return elevChunk;
}

@end
