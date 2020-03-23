#include "Pony.hpp"

Pony::Pony()
{
}

Pony::~Pony()
{
}

std::string			Pony::getName(void)
{
	return (m_name);
}

void			Pony::setName(std::string value)
{
	m_name = value;
}
