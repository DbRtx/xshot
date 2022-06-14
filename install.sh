#!/bin/bash
o='\033[0m'
r='\033[1;31m'
b='\033[1;36m'
bx='\033[2;7;36m'
w='\033[1;37m'
y='\033[1;33m'
g='\033[1;32m'
N=$r'['$y'~'$r'] '
P=$r'['$y'?'$r'] '
W=$w'['$r'!'$w'] '
S=$w'['$g'✓'$w'] '
I=$r'['$y'i'$r'] '
B=$w'['$y'+'$w'] '
font_dir="/data/data/com.termux/files/home/.fonts"
local="/data/data/com.termux/files/home/.local"
bin="${local}/bin"
sdcard="/data/data/com.termux/files/home/storage/"
dir_package="/data/data/com.termux/files/usr/bin"
package=(
  "magick"
  "inotifywait"
  "bc"
)
log ()
{
  echo -e "${r}[${y}$(date +'%H:%M:%S')${r}]${o} $@"
}
check ()
{
  if [[ $? -eq 0 && ${PIPESTATUS[0]} -eq 0 ]]; then
    2> /dev/null
  else
    echo -e "$(log)${r}Error"
    exit 1
  fi
}
ad ()
{
  echo -e "$(log)${g}package already exists"
}
header ()
{
echo -e "${r}
╔══╗     ╔╗   ╔╗╔╗
╚╣╠╝    ╔╝╚╗  ║║║║
 ║║╔═╗╔═╩╗╔╬══╣║║║╔══╦═╗
 ║║║╔╗╣══╣║║╔╗║║║║║║═╣╔╝
╔╣╠╣║║╠══║╚╣╔╗║╚╣╚╣║═╣║
╚══╩╝╚╩══╩═╩╝╚╩═╩═╩══╩╝${b}
      xshot 1.0.3
"
}
enter ()
{
  echo -e "${P}${b}press enter to continue ..."
}
header
read -p $"$(enter)" enter
echo -e "$(log)${b}Installing package requirements"
echo -e "${r}[${y}imagemagick${r}]"
if [[ ! "${dir_package}/${package[0]}" ]]; then
  pkg i imagemagick -y
  check
else
  ad 
fi
echo -e "${r}[${y}inotify-tools${r}]"
if [[ ! "${dir_package}/${package[1]}" ]]; then
  pkg i inotify-tools -y
  check
else
  ad
fi
echo -e "${r}[${y}Bc${r}]"
if [[ ! "${dir_package}/${package[2]}" ]]; then
  pkg i bc -y
  check
else
  ad
fi
echo -e "$(log)${b}Installing fonts"
cp -rf "$(pwd)/fonts" ~/.fonts
check
if [[ ! -d ${sdcard} ]]; then
  termux-setup-storage
fi
echo -e "${I}${b}Looking directory ${y}~/.local/bin/${b} ..."
sleep 1s
if [[ ! -d ${local} ]]; then
  echo -e "${I}${b}Creating directory ..."
  mkdir ${local} && mkdir ${bin}
  check
else
  echo -e "${I}${b}directory ${y}~/.local/bin/${b} already exists"
fi
echo -e "${I}${b}moving file ${y}xshot${b} ..."
sleep 1s
cp xshot.sh ${bin}/xshot
check
chmod +x ${bin}/xshot 
check
echo -e "$(log)${g}installation complete"
echo -e "${o}
run tools with command 'xshot'"
