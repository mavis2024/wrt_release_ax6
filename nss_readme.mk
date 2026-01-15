To get the most out of NSS (Network Subsystem) on your Redmi AX6 with the `ZqinKing` (ImmortalWrt) build, you need to ensure both **Build-time** and **Runtime** settings are correctly configured. NSS is not a "set and forget" feature; it actually replaces the standard OpenWrt offloading methods.

---

### 1. Build-time: Essential `.config` Settings

When you modify your `redmi_ax6_immwrt.config`, ensure the following packages are selected (`=y`). These are the "Big Three" for NSS functionality:

* **`kmod-qca-nss-drv`**: The core driver that talks to the hardware.
* **`kmod-qca-nss-ecm`**: The Enhanced Connection Manager. This is the "brain" that decides which traffic goes to the hardware (NSS) and which stays in the CPU.
* **`kmod-qca-nss-dp`**: The Data Plane driver for handling the physical ethernet ports.

**Recommended "Quality of Life" NSS packages:**

```bash
CONFIG_PACKAGE_kmod-qca-nss-drv-qdisc=y   # For hardware-accelerated SQM/QoS
CONFIG_PACKAGE_nss-utils=y                 # Allows you to use 'nss_top' to see CPU load

```

---

### 2. Runtime: The "Golden Rule" of NSS

The most common mistake is enabling standard OpenWrt offloading while NSS is running. They will fight for the same traffic, leading to crashes or the `(ionclean)` CPU spikes you saw before.

#### **Step A: Disable standard offloading**

Once flashed, go to **Network -> Firewall -> Routing/NAT Offloading** in LuCI:

* **Software flow offloading:** ❌ **Uncheck**
* **Hardware flow offloading:** ❌ **Uncheck**

> [!IMPORTANT]
> NSS *is* your hardware offloading. Enabling the standard "Hardware flow offloading" checkbox tells the Linux kernel to use a different (non-NSS) method which will conflict.

#### **Step B: Disable Packet Steering**

Go to **Network -> Interfaces -> Global network options**:

* **Packet Steering:** ❌ **Uncheck / Disable**
* *Rationale:* NSS handles packet distribution itself. Letting the CPU try to "steer" packets can actually slow down the hardware engine.

---

### 3. How to verify it is working

After applying settings and rebooting, run these commands via SSH:

1. **Check if ECM (Connection Manager) is loaded:**
```bash
lsmod | grep ecm

```


2. **Monitor NSS Load (Live):**
If you included `nss-utils`, run:
```bash
nss_top

```


*If you see numbers moving in the rows while running a speed test, NSS is successfully handling your traffic!*

---

### Summary Checklist for your Config

| Setting | Status | Why? |
| --- | --- | --- |
| **NSS ECM Driver** | **Enabled** | Required for all offloading. |
| **Software Flow Offloading** | **Disabled** | Conflicts with NSS path. |
| **Hardware Flow Offloading** | **Disabled** | Uses standard Linux path, not NSS. |
| **Packet Steering** | **Disabled** | Causes overhead/instability with NSS. |

**Would you like me to check your `redmi_ax6_immwrt.config` file if you paste the "Offloading" section here?**
