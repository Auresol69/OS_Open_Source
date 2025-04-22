#!/bin/bash

while true; do
  echo "Hãy lựa chọn:"
  echo "1. Kiểm tra sự tồn tại của user."
  echo "2. Tạo mới user."
  echo "3. Xóa user."
  echo "4. Đổi password của user."
  echo "5. Kiểm tra user thuộc group nào."
  echo "6. Tạo group mới."
  echo "7. Add user vào group."
  echo "8. Xóa group."
  echo "9. Phân quyền tập tin cho user."
  echo "10. Thoát."

  read -p "Nhập lựa chọn: " opt

  case $opt in
    1)
      read -p "Nhập tên user: " usr
      if id "$usr" &>/dev/null; then
        echo "User $usr tồn tại."
      else
        echo "User $usr không tồn tại."
      fi ;;
    2)
      read -p "Nhập tên user: " usr
      read -s -p "Nhập mật khẩu: " pass
      echo
      if sudo useradd "$usr" && echo "$usr:$pass" | sudo chpasswd; then
        echo "Tạo user thành công."
      else
        echo "Lỗi khi tạo user."
      fi ;;
    3)
      read -p "Nhập tên user cần xóa: " usr
      if sudo userdel -r "$usr" 2>/dev/null; then
        echo "Xóa user thành công."
      else
        echo "Lỗi: Không thể xóa user."
      fi ;;
    4)
      read -p "Nhập tên user: " usr
      read -s -p "Nhập mật khẩu mới: " pass
      echo
      if echo "$usr:$pass" | sudo chpasswd; then
        echo "Đổi mật khẩu thành công."
      else
        echo "Lỗi: Không thể đổi mật khẩu."
      fi ;;
    5)
      read -p "Nhập tên user: " usr
      if id "$usr" &>/dev/null; then
        groups "$usr"
      else
        echo "User không tồn tại."
      fi ;;
    6)
      read -p "Nhập tên group: " grp
      if sudo groupadd "$grp" 2>/dev/null; then
        echo "Tạo group thành công."
      else
        echo "Lỗi: Không thể tạo group."
      fi ;;
    7)
      read -p "Nhập tên group: " grp
      read -p "Nhập tên user: " usr
      if sudo usermod -aG "$grp" "$usr" 2>/dev/null; then
        echo "Thêm user vào group thành công."
      else
        echo "Lỗi: Không thể thêm user vào group."
      fi ;;
    8)
      read -p "Nhập tên group cần xóa: " grp
      if sudo groupdel "$grp" 2>/dev/null; then
        echo "Xóa group thành công."
      else
        echo "Lỗi: Không thể xóa group."
      fi ;;
    9)
      read -p "Nhập đường dẫn file: " filepath
      read -p "Nhập tên user: " usr
      read -p "Nhập quyền (r, w, x): " perms
      if sudo setfacl -m u:$usr:$perms "$filepath" 2>/dev/null; then
        echo "Phân quyền thành công."
      else
        echo "Lỗi: Không thể phân quyền."
      fi ;;
    10) echo "Tạm biệt!"; break ;;
    *) echo "Lựa chọn không hợp lệ." ;;
  esac

  echo ""
done
