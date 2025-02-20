# **期末 Demo Project**

本專案的目標是基於 **GEM5 + NVMAIN** 進行 **cache memory** 的配置與優化，包含 L3 Cache 啟用、替換策略調整，以及寫回/寫穿策略效能測試。

## **📌 Q1. GEM5 + NVMAIN BUILD-UP (40%)**
- 由於虛擬機運行時間較長，因此直接安裝雙系統來執行。
- 透過 **Hello World 測試** 來檢查是否能夠存取 **L2 cache**。

---

## **📌 Q2. 啟用 L3 Cache in GEM5 + NVMAIN (15%)**
### **1️⃣ 修改 Cache 參數**
- 在 `./config/common/Caches.py` 新增 **L3 Cache Class**（參數可參照 L2）。

### **2️⃣ 設置 L3 Cache 連接**
- 在 `./config/common/CacheConfig.py` 設定 **L3 Cache 連接方式**。

### **3️⃣ 確保 L2 → L3 存取**
- 在 `./config/common/CacheConfig.py` 設定 L2 必須先經過 L3。

### **4️⃣ 設置 L3 XBar**
- 在 `./src/mem/XBar.py` 設置 L3 的 **crossbar 連線**。

### **5️⃣ 在 CPU 內導入 L3**
- 修改 `./src/cpu/BaseCPU.py`，**import 並 define L3 cache**（依照 L2）。

### **6️⃣ 更新 Options**
- 在 `./configs/common/Options.py` **新增 L3 cache 啟用參數**。

### **7️⃣ 重新編譯 GEM5**
```sh
scons build/X86/gem5.opt -j$(nproc)
```

### **8️⃣ 執行測試**
```sh
./build/X86/gem5.opt --l2cache --l3cache
```
- 觀察 L3 Cache 是否正確被存取。

---

## **📌 Q3. 配置 L3 Cache 的 2-way 與 Fully Associative 並測試效能 (15%)**
### **1️⃣ 準備 Benchmark**
這次的 Benchmark 使用 Quicksort.c，因此需要在 Ubuntu 內安裝 GCC 編譯器，並透過以下指令編譯程式：
```sh
# 編譯測試程式
gcc --static quicksort.c -o quicksort
gcc --static multiply.c -o multiply

# 放入 tests/ 資料夾
mv quicksort tests/
mv multiply tests/
```

### **2️⃣ 設置 2-way Cache 並執行**
可透過指令直接操作 2-way Cache，並設置 benchmark 內的 Cache Size
（或可修改 option.py 內的 default 設定）。

執行 2-way Cache：
```sh
./build/X86/gem5.opt --l3cache --l3_size=1MB --l3_assoc=2
```
-以下為 2-way Cache 下的 L3 Miss Rate：
（請填入觀察到的數據）

-程式執行時的過程：
（請填入執行過程的輸出內容）

### **測試 Fully Associative**
在 benchmark 中設置 L3 Size = 1MB，
而在 GEM5 中 block size 預設為 64B，則：
因此2^20/2^6=2^14=16384
因此指令修改為：
```sh
./build/X86/gem5.opt --l3cache --l3_size=1MB --l3_assoc=16384
```
-以下為 Fully Associative Cache 下的 L3 Miss Rate：Miss Rate 反而 上升 了。
（請填入觀察到的數據）

-程式執行時的過程：

---

## **📌 Q4. Modify Last Level Cache Policy Based on RRIP (15%)**
### **1️⃣ 查看 GEM5 內建策略**
在 ReplacementPolicies.py 中，可以找到 GEM5 提供的內建 policy，
例如 LRU、FIFO 等策略：

### **2️⃣ 替換 LRU 為 RRIP**
在 build/X86/mem/cache/cache.py 中，將 LRU 改為 BRRIPRP：

```python
from gem5.replacement_policies import BRRIPRP
cache.replacement_policy = BRRIPRP()
```

### **3️⃣ 重新編譯**
```sh
scons build/X86/gem5.opt -j$(nproc)
```

### **4️⃣ 測試 RRIP 效果**
-以下為 RRIP 實作後的結果：
相較於 LRU，Miss Rate 有所下降：

（請填入觀察到的數據）

-Miss Rate 約下降 0.01%，與 2-way LRU 相比有所改善。

---

## **📌 Q5. Test the Performance of Write Back and Write Through Policy Based on 4-way Associative Cache with isscc_pcm (15%)**

### **1️⃣ 預設為 Write Back**
因為 default 預設即為 Write Back，
所以可直接執行以下指令：
```sh
./build/X86/gem5.opt --l3cache --l3_assoc=4
```

### **2️⃣ 觀察 L3 Cache Miss Rate**
-以下為 L3 Cache Miss Rate：
（請填入觀察到的數據）

-以下為程式執行時的過程：
（請填入執行過程的輸出內容）
