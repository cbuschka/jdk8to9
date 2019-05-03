#/bin/bash -xe

jarfile=$1
if [ -f "${jarfile}" ]; then
  echo "jar ${jarfile} does not exist."
  exit 1
fi

modulename=$2

if [[ "x${jarfile}" == "x" ]] || [[ "x${modulename}" == "x" ]]; then
  echo "$(basename $0) <jar file> <module name>"
  exit 1
fi

jdeps --generate-module-info . ${jarfile}
javac --patch-module ${modulename}=${jarfile} ${modulename}/module-info.java
jar -uf $(dirname ${jarfile})/$(basename ${jarfile} .jar)-jdk9.jar -C ${modulename} module-info.class
