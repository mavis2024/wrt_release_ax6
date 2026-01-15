# Acknowledge
 thanks https://github.com/ZqinKing/wrt_release to provide the template. 
 this resopsitory is self usage to build ax6 openwrt image
# AX6 UBOOT Resources
1. stack layout : https://drive.wrt.moe/uboot/qualcommax
2. uboot layout :  https://pan.baidu.com/s/1341uqxZab8om_YL9UEJpAA?pwd=2333 from https://steemit.com/cn/@ety001/redmi-ax6
3. hybrid layout : https://pan.baidu.com/s/1yMrbuHVzy0mXUxVio7kjqA?pwd=whd7 from https://www.youtube.com/watch?v=UbUKgF2BzVY
   
# 编译指南

## 1. 环境准备

首先安装 Linux 系统，推荐 Ubuntu LTS。

## 2. 安装编译依赖

```bash
sudo apt -y update
sudo apt -y full-upgrade
sudo apt install -y dos2unix libfuse-dev
sudo bash -c 'bash <(curl -sL https://build-scripts.immortalwrt.org/init_build_environment.sh)'
```

## 3. 使用步骤

1.  克隆仓库：
    ```bash
    git clone https://github.com/ZqinKing/wrt_release.git
    ```
2.  进入目录：
    ```bash
    cd wrt_relese
    ```

## 4. 编译固件

使用 `./build.sh` 脚本进行编译，支持以下设备：



### 红米


*   **AX6**:
    ```bash
    ./build.sh redmi_ax6_immwrt
    ```


---

## 5. 三方插件

三方插件源自：[https://github.com/kenzok8/small-package.git](https://github.com/kenzok8/small-package.git)

## 6. OAF（应用过滤）功能使用说明

使用 OAF（应用过滤）功能前，需先完成以下操作：

1.  打开系统设置 → 启动项 → 定位到「appfilter」
2.  将「appfilter」当前状态**从已禁用更改为已启用**
3.  完成配置后，点击**启动**按钮激活服务
