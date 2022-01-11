# Run this file with sh command in HA docker to auto REPLACE the github download website in HACS download.py file /config/custom_components/hacs/helpers/function/download.py
# Script by chuixue
#! /bin/bash

# The following is the default HACS download URL file path. Change it if yours is not the current path
ha_path="/config"
github_com_mirror="hub.fastgit.org"
raw_githubusercontent_com_mirror="raw.fastgit.org"


#######
ha_path=$(cd ${ha_path}; pwd)
old_download_url_path="${ha_path}/custom_components/hacs/helpers/functions/download.py"
new_download_url_path="${ha_path}/custom_components/hacs/base.py"

if [ -f "${old_download_url_path}" ]; then
  download_url_path=${old_download_url_path}
  url_blank="    "
else
  download_url_path=${new_download_url_path}
  url_blank="        "
fi

# Delete the old lines in hacs url file if it is available
sed  -i '/url = url.replace("raw.githubusercontent.com", "'"${raw_githubusercontent_com_mirror}"'")/,/url = url.replace("\/\/github.com\/", "\/\/'"${github_com_mirror}"'\/")/d' $download_url_path


# Add the new lines in hacs url file
sed -i '/if "tags\/" in url:/i\'"${url_blank}"'url = url.replace("raw.githubusercontent.com", "'"${raw_githubusercontent_com_mirror}"'")\n'"${url_blank}"'if "releases/download/" in url or "archive/refs/" in url:\n'"${url_blank}"'    url = url.replace("//github.com/", "//'"${github_com_mirror}"'/")' $download_url_path



