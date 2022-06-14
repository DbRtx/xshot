#!/usr/bin/env bash
# xshot automatic screenshots
# coded by D_baj
# xshot 1.0.3

# color
o='\033[0m'
r='\033[1;31m'
b='\033[1;36m'
bx='\033[2;7;36m'
w='\033[1;37m'
y='\033[1;33m'
g='\033[1;32m'
#hex color
hex_color=(
  "#3d465c" #dark
  "#1E222B" #dark2
  "#F8F9FA" #light
  "#000000" #black
  "fffffff" #white
  "#59d6ff" #blue
  "#e6e6e6" #gray
  "#38d13e" #green
  )
# other
N=$r'['$y'~'$r']'
P=$r'['$y'?'$r'] '
W=$r'['$r'!'$r'] '
F=$r'['$r'x'$r'] '
S=$r'['$g'✓'$r'] '
I=$r'['$r'*'$r'] '
B=$r'['$y'+'$r'] '
# path
camera_path="/sdcard/DCIM/Camera"
screenshots_path="/sdcard/DCIM/screenshots"
camera_backup="${camera_path}/backup"
screenshots_backup="${screenshots_path}/backup"
manual_backup="/sdcard/DCIM/backup"
# style
#titlebar
convert_titlebar="yes"
add_on_img=""
width_img=500
height_img=1000
#border
border_size=50
border_radius=10
border_c_dark="${hex_color[0]}"
border_c_light="${hex_color[2]}"
# shadow
shadow_size="85x10+0+10"
shadow_color="${hex_color[3]}"
# footer text
owner_info=" @D_∆J"
footer_text=" Shot by Xshot"
#footer style
#xshot
footer_xy="+0+30"
footer_xy_time="+0+20"
footer_size=20
footer_size_time=15
footer_color="${hex_color[3]}"
#timeStamp
footer_xy_timeStamp2="+50+50"
footer_xy_timeStamp="+50+200"
footer_size_timeStamp=55
footer_color_timeStamp="${hex_color[5]}"
footer_color_timeStamp2="${hex_color[6]}"
#other
count=1
check_format=(
  "${g}Done"
  "${r}Failed"
  "${g}Done"
  "${r}Failed"
)
if [[ ${type} = "MANUAL SHOT" ]]; then
  check_s=${check_format[2]}
  check_f=${check_format[3]}
else
  check_s=${check_format[0]}
  check_f=${check_format[1]}
fi
backup="yes" #default yes
#create backup
if [[ ! -d ${screenshots_backup} ]]; then
  mkdir "${screenshots_backup}"
elif [[ ! -d ${camera_backup} ]]; then
  mkdir "${camera_backup}"
elif [[ ! -d "${manual_backup}" ]]; then
  mkdir "${manual_backup}"
