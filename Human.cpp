#include "Human.hpp"

Human::Human(void) : m_name("none"), m_age(0), m_job("none")
{
}

Human::Human(const Human &rhs)
{
	*this = rhs;
}

Human::~Human(void)
{
}

Human				&Human::operator=(const Human &rhs)
{
	this->m_name = rhs.m_name;
	this->m_age = rhs.m_age;
	this->m_job = rhs.m_job;
	return (*this);
}

	/********************************

			GETTER // SETTER

	********************************/

std::string			Human::getName(void) const
{
	return (m_name);
}

void				Human::setName(std::string const value)
{
	m_name = value;
}

std::string			Human::getJob(void) const
{
	return (m_job);
}
