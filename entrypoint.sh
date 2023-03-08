#!/bin/bash
cname=""
cfile=""
args=""
cfile_index=0
# loop over the parameters
for arg in "$@";do
  if [ $cfile_index -eq 1 ]; then
    # the --cfile parameter's value, just jump
    cfile_index=2
    shift && continue
  elif [ $cfile_index -eq 0 ]; then
    # do with the parameter --cfile
    if [ "$arg" = "--cfile" ]; then
      # judge if supply a correct .c file 
      if [ $# > 1 ] && [ "${2:0:1}" != "-" ]; then
        cfile="$2"
        cfile_name=`basename $cfile`
        cfile_name_len=${#cfile_name}
        cfile_dot_index=$[ cfile_name_len-2 ]
        extname="${cfile_name:$cfile_dot_index}"
        # check if the extname is .c
        if [ $extname = ".c" ]; then
          cname="${cfile_name:0:$cfile_dot_index}"
          cfile_index=1
          shift && continue
        fi
      fi
      # not a .c file
      echo "wrong --cfile parameter '$2', it must be a .c file."
      exit 1
    fi
  fi
  # combine args
  args="${args} ${arg}"
  shift
done

# if has a cfile parameter
if [ -z $cfile ]; then
  echo "compile ${cfile}"
  # compile the c file and add to ld library path
  gcc -Wall -fPIC -shared -o lib${cname}.so ${cfile} && mv lib${cname}.so /lib64/
fi

# exec valgrind with the left args 
exec "valgrind ${args}"