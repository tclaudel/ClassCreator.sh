#include "Wizard.hpp"

Wizard::Wizard(void) : m_data(0)
{
}

Wizard::Wizard(const Wizard &rhs)
{
	*this = rhs;
}

Wizard::~Wizard(void)
{
}

Wizard				&Wizard::operator=(const Wizard &rhs)
{
	this->m_data = rhs.m_data;
	return (*this);
}

	/********************************

			GETTER // SETTER

	********************************/

Data				Wizard::getData(void) const
{
	return (m_data);
}

void				Wizard::setData(Data const value)
{
	m_data = value;
}
