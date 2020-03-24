#!/bin/bash

function create_setter {
	printf "\nvoid\t\t\t%s::set%s(%s value)\n" $4 $3 $1 >&4
	printf "\t\tvoid\t\t\t\tset%s(%s value);\n" $3 $1 >&3
	printf "{\n\tm_%s = value;\n}\n" $2 >&4
}

function create_getter {
	printf "\n%s\t\t\t%s::get%s(void)\n" "$1" $4 "$3" >&4
	printf "\t\t%s\t\t\tget%s(void);\n" "$1" "$3" >&3
	printf "{\n\treturn (m_%s);\n}\n" "$2" >&4
}

printf "Class creator :\n";
printf "\tWhat's your class name ? : "
read classname;
rm $classname.hpp $classname.cpp;
touch $classname.hpp $classname.cpp;
printf "\n\t$classname.hpp created !\n";
printf "\t$classname.cpp created !\n";
fd="$classname.hpp";
fd1="$classname.cpp";
exec 4<>$fd1;
exec 3<>$fd;
printf "#include \""$classname".hpp\"\n\n" >&4;
printf "$classname::$classname()\n{\n}\n\n" >&4;
printf "$classname::$classname(const $classname &copy)\n{\n\t*this = copy;\n}\n\n" >&4;
printf "$classname::~$classname()\n{\n}\n\n" >&4;
printf "$classname\t\t\t&$classname::operator=(const $classname &affected)\n{\n}\n" >&4;
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
printf "\nclass $classname\n{\n\tpublic:\n" >&3;
printf ""
printf "\t\t$classname(void);\n" >&3
printf "\t\t%s(const %s &copy);\n" $classname $classname >&3
printf "\t\t~$classname(void);\n" >&3
printf "\t\t%s\t\t\t\t&operator=(const %s &affectation);\n" $classname $classname >&3
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
	printf "\t\t%s\t\t\t%s;\n" "${TYPETAB[$i]}" m_"${VARTAB[$i]}" >&3
done
printf "};\n\n#endif" >&3;
exec 3>&-
exec 4>&-