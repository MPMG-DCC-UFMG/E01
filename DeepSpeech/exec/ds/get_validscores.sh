tail -n$(wc -l $1 | awk '{print $1}' ) -f  $1 | awk '{if ($1=="--------Time:") print $0"\n"}'