fi
light () {
  color="LIGHT"
  titlebar_color=${hex_color[1]}
  border_color=${border_c_light}
}
dark () {
  color="DARK"
  titlebar_color=${hex_color[1]}
  border_color=${border_c_dark}
}
backup ()
{
  renamed=$(echo $file_name | sed "s/.jpg/_backup.jpg/g")
  chmod +x "${file}"
  cp "${file}" "${path_backup}/${renamed}"
}
log () {
  echo -e "${r}[${y}$(date +'%H:%M:%S')${r}]${o} $@"
}
prompt(){
  echo -e "$(log)${b}Please input file : ${y}"
}
check() {
  if [[ $? -eq 0 && ${PIPESTATUS[0]} -eq 0 ]]; then
    echo -e "   $(log)${check_s}"
  else
    echo -e "   $(log)${check_f}"
    exit 1
  fi
}
count() {
  echo -e "${r}[${y}$((${count} + 1 ))${r}]${o}"
}
header() {
  echo -e "
${r}             ╔═══════════════════════════════╗
             ║    ╔═╗╔═╦═══╦╗ ╔╦═══╦════╗    ║
             ║    ╚╗╚╝╔╣╔═╗║║ ║║╔═╗║╔╗╔╗║    ║
             ║     ╚╗╔╝║╚══╣╚═╝║║ ║╠╝║║╚╝    ║
             ║     ╔╝╚╗╚══╗║╔═╗║║ ║║ ║║      ║
             ║    ╔╝╔╗╚╣╚═╝║║ ║║╚═╝║ ║║      ║
             ║    ╚═╝╚═╩═══╩╝ ╚╩═══╝ ╚╝      ║
             ║            ${b}V1.0.3${r}             ║
             ║       screenshot tools${r}        ║
             ╚═══════════════════════════════╝

             ╔═══════════════════════════════╗
             ║        ${y}    EXECUTE${r}            ║
   ╔═════════╩═══════════════════════════════╩═════════╗
   ╚═══════════════════════════════════════════════════╝
   ╔════════════════════╗         ╔════════════════════╗
   ║ ${y}TYPE : ${b}${type}${space1}${y}THEME : ${b}${color}${space2}
   ╚════════════════════╝         ╚════════════════════╝
                  press ctrl + c for close"
}
help() {
  echo -e "${y}
  Usage :
      xshot [options1] [options2] [options3]

      options 1:
      -h       Show help display
      -i       show program information
      -a       autoshot (run automatic detect new file)
      -m       manual input file
      -wm      automatic add wateemark to your image capture
      options 2:
      -l       light theme
      -d       dark theme
      options 3:
      -!       run autoshot without footer text

      examples:
      
      xshot -a -l
      xshot -a -l -!

  "
}
program_info(){
  echo -e "${r}             
                 ╔═══════════════════════════════╗
                 ║    ╔═╗╔═╦═══╦╗ ╔╦═══╦════╗    ║
                 ║    ╚╗╚╝╔╣╔═╗║║ ║║╔═╗║╔╗╔╗║    ║
                 ║     ╚╗╔╝║╚══╣╚═╝║║ ║╠╝║║╚╝    ║
                 ║     ╔╝╚╗╚══╗║╔═╗║║ ║║ ║║      ║
                 ║    ╔╝╔╗╚╣╚═╝║║ ║║╚═╝║ ║║      ║
                 ║    ╚═╝╚═╩═══╩╝ ╚╩═══╝ ╚╝      ║
                 ║            ${b}V1.0.3${r}             ║
                 ║       screenshot tools${r}        ║
                 ╚═══════════════════════════════╝
${b}
            A tool to make your screenshots look better
                           Owner : D_4J
                     Build date : 05/05/2022"
}
autoshot() {
  clear
  header
  echo -e "   ${r}[${y}${count}${r}]"
  echo -e "   $(log)${b}Waiting new file"
  inotifywait -m -e create $path 2> /dev/null | \
    while read filename; do
      main
    done
}
manual() {
  clear
  header
  read -p "   $(prompt)" file_name
  echo -e "   $(log)${b}find file ${y}${file_name}${b} in path ${y}/sdcard"
  cd /sdcard
  if [[ $? -eq 0 && ${PIPESTATUS[0]} -eq 0 ]]; then
    result=$(find -name "${file_name}" | sed 's .\{2\}  ')
    if [[ ${result} = "" ]]; then
      echo -e "   $(log)${r}file not found, please check again !"
      exit 1
    fi
    echo -e "   $(log)${b}found file in ${y}/sdcard/${result}"
    file="/sdcard/${result}"
    echo -e "   $(log)${b}converting file ..."
    titlebar
    ss
  else
    echo -e "   $(log)${r}permission denied, please run ${y}termux-setup-storage"
  fi
   
}
main(){
  file_name=$(echo -e "${filename}" | awk '{print $3}')
  file=${path}/${file_name}
  echo -e "   $(log)${b}Find file"
  echo -e "   $(log)${b}Found file ${y}${file_name}"
  if [[ ${run} = "auto" ]]; then
    if [[ $backup = "yes" ]]; then
      echo -e "   $(log)${b}Backup file"
      backup
    fi
    echo -e "   $(log)${b}Converting"
    titlebar
    ss
  elif [[ ${run} = "wm" ]]; then
    echo -e "   $(log)${b}Converting"
    timeStamp
  fi
}
titlebar(){
#  width_img=$(magick ${file} - format "%w" info:)
#  height_img=$(magick ${file} - format "%h" info:)
#  if (( ${width_img} > ${height_img} )); then
#    height_img=${width_img}
#  elif (( ${width_img} < ${height_img} )); then
#    width_img=${height_img}
#  fi
# function coded by arman 
  gr="#27C93F" #green
  yl="#FFBD2E" #yellow
  rd="#FF5F56" #red
  bl="#282C34" #black

  rad=$( echo "0.0025 * ${width_img} * ${height_img} / 100" | bc )
  br=$( echo "${rad} * 5" | bc )
  x0=$( echo "${rad} * 3" | bc )
  y0=$( echo "${br} * 0.5" | bc )
  x1=$( echo "${x0} + ${rad}" | bc )

  declare -A arr=()
  for i in {0..2}; do
    arr[$i,0]=$x0
    arr[$i,1]=$y0
    arr[$i,2]=$x1
    arr[$i,3]=$y0
    x0=$( echo "${x0} + ${rad} * 3" | bc )
    x1=$( echo "${x0} + ${rad}" | bc)
  done

  #1520x720
  #760x360
  if [[ "${add_on_img}" == "yes" ]]; then  
    magick "$" -fill $bl \
      -background ${titlebar_color} \
      -gravity north \
      -chop 0x$br \
      -splice 0x$br \
      -draw "fill ${rd}   circle ${arr[0,0]},${arr[0,1]} ${arr[0,2]},${arr[0,3]}
      fill ${yl}   circle ${arr[1,0]},${arr[1,1]} ${arr[1,2]},${arr[1,3]} 
      fill ${gr}   circle ${arr[2,0]},${arr[2,1]} ${arr[2,2]},${arr[2,3]}" \
      $file
  else
    magick $file -fill $bl \
      -background ${titlebar_color} \
      -gravity north -splice 0x$br\
      -draw "fill ${rd}   circle ${arr[0,0]},${arr[0,1]} ${arr[0,2]},${arr[0,3]}
      fill ${yl}   circle ${arr[1,0]},${arr[1,1]} ${arr[1,2]},${arr[1,3]} 
      fill ${gr}   circle ${arr[2,0]},${arr[2,1]} ${arr[2,2]},${arr[2,3]}" \
      $file
  fi
}
ss() {
  footer_time=" $(date +'%a %d.%h.%Y')  $(date +'%H:%M')"
  convert "$file" \
    -alpha set -virtual-pixel transparent \
    -channel A -blur 0x5  -threshold 50% +channel \
    \( +clone -background "${shadow_color}" \
    -shadow ${shadow_size} \) \
    +swap -background none -layers merge +repage \
    -bordercolor "${border_color}" -border ${border_size} \
    "$file"
  if [[ ${wm} = "no" ]]; then
    #nowm
    check
    if [[ $type = "MANUAL SHOT" ]]; then
      echo -e "   $(log)${g}${file}${r}"
    else
      echo -e "   ${r}[ ${g}${file}${r} ]"
      count=$(( ${count} + 1 ))
      echo -e "   ${r}[${y}${count}${r}]"
      echo -e "   $(log)${b}Waiting new file"
    fi
  else
  convert "$file" \
    -gravity South -background none \
    -font JetBrains-Mono-Medium-Nerd-Font-Complete \
    -pointsize ${footer_size} \
    -fill ${footer_color} \
    -annotate ${footer_xy} "${footer_text}" \
    -gravity North -background none \
    -pointsize ${footer_size_time} \
    -annotate ${footer_xy_time} "${footer_time}" \
    "$file"
  check
  if [[ $type = "MANUAL SHOT" ]]; then
    echo -e "   $(log)${g}${file}${r}"
  else
    echo -e "   ${r}[ ${g}${file}${r} ]"
    count=$(( ${count} + 1 ))
    echo -e "   ${r}[${y}${count}${r}]"
    echo -e "   $(log)${b}Waiting new file"
  fi
 fi
}
timeStamp() {
  owner_info=" @D_4J"
  owner_info2=" $(date +'%H:%M')
 $(date +'%a %d.%h.%Y')"
  convert "${file}" \
    -gravity SouthWest -background black \
    -font JetBrains-Mono-Medium-Nerd-Font-Complete \
    -pointsize $footer_size_timeStamp \
    -fill $footer_color_timeStamp \
    -annotate $footer_xy_timeStamp "${owner_info}" \
    -fill $footer_color_timeStamp2 \
    -annotate $footer_xy_timeStamp2 "${owner_info2}" \
    "${file}"
  check
  echo -e "   ${r}[   ${g}${file}${r}     ]"
  count=$(( ${count} + 1 ))
  echo -e "   ${r}[${y}${count}${r}]"
  echo -e "   $(log)${b}Waiting new file"
}
if [[ $3 = "-!" ]]; then
  wm="no"
elif [[ $4 = "" ]]; then
  input="yes"
fi
case "$1" in
  -a )
    type="AUTOSHOT"
    space1="${r}    ║         ║ "
    path=${screenshots_path}
    path_backup=${screenshots_backup}
    run="auto"
    case "$2" in
      -l )
        space2="${r}      ║"
        light
        autoshot
      ;;

      -d)
        space2="${r}       ║"
        dark
        autoshot
      ;;

      * )
        help
      ;;
    esac
    
  ;;

  -m )
    type="MANUAL SHOT"
    path=${FILE}
    space1="${r} ║         ║ "
    run="manual"
    case "$2" in
      -l )
        light
        space2="${r}      ║"
        manual
      ;;

      -d )
        dark
        space2="${r}       ║"
        manual
      ;;

      * )
        help
      ;;

    esac
  ;;

  -wm )
    type="TIME STAMP"
    path=${camera_path}
    path_backup=${camera_backup}
    space1="${r}  ║         ║ "
    color="none"
    space2="${r}       ║"
    run="wm"
    autoshot
  ;;

  -i )
    program_info
  ;;

  * )
    help
  ;;
esac

