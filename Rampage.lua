{
  "dns": {
    "servers": [
      "9.9.9.9",
      "8.8.8.8"
    ],
    "queryStrategy": "UseIP"
  },
  "routing": {
    "rules": [
      {
        "process": [
          "-1"
        ],
        "outboundTag": "block"
      },
      {
        "type": "field",
        "protocol": [
          "bittorrent"
        ],
        "outboundTag": "block"
      },
      {
        "type": "field",
        "domain": [
          "domain:xshoponline.ru",
          "geosite:telegram"
        ],
        "balancerTag": "auto"
      },
      {
        "ip": [
          "geoip:telegram"
        ],
        "type": "field",
        "balancerTag": "auto"
      },
      {
        "type": "field",
        "domain": [
          "domain:youtube.com",
          "domain:youtu.be",
          "domain:yt.be",
          "domain:googlevideo.com",
          "domain:ytimg.com",
          "domain:ggpht.com",
          "domain:youtube-nocookie.com",
          "domain:youtubei.googleapis.com",
          "domain:youtube.googleapis.com",
          "domain:youtubekids.com",
          "domain:withyoutube.com",
          "domain:youtubeeducation.com",
          "full:wide-youtube.l.google.com",
          "full:youtube-ui.l.google.com",
          "full:yt-video-upload.l.google.com"
        ],
        "balancerTag": "youtube"
      },
      {
        "type": "field",
        "domain": [
          "geosite:category-ru",
          "domain:max.ru",
          "domain:gosuslugi.ru"
        ],
        "outboundTag": "direct"
      },
      {
        "ip": [
          "geoip:ru",
          "geoip:private"
        ],
        "type": "field",
        "outboundTag": "direct"
      },
      {
        "type": "field",
        "network": "tcp,udp",
        "balancerTag": "auto"
      }
    ],
    "balancers": [
      {
        "tag": "auto",
        "selector": [
          "proxy"
        ],
        "strategy": {
          "type": "leastPing"
        },
        "fallbackTag": "proxy"
      },
      {
        "tag": "youtube",
        "selector": [
          "yt"
        ],
        "strategy": {
          "type": "leastPing"
        },
        "fallbackTag": "proxy"
      }
    ],
    "domainMatcher": "hybrid",
    "domainStrategy": "IPIfNonMatch"
  },
  "inbounds": [
    {
      "tag": "socks",
      "port": 10809,
      "protocol": "socks",
      "settings": {
        "udp": true,
        "auth": "noauth"
      },
      "sniffing": {
        "enabled": true,
        "routeOnly": false,
        "destOverride": [
          "http",
          "tls",
          "quic"
        ]
      }
    },
    {
      "tag": "http",
      "port": 10810,
      "protocol": "http",
      "settings": {
        "allowTransparent": false,
        "auth": "noauth"
      },
      "sniffing": {
        "enabled": true,
        "routeOnly": false,
        "destOverride": [
          "http",
          "tls",
          "quic"
        ]
      }
    },
    {
      "port": 0,
      "protocol": "tun",
      "settings": {
        "MTU": 1500,
        "name": "xray0",
        "userLevel": 8
      },
      "sniffing": {
        "destOverride": [
          "http",
          "tls",
          "quic"
        ],
        "enabled": true
      },
      "tag": "tun"
    }
  ],
  "outbounds": [
    {
      "tag": "proxy",
      "protocol": "vless",
      "settings": {
        "vnext": [
          {
            "address": "72.56.123.163",
            "port": 443,
            "users": [
              {
                "id": "ab73a42f-341b-453c-9b11-ec149790cea9",
                "encryption": "none",
                "flow": "xtls-rprx-vision"
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "tcpSettings": {},
        "security": "reality",
        "realitySettings": {
          "serverName": "nl1.xshoponline.ru",
          "publicKey": "zZvOJ5dL9qvOjzg4u6f_Zo2j37cM6HOnOeUG02kcKCQ",
          "shortId": "5c3639b7",
          "fingerprint": "firefox"
        }
      }
    },
    {
      "tag": "proxy-2",
      "protocol": "vless",
      "settings": {
        "vnext": [
          {
            "address": "72.56.88.181",
            "port": 443,
            "users": [
              {
                "id": "ab73a42f-341b-453c-9b11-ec149790cea9",
                "encryption": "none",
                "flow": "xtls-rprx-vision"
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "tcpSettings": {},
        "security": "reality",
        "realitySettings": {
          "serverName": "nl2.xshoponline.ru",
          "publicKey": "EkBRN12aZMx4Q_FCOcxB9KuzMkgLSBswmkDycnaTZWM",
          "shortId": "1a917cfae106f7dd",
          "fingerprint": "firefox"
        }
      }
    },
    {
      "tag": "proxy-3",
      "protocol": "vless",
      "settings": {
        "vnext": [
          {
            "address": "66.151.40.159",
            "port": 443,
            "users": [
              {
                "id": "ab73a42f-341b-453c-9b11-ec149790cea9",
                "encryption": "none",
                "flow": "xtls-rprx-vision"
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "tcpSettings": {},
        "security": "reality",
        "realitySettings": {
          "serverName": "de1.xshoponline.ru",
          "publicKey": "Z5c-WDN3JlGoSTDDKNVqKZsBbpwj80-xrM0jlYbgxzo",
          "shortId": "deb3256cd90dad0b",
          "fingerprint": "firefox"
        }
      }
    },
    {
      "tag": "proxy-4",
      "protocol": "vless",
      "settings": {
        "vnext": [
          {
            "address": "82.39.213.125",
            "port": 443,
            "users": [
              {
                "id": "ab73a42f-341b-453c-9b11-ec149790cea9",
                "encryption": "none",
                "flow": "xtls-rprx-vision"
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "tcpSettings": {},
        "security": "reality",
        "realitySettings": {
          "serverName": "us1.xshoponline.ru",
          "publicKey": "LPxsw0pGD7kfIEF0RJlSVYA37S6KKxoy9G0rmtmJqUA",
          "shortId": "df0037688b5b6984",
          "fingerprint": "firefox"
        }
      }
    },
    {
      "tag": "yt",
      "protocol": "vless",
      "settings": {
        "vnext": [
          {
            "address": "201.24.126.254",
            "port": 8445,
            "users": [
              {
                "id": "ab73a42f-341b-453c-9b11-ec149790cea9",
                "encryption": "none",
                "flow": "xtls-rprx-vision"
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "tcpSettings": {},
        "security": "reality",
        "realitySettings": {
          "serverName": "eh.vk.ru",
          "publicKey": "NsasJClRAw_9nAF0zmMMg1iDElr840ZJOShdiRuO_hU",
          "shortId": "8f3a1c9d2e7b4f60",
          "fingerprint": "firefox"
        }
      }
    },
    {
      "tag": "direct",
      "protocol": "freedom"
    },
    {
      "tag": "block",
      "protocol": "blackhole"
    }
  ],
  "burstObservatory": {
    "pingConfig": {
      "timeout": "5s",
      "interval": "1m",
      "sampling": 2,
      "destination": "https://www.gstatic.com/generate_204",
      "connectivity": ""
    },
    "subjectSelector": [
      "proxy",
      "yt"
    ]
  },
  "remarks": "🏳️‍🌈 хуй😶‍🌫️",
  "log": {
    "access": "/data/user/0/com.happproxy/files/logs/access/access_log.txt",
    "error": "/data/user/0/com.happproxy/files/logs/error/1792830625395_error_log.txt"
  }
}
