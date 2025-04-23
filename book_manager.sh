#!/bin/bash

BOOK_DIR="Book"
NEW_BOOK_DIR="NewBook"
LIST_FILE="ListBook"

khoi_tao_data() {
        echo "Dang khoi tao data..."
        mkdir -p "$BOOK_DIR"

        wget -O books.tar "https://drive.google.com/uc?export=download&id=1hLIglN-ctAFaV4-5eviIx7aZHdhZBHok"
        tar -xf books.tar -C "$BOOK_DIR"
        echo "Khoi tao data thanh cong."
}

liet_ke_sach(){
        echo "Liet ke sach vao $LIST_FILE..."
        > "$LIST_FILE"
        i=1
        for file in "$BOOK_DIR"/*;do
                filename=$(basename "$file")
                timestamp=$(date +"%d/%m/%Y %H:%M:%S")
                echo "$i $filename $timestamp" >> "$LIST_FILE"
                ((i++))
        done
        echo "Da cap nhat danh sach vao $LIST_FILE"
}

them_sach_moi() {
    echo "Nhap thong tin sach (Ten_TacGia_NhaXB_Nam):"
    read thongtin
    if grep -q "$thongtin" "$BOOK_DIR"/* 2>/dev/null; then
        echo "Cac sach tuong tu:"
        grep "$thongtin" "$BOOK_DIR"/*
    else
        echo "Chua co sach nay trong du lieu."
    fi
}

cap_nhat_sach_moi() {
    mkdir -p "$NEW_BOOK_DIR"
    echo "Dang kiem tra sach moi trong $NEW_BOOK_DIR..."
    for file in "$NEW_BOOK_DIR"/*; do
        basefile=$(basename "$file")
        if [ -f "$BOOK_DIR/$basefile" ]; then
            echo "Da co quyen sach $basefile, khong can cap nhat."
        else
            cp "$file" "$BOOK_DIR/"
            timestamp=$(date +"%d/%m/%Y %H:%M:%S")
            count=$(($(wc -l < "$LIST_FILE") + 1))
            echo "$count. $basefile - cap nhat luc $timestamp" >> "$LIST_FILE"
            echo "Da chep sach $basefile va thanh cong."
        fi
    done
}

thong_ke_so_sach() {
    count=$(ls "$BOOK_DIR" | wc -l)
    echo "Co tat ca $count quyen sach hien nay."
}

tim_kiem_ten_sach() {
    echo "Nhap ten sach can tim:"
    read keyword
    found=0
    for file in "$BOOK_DIR"/*; do
        name=$(basename "$file")
        if [[ "$name" == *"$keyword"* ]]; then
            echo "$name"
            found=1
        fi
    done
    if [ $found -eq 0 ]; then
        echo "Khong tim thay sach nao."
    fi
}

thong_ke_nam_xuat_ban() {
    echo "Nhap nam xuat ban can thong ke:"
    read year
    count=0
    echo "Cac sach xuat ban nam $year:"
    for file in "$BOOK_DIR"/*; do
        name=$(basename "$file")
        if [[ "$name" == *"_"$year ]]; then
            echo "$name"
            ((count++))
        fi
    done
    echo "Tong cong co $count quyen sach xuat ban nam $year"
}

while true; do
  echo "Chon so 1 de khoi tao du lieu Sach"
  echo "Chon so 2 de liet ke danh muc Sach"
  echo "Chon so 3 de kiem tra Sach co san"
  echo "Chon so 4 de Them Sach moi"
  echo "Chon so 5 de Thong ke so luong Sach"
  echo "Chon so 6 de truy van ten sach"
  echo "Chon so 7 de truy van so luong Sach duoc xuat ban trong nam"
  echo "Chon so 8 de Thoat"

  read -p "Moi chon: " choice

case $choice in
        1) khoi_tao_du_lieu ;;
        2) liet_ke_sach ;;
        3) them_sach_moi ;;
        4) cap_nhat_sach_moi ;;
        5) thong_ke_so_sach ;;
        6) tim_kiem_ten_sach ;;
        7) thong_ke_nam_xuat_ban ;;
        8) echo "Thoat."; exit ;;
        *) echo "Lua chon khong hop le." ;;
esac

  echo ""
done
