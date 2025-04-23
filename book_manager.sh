#!/bin/bash

BOOK_DIR="Book"
NEW_BOOK_DIR="NewBook"
LIST_FILE="ListBook"

# Hàm 1: Khởi tạo dữ liệu từ file tar
khoi_tao_du_lieu() {
    echo "Đang khởi tạo dữ liệu..."
    mkdir -p "$BOOK_DIR"
    # Tải file (sử dụng link giả định tải sẵn)
    wget -O books.tar "https://drive.google.com/uc?export=download&id=1hLIglN-ctAFaV4-5eviIx7aZHdhZBHok"
    tar -xf books.tar -C "$BOOK_DIR"
    echo "Khởi tạo dữ liệu thành công."
}

# Hàm 2: Liệt kê sách ra file ListBook
liet_ke_sach() {
    echo "Liệt kê sách vào $LIST_FILE..."
    > "$LIST_FILE"
    i=1
    for file in "$BOOK_DIR"/*; do
        filename=$(basename "$file")
        timestamp=$(date +"%d/%m/%Y %H:%M:%S")
        echo "$i. $filename - cập nhật lúc $timestamp" >> "$LIST_FILE"
        ((i++))
    done
    echo "Đã cập nhật danh sách vào $LIST_FILE"
}

# Hàm 3: Thêm sách mới và kiểm tra trùng
them_sach_moi() {
    echo "Nhập thông tin sách (Tên_TácGiả_NhàXB_Năm):"
    read thongtin
    if grep -q "$thongtin" "$BOOK_DIR"/* 2>/dev/null; then
        echo "Các sách tương tự:"
        grep "$thongtin" "$BOOK_DIR"/*
    else
        echo "Không có sách nào như thế."
    fi
}

# Hàm 4: Cập nhật sách từ thư mục NewBook
cap_nhat_sach_moi() {
    mkdir -p "$NEW_BOOK_DIR"
    echo "Đang kiểm tra sách mới trong $NEW_BOOK_DIR..."
    for file in "$NEW_BOOK_DIR"/*; do
        basefile=$(basename "$file")
        if [ -f "$BOOK_DIR/$basefile" ]; then
            echo "Sách $basefile đã tồn tại, không cập nhật."
        else
            cp "$file" "$BOOK_DIR/"
            timestamp=$(date +"%d/%m/%Y %H:%M:%S")
            count=$(($(wc -l < "$LIST_FILE") + 1))
            echo "$count. $basefile - cập nhật lúc $timestamp" >> "$LIST_FILE"
            echo "Đã thêm sách $basefile."
        fi
    done
}

# Hàm 5: Thống kê tổng số sách
thong_ke_so_sach() {
    count=$(ls "$BOOK_DIR" | wc -l)
    echo "Tổng số sách hiện có: $count"
}

# Hàm 6: Tìm kiếm sách theo tên
tim_kiem_ten_sach() {
    echo "Nhập tên sách cần tìm:"
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
        echo "Không tìm thấy sách nào."
    fi
}

# Hàm 7: Thống kê theo năm xuất bản
thong_ke_nam_xuat_ban() {
    echo "Nhập năm xuất bản cần thống kê:"
    read year
    count=0
    echo "Các sách xuất bản năm $year:"
    for file in "$BOOK_DIR"/*; do
        name=$(basename "$file")
        if [[ "$name" == *"_"$year ]]; then
            echo "$name"
            ((count++))
        fi
    done
    echo "Tổng cộng có $count quyển sách xuất bản năm $year"
}

# Menu chính
while true; do
    echo "----- MENU QUẢN LÝ SÁCH -----"
    echo "1. Khởi tạo dữ liệu"
    echo "2. Liệt kê danh sách sách"
    echo "3. Thêm sách mới (kiểm tra trùng)"
    echo "4. Cập nhật sách mới từ NewBook"
    echo "5. Thống kê tổng số sách"
    echo "6. Tìm kiếm sách theo tên"
    echo "7. Thống kê sách theo năm xuất bản"
    echo "8. Thoát chương trình"
    echo "----------------------------"
    read -p "Nhập lựa chọn của bạn: " choice

    case $choice in
        1) khoi_tao_du_lieu ;;
        2) liet_ke_sach ;;
        3) them_sach_moi ;;
        4) cap_nhat_sach_moi ;;
        5) thong_ke_so_sach ;;
        6) tim_kiem_ten_sach ;;
        7) thong_ke_nam_xuat_ban ;;
        8) echo "Thoát."; exit ;;
        *) echo "Lựa chọn không hợp lệ." ;;
    esac

    echo ""
done
