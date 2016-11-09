//
//  TangramStyleSet.m
//  WhirlyGlobeMaplyComponent
//
//  Created by Steve Gifford on 11/9/16.
//  Copyright © 2016 mousebird consulting. All rights reserved.
//

#import "TangramStyleSet.h"
#import "yaml.h"

@implementation TangramStyleSet
{
    MaplyBaseViewController * __weak viewC;
}

- (id)initWithViewC:(MaplyBaseViewController *)inViewC
{
    self = [super init];
    viewC = inViewC;
    
    return self;
}

- (bool)loadYAML:(NSData *)yamlData
{
    NSString *yamlStr = [[NSString alloc] initWithData:yamlData encoding:NSUTF8StringEncoding];
    
    YAML::Node config = YAML::Load([yamlStr cStringUsingEncoding:NSUTF8StringEncoding]);

    if (!config.IsMap())
    {
        NSLog(@"Expecting Map at top level in Tangram YAML.");
        return false;
    }

    // Work through the children
    for (YAML::const_iterator it=config.begin();it != config.end();++it)
    {
        std::string name = it->first.as<std::string>();
        YAML::Node node = it->second;
        
        switch (node.Type())
        {
            case YAML::NodeType::Scalar:
                NSLog(@"%s: %s",name.c_str(),node.as<std::string>().c_str());
                break;
            case YAML::NodeType::Sequence:
                NSLog(@"%s: Sequence",name.c_str());
                break;
            case YAML::NodeType::Map:
                NSLog(@"%s: Map",name.c_str());
                if (name == "styles")
                    [self parseStyles:it->second indent:" "];
                if (name == "layers")
                    [self parseLayers:it->second indent:" "];
                break;
        }
    }
    
    return true;
}

- (bool)parseStyles:(YAML::Node)node indent:(const std::string &)indent
{
    for (YAML::const_iterator it=node.begin();it != node.end();++it)
    {
        std::string name;
        YAML::Node node;
        
        if (it->first.IsScalar())
        {
            name = it->first.as<std::string>();
            node = it->second;
        } else {
            NSLog(@"%s non-scalar type for first",indent.c_str());
            return false;
        }

        switch (node.Type())
        {
            case YAML::NodeType::Scalar:
                NSLog(@"%s%s: %s",indent.c_str(),name.c_str(),node.as<std::string>().c_str());
                break;
            case YAML::NodeType::Sequence:
                NSLog(@"%s%s: Sequence",indent.c_str(),name.c_str());
                break;
            case YAML::NodeType::Map:
                if (name == "shaders")
                    continue;
                NSLog(@"%s%s: Map",indent.c_str(),name.c_str());
                [self parseStyles:it->second indent:indent + " "];
                break;
        }
    }
    
    return true;
}

- (bool)parseLayers:(YAML::Node)node indent:(const std::string &)indent
{
    for (YAML::const_iterator it=node.begin();it != node.end();++it)
    {
        std::string name;
        YAML::Node node;
        
        if (it->first.IsScalar())
        {
            name = it->first.as<std::string>();
            node = it->second;
        } else {
            NSLog(@"%s non-scalar type for first",indent.c_str());
            return false;
        }
        
        switch (node.Type())
        {
            case YAML::NodeType::Scalar:
                NSLog(@"%s%s: %s",indent.c_str(),name.c_str(),node.as<std::string>().c_str());
                break;
            case YAML::NodeType::Sequence:
                NSLog(@"%s%s: Sequence",indent.c_str(),name.c_str());
                break;
            case YAML::NodeType::Map:
                NSLog(@"%s%s: Map",indent.c_str(),name.c_str());
                [self parseLayers:it->second indent:indent + " "];
                break;
        }
    }
    
    return true;
}

- (nullable NSArray *)stylesForFeatureWithAttributes:(NSDictionary *__nonnull)attributes
                                              onTile:(MaplyTileID)tileID
                                             inLayer:(NSString *__nonnull)layer
                                               viewC:(MaplyBaseViewController *__nonnull)viewC
{
    return nil;
}

- (BOOL)layerShouldDisplay:(NSString *__nonnull)layer tile:(MaplyTileID)tileID
{
    return true;
}

- (nullable NSObject<MaplyVectorStyle> *)styleForUUID:(NSString *__nonnull)uiid viewC:(MaplyBaseViewController *__nonnull)viewC
{
    return nil;
}

@end
