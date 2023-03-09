#!/bin/bash
cname=""
cfile=""
args=""
# loop over the args
while [ $# -ne 0 ]; do
  # do with the arg --cfile
  if [ "$1" = "--cfile" ]; then
    # judge if supply a correct .c file 
    if [ $# -gt 1 ] && [ "${2:0:1}" != "-" ]; then
      cfile="$2"
      cfile_name=`basename $cfile`
      cfile_name_len=${#cfile_name}
      cfile_dot_index=$[ cfile_name_len-2 ]
      extname="${cfile_name:$cfile_dot_index}"
      # check if the file's extension name is .c
      if [ $extname = ".c" ]; then
        cname="${cfile_name:0:$cfile_dot_index}"
        # add the left args
        args="${args} ${@:3}"
        # end the process
        break
      fi
    fi
    # not a .c file
    echo "wrong --cfile parameter '$2', it must be a .c file."
    exit 1
  fi
  # combine args
  args="${args} ${1}"
  shift
done

# if has a cfile parameter
if [ -n "$cfile" ]; then
  echo "compile c library: ${cfile}"
  # compile the c file and add to ld library path
  gcc -Wall -fPIC -shared -std=c99 -o lib${cname}.so ${cfile} && mv lib${cname}.so /lib64/
fi

# exec valgrind with the left args 
exec /usr/bin/valgrind ${args}