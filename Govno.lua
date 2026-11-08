{
  "dns": {
    "tag": "rc-fleet-3-18-cascade-dns",
    "hosts": {
      "dns.google": [
        "8.8.8.8",
        "8.8.4.4"
      ],
      "dns.quad9.net": [
        "9.9.9.9",
        "149.112.112.112"
      ],
      "cloudflare-dns.com": [
        "1.1.1.1",
        "1.0.0.1"
      ],
      "common.dot.dns.yandex.net": [
        "77.88.8.8",
        "77.88.8.1"
      ]
    },
    "servers": [
      "8.8.8.8",
      "https://dns.google/dns-query",
      "77.88.8.8",
      "https://common.dot.dns.yandex.net/dns-query",
      "1.1.1.1",
      "https://cloudflare-dns.com/dns-query",
      "9.9.9.9",
      "https://dns.quad9.net/dns-query"
    ],
    "serveStale": false,
    "disableCache": false,
    "queryStrategy": "UseIPv4",
    "disableFallback": false,
    "enableParallelQuery": false,
    "disableFallbackIfMatch": false
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
        "inboundTag": [
          "rc-fleet-3-18-cascade-dns"
        ],
        "outboundTag": "proxy-main"
      },
      {
        "type": "field",
        "protocol": [
          "bittorrent"
        ],
        "outboundTag": "block"
      },
      {
        "port": "443",
        "type": "field",
        "network": "udp",
        "outboundTag": "block"
      },
      {
        "ip": [
          "geoip:private"
        ],
        "type": "field",
        "outboundTag": "direct"
      },
      {
        "type": "field",
        "domain": [
          "domain:tbank.ru",
          "domain:tinkoff.ru",
          "domain:sberbank.ru",
          "domain:raiffeisen.ru",
          "domain:gazprombank.ru",
          "domain:open.ru",
          "domain:psbank.ru",
          "domain:sovcombank.ru",
          "domain:sber.ru",
          "domain:vtb.ru",
          "domain:2gis.com",
          "domain:2gis.ru",
          "domain:eda.yandex.ru",
          "domain:lavka.yandex.ru",
          "domain:alfabank.ru",
          "domain:mail.ru",
          "domain:mycdn.me",
          "domain:imgsmail.ru",
          "domain:ozon.ru",
          "domain:ozonbank.ru",
          "domain:wildberries.ru",
          "domain:wb.ru",
          "domain:wbstatic.net",
          "domain:gosuslugi.ru",
          "domain:yandex.ru",
          "domain:yandex.net",
          "domain:yandex.com",
          "domain:yandexcloud.net",
          "domain:yastatic.net",
          "domain:trvl.yandex.net",
          "vk-analytics.ru",
          "vk-apps.com",
          "vk-apps.ru",
          "vk-cdn.me",
          "vk-cdn.net",
          "vkcloud-static.ru",
          "vk-portal.net",
          "vk.cc",
          "vk.com",
          "vk.company",
          "vk.design",
          "vk.link",
          "vk.me",
          "vk.ru",
          "vk.team",
          "vkcache.com",
          "vkgo.app",
          "vklive.app",
          "domain:ya.ru",
          "domain:avito.ru",
          "domain:avito.st",
          "domain:oneme.ru",
          "domain:max.ru",
          "domain:ivi.ru",
          "domain:ivi.tv",
          "domain:ivicdn.ru",
          "domain:magnit.ru",
          "domain:kfc.ru",
          "domain:ads.x5.ru",
          "domain:aif.ru",
          "domain:aeroflot.ru",
          "domain:beeline.ru",
          "domain:burgerkingrus.ru",
          "domain:dellin.ru",
          "domain:drive2.ru",
          "domain:dzen.ru",
          "domain:flypobeda.ru",
          "domain:forbes.ru",
          "domain:gazeta.ru",
          "domain:gismeteo.ru",
          "domain:hh.ru",
          "domain:kontur.ru",
          "domain:kontur.host",
          "domain:kp.ru",
          "domain:kuper.ru",
          "domain:megamarket.ru",
          "domain:megamarket.tech",
          "domain:megafon.ru",
          "domain:moex.com",
          "domain:motivtelecom.ru",
          "domain:cdnwb.ru",
          "domain:pervye.ru",
          "domain:rambler.ru",
          "domain:rambler-co.ru",
          "domain:rbc.ru",
          "domain:2ip.io",
          "domain:rg.ru",
          "domain:ria.ru",
          "domain:ruwiki.ru",
          "domain:rustore.ru",
          "domain:rutube.ru",
          "domain:rzd.ru",
          "domain:sirena-travel.ru",
          "domain:sravni.ru",
          "domain:t-j.ru",
          "domain:t2.ru",
          "domain:tank-online.com",
          "domain:taximaxim.ru",
          "domain:tbank-online.com",
          "domain:tildaapi.com",
          "domain:tns-counter.ru",
          "domain:tutu.ru",
          "domain:vkvideo.ru",
          "domain:go.yandex",
          "domain:xn--90acagbhgpca7c8c7f.xn--p1ai",
          "domain:xn--80ajghhoc2aj1c8b.xn--p1ai",
          "domain:xn--90aivcdt6dxbc.xn--p1ai",
          "domain:xn--b1aew.xn--p1ai",
          "domain:sdk-api.apptracer.ru"
        ],
        "outboundTag": "direct"
      },
      {
        "type": "field",
        "network": "tcp,udp",
        "balancerTag": "Super_Balancer"
      }
    ],
    "balancers": [
      {
        "tag": "Super_Balancer",
        "selector": [
          "proxy-main"
        ],
        "strategy": {
          "type": "leastLoad",
          "settings": {
            "costs": [],
            "maxRTT": "0s",
            "expected": 1,
            "tolerance": 1
          }
        },
        "fallbackTag": "block"
      }
    ],
    "domainMatcher": "hybrid",
    "domainStrategy": "IPIfNonMatch"
  },
  "inbounds": [
    {
      "tag": "socks",
      "port": 10809,
      "listen": "127.0.0.1",
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
        ],
        "domainsExcluded": [
          "courier.push.apple.com",
          "push.apple.com",
          "api.push.apple.com",
          "regexp:(^|\\.)telegram\\.org$",
          "regexp:(^|\\.)t\\.me$",
          "regexp:(^|\\.)whatsapp\\.com$",
          "regexp:(^|\\.)whatsapp\\.net$"
        ]
      }
    },
    {
      "tag": "http",
      "port": 10808,
      "listen": "127.0.0.1",
      "protocol": "http",
      "settings": {
        "allowTransparent": false
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
      "tag": "proxy-main",
      "protocol": "vless",
      "settings": {
        "vnext": [
          {
            "address": "45.88.162.163",
            "port": 443,
            "users": [
              {
                "id": "038b3fd8-fe1c-46fa-babb-63b8f6835e8e",
                "encryption": "none",
                "flow": ""
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "grpc",
          "authority": "",
          "mode": false
        },
        "security": "reality",
        "realitySettings": {
          "serverName": "cascade-bd844643e63a.ss-m-g1-e1299e2221bb.securecontentcenter.shop",
          "publicKey": "B7CglcDMpnOCMkeefnijxsSFXTVU98XGiI9srg_3XVY",
          "shortId": "b54301deae423d18",
          "fingerprint": "qq"
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
      "timeout": "4s",
      "interval": "5s",
      "sampling": 1,
      "destination": "https://www.google.com/generate_204",
      "connectivity": ""
    },
    "subjectSelector": [
      "proxy-main"
    ]
  },
  "remarks": "🇪🇺Резервный 🇷🇺→🇪🇺 18",
  "meta": {
    "serverDescription": "если не покакал дома"
  },
  "log": {
    "access": "/data/user/0/com.happproxy/files/logs/access/access_log.txt",
    "error": "/data/user/0/com.happproxy/files/logs/error/1794141437639_error_log.txt"
  }
}
