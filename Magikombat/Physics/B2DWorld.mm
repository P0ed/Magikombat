#import "B2DWorld.h"
#include <Box2D/Box2D.h>


@implementation B2DWorld {
	std::shared_ptr<b2World> world_;
}

- (instancetype)init {
	self = [super init];
	if (!self) return nil;

	return self;
}

@end
