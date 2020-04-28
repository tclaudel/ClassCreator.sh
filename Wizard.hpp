#ifndef WIZARD_HPP
# define WIZARD_HPP

class Wizard
{
	public:
		Wizard(void);
		Wizard(const Wizard &rhs);
		~Wizard(void);
		Wizard				&operator=(const Wizard &rhs);

//		GETTER // SETTER

		Data				getData(void) const;
		void				setData(Data const value);

	private:
		Data				m_data;
};

#endif