function proxy
    switch $argv[1]
        case on
            # 设置 HTTP/HTTPS 代理
            set -gx http_proxy  http://127.0.0.1:7890
            set -gx https_proxy http://127.0.0.1:7890

            # 设置 SOCKS5 代理 (针对支持 ALL_PROXY 的工具，如 curl)
            set -gx all_proxy   socks5://127.0.0.1:7891

            # 设置一些不需要代理的地址
            set -gx no_proxy    "127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"

            echo "Proxy enabled (HTTP: 7890, SOCKS: 7891)"

        case off
            # 擦除变量
            set -e http_proxy
            set -e https_proxy
            set -e all_proxy
            set -e no_proxy

            echo "Proxy disabled"

        case status
            if set -q http_proxy
                echo "Proxy is ON: $http_proxy"
            else
                echo "Proxy is OFF"
            end

        case '*'
            echo "Usage: proxy [on|off|status]"
    end
end
