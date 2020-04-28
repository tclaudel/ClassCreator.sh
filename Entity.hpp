#ifndef ENTITY_HPP
# define ENTITY_HPP

class Entity
{
	public:
		Entity(void);
		Entity(const Entity &rhs);
		~Entity(void);
		Entity				&operator=(const Entity &rhs);

//		GETTER // SETTER

		int					getID(void) const;
		void				setID(int const value);
		std::string			getType(void) const;
		void				setType(std::string const value);
		Position			getPosition(void) const;
		void				setPosition(Position const value);
		Velocity			getPosition(void) const;
		void				setPosition(Velocity const value);

	private:
		int					m_ID;
		std::string			m_type;
		Position			m_position;
		Velocity			m_position;
};

#endif