#!/usr/bin/env sh

get_init_option() {
  file="${1:-}"
  if [ ! -f "$file" ]; then
    return 1
  fi
  shift

  for opt in "$@"; do
    grep "^${opt}=" "$file" | awk -F'=' '{sub($1"=", "", $0); print $0}' | xargs
  done
}

has_ssl_enabled() {
  [ "$(get_init_option /etc/sysconf/sysConfig.ini server_ssl_enable)" -eq 1 ]
}

get_conga_model() {
  case "$(get_init_option /etc/sysconf/sysVersion.ini hardsysVersion sysVersion sysProduct | tr '\n' '#')" in
    "1.0.1#S1.2.10#CECOTECCRL20D#")
      echo "3290/3490"
      ;;
    "1.0.2#S3.3.10#CECOTECCRL20S#")
      echo "3890"
      ;;
    "1.0.1#S3.3.8#CECOTECCRL300#")
      echo "4090"
      ;;
    "1.0.1#S3.2.6#CECOTECCRL30S#")
      echo "5090"
      ;;
    "1.0.1#S4.2.2#CECOTECCRL30S#")
      echo "5490"
      ;;
  esac
}

is_compatible_valetudo_model() {
  [ -n "$(get_conga_model)" ] && ! has_ssl_enabled
}
