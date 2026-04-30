//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<bidmad_plugin/bidmad_plugin.h>)
#import <bidmad_plugin/bidmad_plugin.h>
#else
@import bidmad_plugin;
#endif

#if __has_include(<bidmad_plugin_newscash/bidmad_plugin_newscash.h>)
#import <bidmad_plugin_newscash/bidmad_plugin_newscash.h>
#else
@import bidmad_plugin_newscash;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [bidmad_plugin registerWithRegistrar:[registry registrarForPlugin:@"bidmad_plugin"]];
  [bidmad_plugin_newscash registerWithRegistrar:[registry registrarForPlugin:@"bidmad_plugin_newscash"]];
}

@end
