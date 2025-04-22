#!/bin/bash

while true; do
  echo "Hãy lựa chọn:"
  echo "1. Hiển thị thư mục hiện hành."
  echo "2. Chuyển đến thư mục mới."
  echo "3. Tạo thư mục mới."
  echo "4. Đổi tên thư mục."
  echo "5. Xóa thư mục."
  echo "6. Liệt kê thư mục và tập tin trong thư mục hiện hành."
  echo "7. Tạo file mới."
  echo "8. Đổi tên file."
  echo "9. Xóa file."
  echo "10. Xem nội dung file."
  echo "11. Cập nhật nội dung file."
  echo "12. Di chuyển file."
  echo "13. Copy file."
  echo "14. Thoát."

  read -p "Nhập lựa chọn: " choice

  case $choice in
    1) pwd ;;
    2) 
       read -p "Nhập đường dẫn thư mục mới: " path
       if cd "$path" 2>/dev/null; then
         echo "Chuyển đến $path thành công."
       else
         echo "Lỗi: Không thể chuyển đến $path."
       fi ;;
    3)
       read -p "Nhập tên thư mục cần tạo: " newdir
       if mkdir "$newdir" 2>/dev/null; then
         echo "Tạo thư mục thành công."
       else
         echo "Lỗi: Không thể tạo thư mục."
       fi ;;
    4)
       read -p "Nhập tên thư mục cần đổi: " old
       read -p "Nhập tên mới: " new
       if mv "$old" "$new" 2>/dev/null; then
         echo "Đổi tên thành công."
       else
         echo "Lỗi: Đổi tên thất bại."
       fi ;;
    5)
       read -p "Nhập tên thư mục cần xóa: " dir
       if rm -r "$dir" 2>/dev/null; then
         echo "Xóa thư mục thành công."
       else
         echo "Lỗi: Không thể xóa thư mục."
       fi ;;
    6) ls -al ;;
    7)
       read -p "Nhập tên file cần tạo: " filename
       if touch "$filename" 2>/dev/null; then
         echo "Tạo file thành công."
       else
         echo "Lỗi: Không thể tạo file."
       fi ;;
    8)
       read -p "Nhập tên file cần đổi: " oldfile
       read -p "Nhập tên file mới: " newfile
       if mv "$oldfile" "$newfile" 2>/dev/null; then
         echo "Đổi tên file thành công."
       else
         echo "Lỗi: Không thể đổi tên file."
       fi ;;
    9)
       read -p "Nhập tên file cần xóa: " filedel
       if rm "$filedel" 2>/dev/null; then
         echo "Xóa file thành công."
       else
         echo "Lỗi: Không thể xóa file."
       fi ;;
    10)
        read -p "Nhập tên file cần xem: " fileview
        if cat "$fileview" 2>/dev/null; then
          echo "--- Kết thúc nội dung ---"
        else
          echo "Lỗi: Không thể xem nội dung file."
        fi ;;
    11)
        read -p "Nhập tên file cần cập nhật: " fileedit
        if [ -f "$fileedit" ]; then
          read -p "Nhập nội dung thêm vào file: " content
          echo "$content" >> "$fileedit"
          echo "Cập nhật nội dung thành công."
        else
          echo "Lỗi: File không tồn tại."
        fi ;;
    12)
        read -p "Nhập tên file cần di chuyển: " filemv
        read -p "Nhập đường dẫn đích: " dest
        if mv "$filemv" "$dest" 2>/dev/null; then
          echo "Di chuyển file thành công."
        else
          echo "Lỗi: Không thể di chuyển file."
        fi ;;
    13)
        read -p "Nhập tên file cần copy: " filecp
        read -p "Nhập đường dẫn đích hoặc tên mới: " destcp
        if cp "$filecp" "$destcp" 2>/dev/null; then
          echo "Copy file thành công."
        else
          echo "Lỗi: Không thể copy file."
        fi ;;
    14) echo "Tạm biệt!"; break ;;
    *) echo "Lựa chọn không hợp lệ." ;;
  esac

  echo ""
done
