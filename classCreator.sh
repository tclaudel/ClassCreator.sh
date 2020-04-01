#!/bin/bash

function create_setter {
	printf "\nvoid\t\t\t\t%s::set%s(%s const value)\n" $4 $3 $1 >&4
	printf "\t\tvoid\t\t\t\tset%s(%s const value);\n" $3 $1 >&3
	printf "{\n\tm_%s = value;\n}\n" $2 >&4
}

function print_tabs {
	lentype=${#1}
	if [ $lentype -lt 4 ]; then
		printf "\t\t\t\t\t" $2
	elif [ $lentype -lt 8 ]; then
		printf "\t\t\t\t" $2
	else
		printf "\t\t\t" $2
	fi
}

function create_getter {
	printf "\t\t%s" "$1" >&3
	printf "\n%s" "$1" >&4
	print_tabs $1 >&3
	print_tabs $1 >&4
	printf "%s::get%s(void) const\n" $4 "$3" >&4
	printf "get%s(void) const;\n"  "$3" >&3
	printf "{\n\treturn (m_%s);\n}\n" "$2" >&4
}

if [ -z "$1" ] ; then
	printf "Class creator :\n";
	printf "\tWhat's your class name ? : "
	read classname;
else
	classname=$1;
fi
rm $classname.hpp $classname.cpp;
touch $classname.hpp $classname.cpp;
printf "\n\t$classname.hpp created !\n";
printf "\t$classname.cpp created !\n";
fd="$classname.hpp";
fd1="$classname.cpp";
exec 4<>$fd1;
exec 3<>$fd;
printf "#ifndef " >&3;
printf "$classname"_hpp | tr [a-z] [A-Z] >&3;
printf "\n# define " >&3;
printf "$classname"_hpp | tr [a-z] [A-Z] >&3;
printf "\n" >&3;
printf "\n\nplease list which SYSTEM HEADER you would like to include [q to exit] ?\n";
while read -p "header : " REPLY;
do
    if [ -z "$REPLY" ] || [ $REPLY = q ]
    then
        break;
    else
        printf "# include <$REPLY>\n" >&3
    fi
done
printf "\nplease list which USER HEADER you would like to include [q to exit] ?\n";
while read -p "header : " REPLY;
do
    if [ -z "$REPLY" ] || [ $REPLY = q ]
    then
        break;
    else
        printf "# include \"$REPLY\"\n" >&3
    fi
done

printf "\nclass $classname" >&3
if [ ! -z $2 ]; then
	printf " : public %s" $2 >&3
fi
printf "\n{\n\tpublic:\n" >&3;
printf ""
printf "\t\t$classname(void);\n" >&3
printf "\t\t%s(const %s &rhs);\n" $classname $classname >&3
printf "\t\t~$classname(void);\n" >&3
printf "\t\t%s" $classname >&3
print_tabs $classname >&3
printf "&operator=(const %s &rhs);\n"  $classname >&3
printf "\nplease list your var [q to exit] add \"sg\" as third entry to set getter and setter?\n";
declare -a TYPETAB
declare -a TYPEVAR
declare -a SGTAB
while read -p "var : " TYPE VAR SG;
do
	if [ -z "$TYPE" ] || [ $TYPE = q ]
	then
		break
	else
		if [ $TYPE = "string" ]
			then
				TYPE="std::string";
		fi
	fi
	TYPETAB+=("$TYPE");
	VARTAB+=("$VAR");
	if [ -z $SG ]; then
		SGTAB+=("a");
	else
		SGTAB+=("$SG");
	fi
done
total=${#TYPETAB[*]};
printf "#include \""$classname".hpp\"\n\n" >&4;
printf "$classname::$classname(void) : " >&4;
for (( i=0; i<=$(( $total -1 )); i++ ))
do
	if [ $i != 0 ] ; then
		printf ", " >&4;
	fi
	if [ ${TYPETAB[$i]} == std::string ] ; then 
		printf "m_%s(\"none\")" ${VARTAB[$i]} >&4;
	else
		printf "m_%s(0)" ${VARTAB[$i]} >&4;
	fi
done
printf "\n{\n}\n\n" >&4;
printf "$classname::$classname(const $classname &rhs)\n{\n\t*this = rhs;\n}\n\n" >&4;
printf "$classname::~$classname(void)\n{\n}\n\n" >&4;
printf "$classname" >&4;
lentype=${#classname}
print_tabs $classname >&4
printf "&$classname::operator=(const $classname &rhs)\n{\n" >&4;
for (( i=0; i<=$(( $total -1 )); i++ ))
do 
	printf "\tthis->m_${VARTAB[$i]} = rhs.m_${VARTAB[$i]};\n" >&4;
done
printf "\treturn (*this);\n}\n" >&4;
printf "\n\t/********************************\n\n\t\t\tGETTER // SETTER\n\n\t********************************/\n" >&4;
printf "\n//\t\tGETTER // SETTER\n\n" >&3
for (( i=0; i<=$(( $total -1 )); i++ ))
do 
	if [[ ${SGTAB[$i]} == *g* ]]; then
		create_getter ${TYPETAB[$i]} ${VARTAB[$i]} ${VARTAB[$i]^} $classname
	fi
	if [[ ${SGTAB[$i]} == *s* ]]; then
		create_setter ${TYPETAB[$i]} ${VARTAB[$i]} ${VARTAB[$i]^} $classname
	fi
done
printf "\n\tprivate:\n" >&3;
for (( i=0; i<=$(( $total -1 )); i++ ))
do 
	printf "\t\t%s" "${TYPETAB[$i]}" >&3
	lentype=${#TYPETAB[$i]}
	if [ $lentype -lt 4 ]; then
		printf "\t\t\t\t\t" >&3
	elif [ $lentype -lt 8 ]; then
		printf "\t\t\t\t" >&3
	else
		printf "\t\t\t" >&3
	fi
	printf "%s;\n" m_"${VARTAB[$i]}" >&3
done
printf "};\n\n#endif" >&3;
exec 3>&-
exec 4>&-