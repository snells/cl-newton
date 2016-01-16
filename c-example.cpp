#include <stdio.h>
#include <stdlib.h>
#include <Newton.h>

void	applyForceAndTorque (const NewtonBody* const body, dFloat timestep, int threadIndex)
{
	float	gravity		=	-9.8f;
	float	mass, ix, iy, iz;
	NewtonBodyGetMassMatrix(body, &mass, &ix, &iy, &iz);
	
	float	force[4]	=	{ 0.0f, gravity * mass, 0.0f, 1.0f };
	NewtonBodySetForce(body, force);
}

int main (int argc, const char * argv[])
{
	float				const	initialTM[16]	=	{ 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f };
	
	NewtonWorld*		const	world		=	NewtonCreate();
	NewtonCollision*	const	collision	=	NewtonCreateBox(world, 10, 10, 10, 0, NULL);
	NewtonBody*			const	body		=	NewtonCreateDynamicBody(world, collision, initialTM);
	NewtonBodySetForceAndTorqueCallback(body, applyForceAndTorque);
	NewtonBodySetMassMatrix(body, 10, 1, 1, 1);
	
	for	(int i=0; i<100; i++)
	{
		NewtonUpdate(world, 1/60);
		float	newTM[16];
		NewtonBodyGetMatrix(body, newTM);
		printf("iteration = %d, position = %f, %f, %f\n", i, newTM[12], newTM[13], newTM[14]);
	}
	
	NewtonDestroyAllBodies(world);
	NewtonDestroy(world);

	printf("Hello, World!\n");
	return 0;
}
