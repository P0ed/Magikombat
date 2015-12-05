#include <Foundation/Foundation.h>
#include "B2DStructs.h"

typedef void *WorldRef;
typedef void *BodyRef;

FOUNDATION_EXTERN WorldRef B2DCreateWorld();
FOUNDATION_EXTERN void B2DReleaseWorld(WorldRef world);

FOUNDATION_EXTERN void B2DStep(WorldRef world);

FOUNDATION_EXTERN BodyRef B2DCreateStaticBody(WorldRef world, B2DVector position, B2DVector size);
FOUNDATION_EXTERN BodyRef B2DCreateDynamicBody(WorldRef world, B2DVector position, B2DVector size);

FOUNDATION_EXTERN B2DVector B2DBodyPosition(BodyRef body);
