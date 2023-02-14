local circled_digits='⓪ ① ② ③ ④ ⑤ ⑥ ⑦ ⑧ ⑨ ⑩ ⑪ ⑫ ⑬ ⑭ ⑮ ⑯ ⑰ ⑱ ⑲ ⑳'
if [ "$1" -le 20 ] 2>/dev/null; then
  i=$(( $1 + 1 ))
  eval set -- "$circled_digits"
  eval echo "\${$i}"
else
  echo "$1"
fi