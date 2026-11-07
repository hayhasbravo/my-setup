#!/usr/bin/env bash
# note.sh — catatan harian / jurnal kecil.
# Pakai:
#   bash scripts/note.sh add "teks"   # tambah catatan hari ini
#   bash scripts/note.sh list         # lihat semua catatan
#   bash scripts/note.sh today        # lihat catatan hari ini
set -euo pipefail
NOTE_DIR="${HOME}/notes"
mkdir -p "$NOTE_DIR"

today() {
  date +"%F"
}

add() {
  local text="$1"
  [ -z "$text" ] && { echo "Hati-hati: teks kosong."; exit 1; }
  echo "[$(today)] $text" >> "$NOTE_DIR/notes.md"
  echo "✓ Ditambahkan: [$today] $text"
}

list() {
  if [[ -f "$NOTE_DIR/notes.md" ]]; then
    echo "=== Catatan ==="
    cat "$NOTE_DIR/notes.md"
  else
    echo "(belum ada catatan)"
  fi
}

today_note() {
  grep "^\[$today\]" "$NOTE_DIR/notes.md" 2>/dev/null || echo "(tidak ada catatan hari ini)"
}

case "${1:-help}" in
  add)   shift; add "$*" ;;
  list)  list ;;
  today) today_note ;;
  help|-h|--help)
    echo "Gunakan: bash scripts/note.sh <add|list|today>"
    echo "  add \"teks\"  -> tambah catatan hari ini"
    echo "  list        -> tampilkan semua catatan"
    echo "  today       -> catatan hari ini"
    ;;
  *)
    echo "Perintah tidak diketahui: $1"
    echo "Gunakan: bash scripts/note.sh <add|list|today>"
    ;;
esac
