/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.cpp                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tclaudel <tclaudel@student.le-101.fr>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/03/23 18:15:05 by tclaudel          #+#    #+#             */
/*   Updated: 2020/03/23 18:22:40 by tclaudel         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "Ninou.hpp"

int		main(void)
{
	Ninou	Tajana;

	Tajana.setName("Tajana");
	std::cout << Tajana.getName() << std::endl;
}