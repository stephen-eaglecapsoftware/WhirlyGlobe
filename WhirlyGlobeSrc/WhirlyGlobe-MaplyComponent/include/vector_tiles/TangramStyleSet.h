//
//  TangramStyleSet.h
//  WhirlyGlobeMaplyComponent
//
//  Created by Steve Gifford on 11/9/16.
//  Copyright © 2016 mousebird consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapboxVectorTiles.h"

/** @brief Parses the Tangram style format and emits vector styles
    @details This class will parse the YAML for the Tangram style sheet format and
            then implement the style delegate support required to style Mapbox Vector tiles
            or any other tile based format, as well as just a file full of vectors.
  */
@interface TangramStyleSet : NSObject <MaplyVectorStyleDelegate>

/// @brief Initialize with a map or globe view controller
- (id)initWithViewC:(MaplyBaseViewController *)viewC;

/// @brief Parse the YAML and return false on failure
- (bool)loadYAML:(NSData *)yamlData;

@end
