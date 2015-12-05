#include "B2DWorld.h"
#include "B2DBody.h"
#include <Box2D/Box2D.h>

static inline b2World *asWorld(WorldRef ref) { return (b2World *)ref; }
static inline b2Body *asBody(BodyRef ref) { return (b2Body *)ref; }

WorldRef B2DCreateWorld() {
	b2World *world = new b2World(b2Vec2(0, -10));
	return world;
}

void B2DReleaseWorld(WorldRef world) {
	delete asWorld(world);
}

void B2DStep(WorldRef world) {
	asWorld(world)->Step(1.0 / 60.0, 1, 1);
}

BodyRef B2DCreateStaticBody(WorldRef world, B2DVector position, B2DVector size) {
	b2BodyDef bodyDef = b2BodyDef();
	bodyDef.type = b2_staticBody;
	bodyDef.position.Set(position.dx, position.dy);

	b2Body *body = asWorld(world)->CreateBody(&bodyDef);
	b2PolygonShape shape;
	shape.SetAsBox(size.dx / 2, size.dy / 2);
	body->CreateFixture(&shape, 0);

	return body;
}

BodyRef B2DCreateDynamicBody(WorldRef world, B2DVector position, B2DVector size) {
	b2BodyDef bodyDef = b2BodyDef();
	bodyDef.type = b2_dynamicBody;
	bodyDef.fixedRotation = true;
	bodyDef.position.Set(position.dx, position.dy);

	b2Body *body = asWorld(world)->CreateBody(&bodyDef);
	b2PolygonShape shape;
	shape.SetAsBox(size.dx / 2, size.dy / 2);
	body->CreateFixture(&shape, 0);

	return body;
}

B2DVector B2DBodyPosition(BodyRef body) {
	auto b2_position = asBody(body)->GetPosition();
	return {.dx = b2_position.x, .dy = b2_position.y};
}
