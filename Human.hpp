#ifndef Human_hpp
# define Human_hpp
# include <string>
# include <iostream>
# include "Ihuman.hpp"

class Human
{
	public:
		Human(void);
		Human(const Human &rhs);
		~Human(void);
		Human				&operator=(const Human &rhs);

//		GETTER // SETTER

		std::string			getName(void) const;
		void				setName(std::string const value);
		std::string			getJob(void) const;

	private:
		std::string			m_name;
		int					m_age;
		std::string			m_job;
};

#endif