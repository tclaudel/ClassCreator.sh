#!/bin/bash

echo "Class creator :";
echo -n "- What's your class name ? : ";
read classname;
touch $classname.hpp;
echo "\t$classname.hpp created !";
fd="$classname.hpp";
exec 3<>$fd;
echo -n "#ifndef " >&3;
echo "$classname"_hpp | tr [a-z] [A-Z] >&3;
echo -n "# define " >&3;
echo "$classname"_hpp | tr [a-z] [A-Z] >&3;
echo "" >&3;
echo "\nplease list which SYSTEM HEADER you would like to include [q to exit]?";
while read -p "header : " REPLY;
do
    if [ -z "$REPLY" ] || [ $REPLY = q ]
    then
        break;
    else
        echo "# include <$REPLY>" >&3
    fi
done
echo "\nplease list which USER HEADER you would like to include [q to exit]?";
while read -p "header : " REPLY;
do
    if [ -z "$REPLY" ] || [ $REPLY = q ]
    then
        break;
    else
        echo "# include \"$REPLY\"" >&3
    fi
done
echo "\nclass $classname\n{\n\tpublic:\n" >&3;
echo ""
read -p "Would you like a constructor [y/n] ? " REPLY;
if [ $REPLY = y ];
then
    echo "\t\t$classname(void);" >&3
fi
read -p "Would you like a destructor  [y/n] ? " REPLY;
if [ $REPLY = y ];
then
    echo "\t\t~$classname(void);" >&3
fi
echo "\n\tprivate:" >&3;
echo "\nplease list your var [q to exit]?";
while read -p "var : " TYPE VAR;
do
    if [ -z "$TYPE" ] || [ $TYPE = q ]
    then
        break;
    else
		if [ $TYPE = "string" ]
			then
				echo "\t\tstd::string\t\tm_$VAR;" >&3;
		else
			echo "\t\t$TYPE\t\t\tm_$VAR;" >&3;
		fi
	fi
done
echo "};\n\n#endif" >&3;
exec 3>&-