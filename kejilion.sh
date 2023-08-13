#!/bin/bash
while true; do
clear


echo -e "\033[96m"
echo "_  _ ____  _ _ _    _ ____ _  _ "
echo "|_/  |___  | | |    | |  | |\ | "
echo "| \_ |___ _| | |___ | |__| | \| "
echo "                                "
echo -e "\033[96m科技lion一键脚本工具 v1.0.2 （该脚本仅支持Ubuntu和Debian系统）\033[0m"
echo "1. 系统信息查询"
echo "2. 系统更新"
echo "3. 系统清理"
echo "4. 常用工具安装 ▶"
echo "5. BBR管理 ▶"
echo "6. Docker管理 ▶ "
echo "7. WARP管理 ▶ 解锁ChatGPT Netflix"
echo "8. 测试脚本合集 ▶ "
echo "9. 甲骨文云脚本合集 ▶ "
echo -e "\033[33m10. LDNMP建站 ▶ \033[0m"
echo "------------------------"
echo "0. 退出脚本"      
echo "------------------------"
read -p "请输入你的选择: " choice

case $choice in
  1)
  clear
  
  # 获取当前系统及版本号
  os_info=$(lsb_release -a 2>/dev/null | grep 'Description' | awk -F ':\t' '{print $2}')
  
  # 获取CPU信息
  if [ "$(uname -m)" == "x86_64" ]; then
    cpu_info=$(cat /proc/cpuinfo | grep 'model name' | uniq | sed -e 's/model name[[:space:]]*: //')
  else
    cpu_info=$(lscpu | grep 'Model name' | sed -e 's/Model name[[:space:]]*: //')
  fi
  
  # 获取CPU占用量（包括百分比）
  cpu_usage=$(top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}')
  cpu_usage_percent=$(printf "%.2f" $cpu_usage)%
  
  # 获取CPU核心数
  cpu_cores=$(nproc)
  
  # 获取内存信息
  mem_info=$(free -b | awk 'NR==2{printf "%.2f/%.2f MB (%.2f%%)", $3/1024/1024, $2/1024/1024, $3*100/$2}')
  
  # 获取硬盘信息
  disk_info=$(df -h | awk '$NF=="/"{printf "%d/%dGB (%s)", $3,$2,$5}')
  
  # 获取公网IPv4和IPv6地址
  ipv4_address=$(curl -s4 ifconfig.co)
  ipv6_address=$(curl -s6 ifconfig.co)
  
  # 获取运营商名称
  isp_info=$(curl -s ipinfo.io/org | sed -e 's/^[ \t]*//' | sed -e 's/\"//g')
  
  # 获取CPU架构信息
  cpu_arch=$(uname -m)
  
  # 获取主机名
  hostname=$(hostname)
  
  # 打印服务器信息，包括主机名
  echo ""
  echo "主机名: $hostname"
  echo "运营商: $isp_info"
  echo "系统信息: $os_info"
  echo "CPU架构: $cpu_arch"
  echo "CPU信息: $cpu_info"
  echo "CPU核心数: $cpu_cores"
  echo "CPU占用: $cpu_usage_percent"
  echo "内存占用: $mem_info"
  echo "硬盘占用: $disk_info"
  echo "公网IPv4地址: $ipv4_address"
  echo "公网IPv6地址: $ipv6_address"
  echo
  
  
    ;;

  2)
    clear
    DEBIAN_FRONTEND=noninteractive apt update -y && DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
    ;;

  3)
    clear  
    apt autoremove --purge -y && apt clean -y && apt autoclean -y && apt remove --purge $(dpkg -l | awk '/^rc/ {print $2}') -y && journalctl --rotate && journalctl --vacuum-time=1s && journalctl --vacuum-size=50M && apt remove --purge $(dpkg -l | awk '/^ii linux-(image|headers)-[^ ]+/{print $2}' | grep -v $(uname -r | sed 's/-.*//') | xargs) -y
    ;;
  4)
     while true; do
      echo " ▼ "
      echo "安装常用工具"  
      echo "1. curl 下载工具"
      echo "2. wget 下载工具"
      echo "3. sudo 超级管理权限工具"
      echo "4. socat 通信连接工具 （申请域名证书必备）"
      echo "5. htop 系统监控工具"
      echo "6. iftop 网络流量监控工具"      
      echo "7. unzip ZIP压缩解压工具z"
      echo "8. tar GZ压缩解压工具"
      echo "9. tmux 多路后台运行工具"
      echo "10. ffmpeg 视频编码直播推流工具"
      echo "------------------------"
      echo "31. 全部安装"    
      echo "32. 全部卸载"            
      echo "------------------------"
      echo "0. 返回主菜单"      
      echo "------------------------"
      read -p "请输入你的选择: " sub_choice
    
      case $sub_choice in
          1)
              clear
              apt update -y && apt install -y curl
              ;;
          2)
              clear
              apt update -y && apt install -y wget
              ;;
          3)
              clear
              apt update -y && apt install -y sudo
              ;;        
          4)
              clear
              apt update -y && apt install -y socat
              ;;        
          5)
              clear
              apt update -y && apt install -y htop
              ;;        
          6)
              clear
              apt update -y && apt install -y iftop
              ;;        
          7)
              clear
              apt update -y && apt install -y unzip
              ;;        
          8)
              clear
              apt update -y && apt install -y tar
              ;;        
          9)
              clear
              apt update -y && apt install -y tmux
              ;;        
          10)
              clear
              apt update -y && apt install -y ffmpeg
              ;;        

          31)
              clear
              apt update -y && apt install -y curl wget sudo socat htop iftop unzip tar tmux ffmpeg
              ;;        
          32)
              clear
              apt remove curl wget htop iftop unzip tmux ffmpeg
              ;;     
          0)
              ./kejilion.sh
              exit
              ;;
          *)
              echo "无效的输入!"
              ;;
      esac
      echo -e "\033[0;32m操作完成\033[0m"
      echo "按任意键继续..."
      read -n 1 -s -r -p ""
      echo ""
      clear
    done
    ;;

  5)
    clear  
    apt update -y && apt install -y wget
    wget --no-check-certificate -O tcpx.sh https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcpx.sh
    chmod +x tcpx.sh
    ./tcpx.sh
    ;;

  6)
    while true; do

      echo " ▼ "
      echo "Docker管理器"  
      echo "1. 安装更新Docker环境"
      echo "------------------------"
      echo "2. 查看Dcoker全局状态"
      echo "------------------------"     
      echo "3. 启动所有Dcoker容器"
      echo "4. 暂停所有Dcoker容器"
      echo "5. 删除所有Dcoker容器"
      echo "6. 清理无用的docker容器和镜像网络数据卷"
      echo "------------------------"
      echo "7. 卸载Dcoker环境"
      echo "------------------------"
      echo "0. 返回主菜单"      
      echo "------------------------"
      read -p "请输入你的选择: " sub_choice
    
      case $sub_choice in
          1)
              clear
              apt update -y
              curl -fsSL https://get.docker.com | sh
              curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
           
              ;;
          2)
              clear
              echo "Dcoker版本"
              docker --version
              docker-compose --version
              echo ""              
              echo "Dcoker镜像列表"
              docker image ls  
              echo ""              
              echo "Dcoker容器列表"
              docker ps -a  
              echo ""              
              echo "Dcoker网络列表"
              docker network ls                
              echo "" 
              ;;
             
          3)
              clear
              docker start $(docker ps -a -q)
              ;;        
          4)
              clear
              docker stop $(docker ps -q)
              ;;        
          5)
              clear
              docker rm $(docker ps -a -q)
              ;;
          6)
              clear
              docker system prune -af --volumes
              ;;        
          7)
              clear
              docker rm $(docker ps -a -q) && docker rmi $(docker images -q) && docker network prune            
              apt-get remove docker -y
              apt-get remove docker-ce -y
              apt-get purge docker-ce -y
              rm -rf /var/lib/docker
              ;;                                    
          0)
              ./kejilion.sh
              exit
              ;;
          *)
              echo "无效的输入!"
              ;;
      esac
      echo -e "\033[0;32m操作完成\033[0m"
      echo "按任意键继续..."
      read -n 1 -s -r -p ""
      echo ""
      clear
         
    done

    ;;


  7)
    clear  
    wget -N https://raw.githubusercontent.com/fscarmen/warp/main/menu.sh && bash menu.sh [option] [lisence]
    ;;


  8)
    while true; do

      echo " ▼ "
      echo "测试脚本合集"  
      echo "1. ChatGPT解锁状态检测"
      echo "2. 流媒体解锁测试"
      echo "3. TikTok状态检测"
      echo "4. 三网回程延迟路由测试"
      echo "5. 三网回程线路测试"
      echo "6. 三网专项测速"
      echo "7. VPS性能专项测试"
      echo "8. VPS性能全局测试"
      echo "------------------------"
      echo "0. 返回主菜单"      
      echo "------------------------"
      read -p "请输入你的选择: " sub_choice
    
      case $sub_choice in
          1)
              clear
              bash <(curl -Ls https://cdn.jsdelivr.net/gh/missuo/OpenAI-Checker/openai.sh)
              ;;
          2)
              clear
              bash <(curl -L -s check.unlock.media)
              ;;
          3)
              clear
              wget -qO- https://github.com/yeahwu/check/raw/main/check.sh | bash
              ;;        
          4)
              clear
              wget -qO- git.io/besttrace | bash
              ;;        
          5)
              clear
              curl https://raw.githubusercontent.com/zhucaidan/mtr_trace/main/mtr_trace.sh | bash
              ;;        
          6)
              clear
              bash <(curl -Lso- https://git.io/superspeed_uxh)
              ;;        
          7)
              clear
              curl -sL yabs.sh | bash -s -- -i -5
              ;;        
          8)
              clear
              wget -qO- bench.sh | bash
              ;;        
          0)
              ./kejilion.sh
              exit
              ;;
          *)
              echo "无效的输入!"
              ;;
      esac
      echo -e "\033[0;32m操作完成\033[0m"
      echo "按任意键继续..."
      read -n 1 -s -r -p ""
      echo ""
      clear
    done
    ;;

  9)  
     while true; do
      echo " ▼ "
      echo "甲骨文云脚本合集"  
      echo "1. 安装闲置机器活跃脚本"
      echo "2. 卸载闲置机器活跃脚本"      
      echo "------------------------"      
      echo "3. DD重装系统脚本"
      echo "4. R探长开机脚本"
      echo "------------------------"
      echo "0. 返回主菜单"      
      echo "------------------------"
      read -p "请输入你的选择: " sub_choice
    
      case $sub_choice in
          1)
              clear
              echo "活跃脚本：CPU占用10-20% 内存占用15% "
              read -p "确定安装吗？(Y/N): " choice
              case "$choice" in
                [Yy])
                  apt update -y
                  apt install -y curl
                  curl -fsSL https://get.docker.com | sh
                  docker run -itd --name=lookbusy --restart=always \
                          -e TZ=Asia/Shanghai \
                          -e CPU_UTIL=10-20 \
                          -e CPU_CORE=1 \
                          -e MEM_UTIL=15 \
                          -e SPEEDTEST_INTERVAL=120 \
                          fogforest/lookbusy
                  ;;
                [Nn])

                  ;;
                *)
                  echo "无效的选择，请输入 Y 或 N。"
                  ;;
              esac      
              ;;
          2)
              clear
              docker rm -f lookbusy 
              docker rmi fogforest/lookbusy
              ;;
          3)
              clear
              echo "请备份数据，将为你重装Debian12，预计花费15分钟。"
              read -p "确定重装吗？(Y/N): " choice
              case "$choice" in
                [Yy])
                  read -p "请输入你重装后的密码：" vpspasswd
                  bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') -d 12 -v 64 -p $vpspasswd -port 22
                  
                  ;;
                [Nn])

                  ;;
                *)
                  echo "无效的选择，请输入 Y 或 N。"
                  ;;
              esac    
              ;;      
          4)
              clear
              echo "该功能处于开发阶段，敬请期待！"  
              ;;                  
          0)
              ./kejilion.sh
              exit
              ;;
          *)
              echo "无效的输入!"
              ;;
      esac
      echo -e "\033[0;32m操作完成\033[0m"
      echo "按任意键继续..."
      read -n 1 -s -r -p ""
      echo ""
      clear
    done
    ;;


  10)

  while true; do  
    echo -e "\033[33m ▼ \033[0m"
    echo -e "\033[33mLDNMP建站\033[0m"
    echo  "1. 安装LDNMP环境"
    echo  "------------------------"
    echo  "2. 安装WordPress"
    echo  "3. 安装Discuz论坛"
    echo  "4. 安装可道云桌面"
    echo  "5. 安装苹果CMS网站"
    echo  "6. 安装独角数发卡网"
    echo  "------------------------"
    echo  "21. 站点重定向"
    echo  "22. 站点反向代理"
    echo  "------------------------"
    echo  "30. 仅申请证书"
    echo  "------------------------"    
    echo  "31. 查看当前站点信息"
    echo  "32. 备份全站数据"
    echo  "33. 还原全站数据"
    echo  "34. 卸载LDNMP环境"
    echo  "------------------------"
    echo  "0. 返回主菜单"          
    echo  "------------------------"    
    read -p "请输入你的选择: " sub_choice

    
    case $sub_choice in
      1)
      clear
      # 获取用户输入，用于替换 docker-compose.yml 文件中的占位符
      read -p "设置数据库ROOT密码：" dbrootpasswd
      read -p "设置数据库用户名：" dbuse
      read -p "设置数据库用户密码：" dbusepasswd
      
      
      # 更新并安装必要的软件包
      DEBIAN_FRONTEND=noninteractive apt update -y
      DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
      apt install -y curl wget sudo socat unzip tar htop
      
      # 安装 Docker
      curl -fsSL https://get.docker.com | sh
      
      # 安装 Docker Compose
      curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
      
      # 创建必要的目录和文件
      cd /home && mkdir -p web/html web/mysql web/certs web/conf.d web/redis && touch web/docker-compose.yml
      
      # 下载 docker-compose.yml 文件并进行替换
      wget -O /home/web/docker-compose.yml https://raw.githubusercontent.com/kejilion/docker/main/LNMP-docker-compose-4.yml
           
      # 在 docker-compose.yml 文件中进行替换
      sed -i "s/webroot/$dbrootpasswd/g" /home/web/docker-compose.yml
      sed -i "s/kejilionYYDS/$dbusepasswd/g" /home/web/docker-compose.yml
      sed -i "s/kejilion/$dbuse/g" /home/web/docker-compose.yml
      
      iptables -P INPUT ACCEPT
      iptables -P FORWARD ACCEPT
      iptables -P OUTPUT ACCEPT
      iptables -F
      
      cd /home/web && docker-compose up -d
      
      docker exec php apt update &&
      docker exec php apt install -y libmariadb-dev-compat libmariadb-dev libzip-dev libmagickwand-dev imagemagick &&
      docker exec php docker-php-ext-install mysqli pdo_mysql zip exif gd intl bcmath opcache &&
      docker exec php pecl install imagick &&
      docker exec php sh -c 'echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini' &&
      docker exec php pecl install redis &&
      docker exec php sh -c 'echo "extension=redis.so" > /usr/local/etc/php/conf.d/docker-php-ext-redis.ini' &&
      docker exec php sh -c 'echo "upload_max_filesize=50M \n post_max_size=50M" > /usr/local/etc/php/conf.d/uploads.ini' &&
      docker exec php sh -c 'echo "memory_limit=256M" > /usr/local/etc/php/conf.d/memory.ini'
      docker exec php sh -c 'echo "max_execution_time=120" > /usr/local/etc/php/conf.d/max_execution_time.ini'
      
      
      docker exec php74 apt update &&
      docker exec php74 apt install -y libmariadb-dev-compat libmariadb-dev libzip-dev libmagickwand-dev imagemagick &&
      docker exec php74 docker-php-ext-install mysqli pdo_mysql zip gd intl bcmath opcache &&
      docker exec php74 pecl install imagick &&
      docker exec php74 sh -c 'echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini' &&
      docker exec php74 pecl install redis &&
      docker exec php74 sh -c 'echo "extension=redis.so" > /usr/local/etc/php/conf.d/docker-php-ext-redis.ini' &&
      docker exec php74 sh -c 'echo "upload_max_filesize=50M \n post_max_size=50M" > /usr/local/etc/php/conf.d/uploads.ini' &&
      docker exec php74 sh -c 'echo "memory_limit=256M" > /usr/local/etc/php/conf.d/memory.ini'
      docker exec php74 sh -c 'echo "max_execution_time=120" > /usr/local/etc/php/conf.d/max_execution_time.ini'
      
        ;;
      2)
      clear
      # wordpress
      read -p "请输入你解析的域名：" yuming
      read -p "设置新数据库名称：" dbname
      
      docker stop nginx
      
      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force
      
      docker start nginx
      
      wget -O /home/web/conf.d/$yuming.conf https://raw.githubusercontent.com/kejilion/nginx/main/wordpress.com.conf
      sed -i "s/yuming.com/$yuming/g" /home/web/conf.d/$yuming.conf
      
      cd /home/web/html
      mkdir $yuming
      cd $yuming
      wget https://cn.wordpress.org/wordpress-6.3-zh_CN.zip
      unzip wordpress-6.3-zh_CN.zip
      rm wordpress-6.3-zh_CN.zip
      
      echo "define('FS_METHOD', 'direct'); define('WP_REDIS_HOST', 'redis'); define('WP_REDIS_PORT', '6379');" >> /home/web/html/$yuming/wordpress/wp-config-sample.php
      
      docker exec nginx chmod -R 777 /var/www/html && docker exec php chmod -R 777 /var/www/html && docker exec php74 chmod -R 777 /var/www/html
            
      dbrootpasswd=$(grep -oP 'MYSQL_ROOT_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbuse=$(grep -oP 'MYSQL_USER:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbusepasswd=$(grep -oP 'MYSQL_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')      
      docker exec mysql mysql -u root -p"$dbrootpasswd" -e "CREATE DATABASE $dbname; GRANT ALL PRIVILEGES ON $dbname.* TO \"$dbuse\"@\"%\";"

      docker restart php && docker restart php74 && docker restart nginx

      clear  
      echo "您的WordPress搭建好了！"
      echo "https://$yuming"
      echo ""  
      echo "WP安装信息如下："  
      echo "数据库名：$dbname"
      echo "用户名：$dbuse"
      echo "密码：$dbusepasswd"
      echo "数据库主机：mysql"  
      echo "表前缀：$dbname"  

        ;;
      3)
      clear
      # Discuz论坛
      read -p "请输入你解析的域名：" yuming
      read -p "设置新数据库名称：" dbname
      
      docker stop nginx
      
      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force
      
      docker start nginx
      
      wget -O /home/web/conf.d/$yuming.conf https://raw.githubusercontent.com/kejilion/nginx/main/discuz.com.conf

      sed -i "s/yuming.com/$yuming/g" /home/web/conf.d/$yuming.conf
      
      cd /home/web/html
      mkdir $yuming
      cd $yuming
      wget https://github.com/kejilion/Website_source_code/raw/main/Discuz_X3.5_SC_UTF8_20230520.zip
      unzip -o Discuz_X3.5_SC_UTF8_20230520.zip
      rm Discuz_X3.5_SC_UTF8_20230520.zip      
            
      docker exec nginx chmod -R 777 /var/www/html && docker exec php chmod -R 777 /var/www/html && docker exec php74 chmod -R 777 /var/www/html      
      
      dbrootpasswd=$(grep -oP 'MYSQL_ROOT_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbuse=$(grep -oP 'MYSQL_USER:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbusepasswd=$(grep -oP 'MYSQL_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')      
      docker exec mysql mysql -u root -p"$dbrootpasswd" -e "CREATE DATABASE $dbname; GRANT ALL PRIVILEGES ON $dbname.* TO \"$dbuse\"@\"%\";"
            
      docker restart php && docker restart php74 && docker restart nginx


      clear     
      echo "您的Discuz论坛搭建好了！"
      echo "https://$yuming"
      echo ""  
      echo "安装信息如下："  
      echo "数据库主机：mysql"  
      echo "数据库名：$dbname"
      echo "用户名：$dbuse"
      echo "密码：$dbusepasswd"
      echo "表前缀：$dbname"  

        ;;

      4)
      clear
      # 可道云桌面
      read -p "请输入你解析的域名：" yuming
      read -p "设置新数据库名称：" dbname
      
      docker stop nginx
      
      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force
      
      docker start nginx
      
      wget -O /home/web/conf.d/$yuming.conf https://raw.githubusercontent.com/kejilion/nginx/main/kdy.com.conf

      sed -i "s/yuming.com/$yuming/g" /home/web/conf.d/$yuming.conf
      
      cd /home/web/html
      mkdir $yuming
      cd $yuming
      wget https://github.com/kalcaddle/kodbox/archive/refs/tags/1.42.04.zip
      unzip -o 1.42.04.zip
      rm 1.42.04.zip
            
      docker exec nginx chmod -R 777 /var/www/html && docker exec php chmod -R 777 /var/www/html && docker exec php74 chmod -R 777 /var/www/html
            
      dbrootpasswd=$(grep -oP 'MYSQL_ROOT_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbuse=$(grep -oP 'MYSQL_USER:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbusepasswd=$(grep -oP 'MYSQL_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')      
      docker exec mysql mysql -u root -p"$dbrootpasswd" -e "CREATE DATABASE $dbname; GRANT ALL PRIVILEGES ON $dbname.* TO \"$dbuse\"@\"%\";"

      docker restart php && docker restart php74 && docker restart nginx


      clear      
      echo "您的可道云桌面搭建好了！"
      echo "https://$yuming"
      echo ""  
      echo "安装信息如下："  
      echo "数据库主机：mysql"  
      echo "用户名：$dbuse"
      echo "密码：$dbusepasswd"
      echo "数据库名：$dbname"

        ;;
      5)
      clear
      echo "该功能处于开发阶段，敬请期待！"  
        ;;   
           
      6)
      clear
      echo "该功能处于开发阶段，敬请期待！"  
        ;;      

      21)
      clear
      read -p "请输入你的域名：" yuming
      read -p "请输入跳转域名：" reverseproxy

      docker stop nginx

      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force

      docker start nginx

      wget -O /home/web/conf.d/$yuming.conf https://raw.githubusercontent.com/kejilion/nginx/main/rewrite.conf
      sed -i "s/yuming.com/$yuming/g" /home/web/conf.d/$yuming.conf
      sed -i "s/baidu.com/$reverseproxy/g" /home/web/conf.d/$yuming.conf

      docker restart php && docker restart php74 && docker restart nginx
      
      clear  
      echo "您的重定向网站做好了！"
      echo "https://$yuming"

        ;;

      22)
      clear
      read -p "请输入你的域名：" yuming
      read -p "请输入你的反代IP：" reverseproxy
      read -p "请输入你的反代端口：" port

      docker stop nginx

      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force

      docker start nginx

      wget -O /home/web/conf.d/$yuming.conf https://raw.githubusercontent.com/kejilion/nginx/main/reverse-proxy.conf
      sed -i "s/yuming.com/$yuming/g" /home/web/conf.d/$yuming.conf
      sed -i "s/0.0.0.0/$reverseproxy/g" /home/web/conf.d/$yuming.conf
      sed -i "s/0000/$port/g" /home/web/conf.d/$yuming.conf

      docker restart php && docker restart php74 && docker restart nginx
      
      clear  
      echo "您的反向代理网站做好了！"
      echo "https://$yuming"

        ;;


    30)
      clear
      read -p "请输入你解析的域名：" yuming
      
      docker stop nginx
      
      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force
      
      docker start nginx

      ;;


    31)
    clear
    ls /home/web/html
      ;;


    32)
      clear
      cd /home/ && tar czvf web_$(date +"%Y%m%d%H%M%S").tar.gz web
    
      while true; do
        clear  
        read -p "要传送文件到远程服务器吗？(Y/N): " choice
        case "$choice" in
          [Yy])
            read -p "请输入远端服务器IP： " remote_ip
            if [ -z "$remote_ip" ]; then
              echo "错误：请输入远端服务器IP。"
              continue
            fi
            latest_tar=$(ls -t /home/*.tar.gz | head -1)
            if [ -n "$latest_tar" ]; then
              scp "$latest_tar" "root@$remote_ip:/home/"
              echo "文件已传送至远程服务器home目录。"
            else
              echo "未找到要传送的文件。"
            fi
            break
            ;;
          [Nn])
            break
            ;;
          *)
            echo "无效的选择，请输入 Y 或 N。"
            ;;
        esac
      done
      ;;

    33)
      clear
      cd /home/ && ls -t /home/*.tar.gz | head -1 | xargs -I {} tar -xzf {}   
      
      cd /home/web && docker-compose up -d      
      
      docker exec php apt update &&
      docker exec php apt install -y libmariadb-dev-compat libmariadb-dev libzip-dev libmagickwand-dev imagemagick &&
      docker exec php docker-php-ext-install mysqli pdo_mysql zip exif gd intl bcmath opcache &&
      docker exec php pecl install imagick &&
      docker exec php sh -c 'echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini' &&
      docker exec php pecl install redis &&
      docker exec php sh -c 'echo "extension=redis.so" > /usr/local/etc/php/conf.d/docker-php-ext-redis.ini' &&
      docker exec php sh -c 'echo "upload_max_filesize=50M \n post_max_size=50M" > /usr/local/etc/php/conf.d/uploads.ini' &&
      docker exec php sh -c 'echo "memory_limit=256M" > /usr/local/etc/php/conf.d/memory.ini'
      
      
      docker exec php74 apt update &&
      docker exec php74 apt install -y libmariadb-dev-compat libmariadb-dev libzip-dev libmagickwand-dev imagemagick &&
      docker exec php74 docker-php-ext-install mysqli pdo_mysql zip gd intl bcmath opcache &&
      docker exec php74 pecl install imagick &&
      docker exec php74 sh -c 'echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini' &&
      docker exec php74 pecl install redis &&
      docker exec php74 sh -c 'echo "extension=redis.so" > /usr/local/etc/php/conf.d/docker-php-ext-redis.ini' &&
      docker exec php74 sh -c 'echo "upload_max_filesize=50M \n post_max_size=50M" > /usr/local/etc/php/conf.d/uploads.ini' &&
      docker exec php74 sh -c 'echo "memory_limit=256M" > /usr/local/etc/php/conf.d/memory.ini'

      docker exec nginx chmod -R 777 /var/www/html && docker exec php chmod -R 777 /var/www/html && docker exec php74 chmod -R 777 /var/www/html
      docker restart php && docker restart php74 && docker restart nginx
     
      ;;


    34)
        clear
        read -p "确定删除所有网站数据吗？(Y/N): " choice
        case "$choice" in
          [Yy])
            docker rm -f nginx
            docker rm -f php
            docker rm -f php74
            docker rm -f mysql
            docker rm -f redis
            docker system prune -af --volumes
            rm -r /home/web
            ;;
          [Nn])
          
            ;;
          *)
            echo "无效的选择，请输入 Y 或 N。"
            ;;
        esac    
        ;;

    0)
    ./kejilion.sh
    exit
      ;;

    *)
        echo "无效的输入!"
        exit 1
    esac
  
    echo -e "\033[0;32m操作完成\033[0m"
    echo "按任意键继续..."
    read -n 1 -s -r -p ""
    echo ""
    clear    
  done      
      ;;

  0)
    clear
    exit
    ;;

  *)
    echo "无效的输入!"

esac
  echo -e "\033[0;32m操作完成\033[0m"
  echo "按任意键继续..."
  read -n 1 -s -r -p ""
  echo ""
  clear
done