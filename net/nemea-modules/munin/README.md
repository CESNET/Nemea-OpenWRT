# NEMEA munin plugins

## Description

This guide describes how to report flow_meter statistics by munin client on openwrt.

## muninlite client

Download and [install](https://trent.utfs.org/wiki/OpenWRT#muninlite) muninlite [client](https://sourceforge.net/projects/muninlite/) on openwrt. Then add the following functions to the `/usr/sbin/munin-node` file

```
flow_print_config() {
  echo "graph_title captured flow ${PROFILE}"
  FLOW_PLUGINS="basic http https smtp passivedns dns ntp sip arp"

  echo -n "graph_order"
    for i in ${FLOW_PLUGINS:-basic}; do
      echo -n " ${i}"
    done
  echo

  echo "graph_args --base 1000 --lower-limit 0"
  echo "graph_vlabel number of flows"
  echo "graph_info This graph shows number of captured flows by flow_meter module with profile ${PROFILE}."
  echo "graph_category network"

  for i in ${FLOW_PLUGINS:-basic}; do
    echo "${i}.label ${i}"
    echo "${i}.draw LINE1"
    echo "${i}.type COUNTER"
    echo "${i}.min 0"
    echo "${i}.info number of sent flows parsed by ${i} plugin in ${PROFILE} profile"
  done
}

flow_print_values() {
  for i in `pgrep flow_meter`; do
    /usr/bin/nemea/trap_stats -s /tmp/trap-*_${i}.sock -1 | tail -n +3 | \
        sed 's/^[\t ]*ID: [^,]*'${PROFILE}'\/\(basic\|http\|dns\|sip\|ntp\|arp\)[^,]*,/ID: \1,/; tx; d; :x; s/ //g' | \
        awk -F, '{split($1,arr,":"); fld=arr[2]; split($4,arr,":"); printf("%s.value %s\n", fld, arr[2]);}'
  done
}

config_flow_wan() {
  PROFILE="wan"
  
  flow_print_config
}

fetch_flow_wan() {
  PROFILE="wan"

  flow_print_values
}

config_flow_lan() {
  PROFILE="lan"

  flow_print_config
}

fetch_flow_lan() {
  PROFILE="lan"

  flow_print_values
}
```

add `flow_wan flow_lan` to the `PLUGINS` variable. Munin node should report data about `lan` and `wan` flow_meter profiles.

## Other clients

Setup on other munin clients like [this one](https://github.com/Maffsie/openwrt-munin-node) is done by copying `flow_lan` and `flow_lan` files to `plugins.d/` folder. 

