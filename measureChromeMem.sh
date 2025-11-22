ps -o rss -p $(pgrep -d, -x chrome.orig) | awk 'NR>1 {sum+=$1} END {print sum/1024/1024 " GB"}'
