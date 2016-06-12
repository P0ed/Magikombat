#include "B2DWorld.h"
#include "B2DBody.h"
#include <Box2D/Box2D.h>

static inline b2World *asWorld(WorldRef ref) { return (b2World *)ref; }
static inline b2Body *asBody(BodyRef ref) { return (b2Body *)ref; }
static inline b2Vec2 asVec2(B2DVector vector) { return b2Vec2(vector.dx, vector.dy); }
static inline B2DVector asVector(b2Vec2 vector) { return {.dx = vector.x, .dy = vector.y}; }

WorldRef B2DCreateWorld() {
	b2World *world = new b2World(b2Vec2(0, -1));
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
	bodyDef.position.Set(position.dx + size.dx / 2, position.dy + size.dy / 2);

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
	bodyDef.linearDamping = 0.8;

	b2Body *body = asWorld(world)->CreateBody(&bodyDef);
	b2PolygonShape shape;
	shape.SetAsBox(size.dx / 2, size.dy / 2);
	b2Fixture *fixture = body->CreateFixture(&shape, 1);
	fixture->SetFriction(0);

	return body;
}

B2DVector B2DBodyPosition(BodyRef body) {
	return asVector(asBody(body)->GetPosition());
}

B2DVector B2DBodyVelocity(BodyRef body) {
	return asVector(asBody(body)->GetLinearVelocity());
}

float B2DBodyMass(BodyRef body) {
	return asBody(body)->GetMass();
}

void B2DBodyApplyImpulse(BodyRef body, B2DVector impulse) {
	auto b2_body = asBody(body);
	b2_body->ApplyLinearImpulse(asVec2(impulse), b2_body->GetWorldCenter(), true);
}
