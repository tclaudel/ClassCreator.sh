#ifndef PONY_HPP
# define PONY_HPP
# include <string>
# include <iostream>

class Pony
{
	public:
		Pony(void);
		~Pony(void);
		std::string			getName(void);
		void				setName(std::string value);

	private:
		std::string			m_name;
};

#endif