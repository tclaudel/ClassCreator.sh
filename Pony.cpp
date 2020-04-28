#include "Pony.hpp"

Pony::Pony(void)
{
}

Pony::Pony(const Pony &rhs)
{
	*this = rhs;
}

Pony::~Pony(void)
{
}

Pony				&Pony::operator=(const Pony &rhs)
{
	(void)rhs;
	return (*this);
}

	/********************************

			GETTER // SETTER

	********************************/
