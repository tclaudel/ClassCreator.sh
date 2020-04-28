#include "Entity.hpp"

Entity::Entity(void) : m_ID(0), m_type("none"), m_position(0), m_position(0)
{
}

Entity::Entity(const Entity &rhs)
{
	*this = rhs;
}

Entity::~Entity(void)
{
}

Entity				&Entity::operator=(const Entity &rhs)
{
	this->m_ID = rhs.m_ID;
	this->m_type = rhs.m_type;
	this->m_position = rhs.m_position;
	this->m_position = rhs.m_position;
	return (*this);
}

	/********************************

			GETTER // SETTER

	********************************/

int					Entity::getID(void) const
{
	return (m_ID);
}

void				Entity::setID(int const value)
{
	m_ID = value;
}

std::string			Entity::getType(void) const
{
	return (m_type);
}

void				Entity::setType(std::string const value)
{
	m_type = value;
}

Position			Entity::getPosition(void) const
{
	return (m_position);
}

void				Entity::setPosition(Position const value)
{
	m_position = value;
}

Velocity			Entity::getPosition(void) const
{
	return (m_position);
}

void				Entity::setPosition(Velocity const value)
{
	m_position = value;
}
