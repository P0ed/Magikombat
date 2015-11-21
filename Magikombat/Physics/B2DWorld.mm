#import "B2DWorld.h"
#include <Box2D/Box2D.h>


@implementation B2DWorld {
	b2World *world_;
}

- (instancetype)init {
	self = [super init];
	if (!self) return nil;

	world_ = new b2World(b2Vec2(0, -10));

	return self;
}

- (void)dealloc {
	delete world_;
}

@end
