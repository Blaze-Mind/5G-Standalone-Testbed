# 5G Standalone (SA) Testbed on WSL

A fully functional, end-to-end 5G Standalone cellular network simulation built on Windows Subsystem for Linux (WSL). This project utilizes **Open5GS** for the 5G Core Network and **UERANSIM** for the Radio Access Network (gNB and UE), providing a complete data pipeline from a simulated smartphone to the public internet.

## Architecture
* **Core Network (5GC):** Open5GS (AMF, SMF, UPF, AUSF, UDM, UDR, NRF, PCF)
* **Radio Access Network (RAN):** UERANSIM (gNB and UE)
* **Routing:** Custom `iptables` NAT pipeline to bridge the 5G GTP-U tunnel out to the WSL host interface (`eth0`).
* **Isolation:** The simulated UE is deployed in a dedicated Linux network namespace to prevent kernel routing loops against the core network UPF.

## Prerequisites
* Ubuntu 20.04/22.04 on WSL2
* Open5GS installed and running
* UERANSIM v3.3.0 compiled

## Usage Instructions

**1. Apply Routing Rules**
Because WSL resets routing tables on reboot, apply the firewall pipeline first:
```bash
chmod +x setup_routing.sh
./setup_routing.sh