#include "Pony.hpp"

Pony::Pony()
{
}

Pony::Pony(const Pony &copy)
{
	*this = copy;
}

Pony::~Pony()
{
}

Pony			&Pony::operator=(const Pony &affected)
{
	*this = copy;
}

std::string		Pony::getName(void)
{
	return (m_name);
}

void			Pony::setName(std::string value)
{
	m_name = value;
}
