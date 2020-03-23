#ifndef NINOU_HPP
# define NINOU_HPP
# include <string>
# include <iostream>

class Ninou
{
	public:
		Ninou(void);
		~Ninou(void);
		std::string			getName(void);
		void				setName(std::string value);

	private:
		std::string			m_name;
};

#endif