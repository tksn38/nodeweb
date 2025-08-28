#!/bin/bash
isExistApp = `pgrep forever`
if [[ -n  $isExistApp ]]; then
    forever stop /var/www/html/app.json
fi