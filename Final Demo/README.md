# 📌 GEM5 + NVMAIN 設置與測試

本專案的目標是通過 **GEM5** + **NVMAIN** 建立並測試最後一層快取（Last Level Cache, LLC），並分析不同配置對效能的影響。

---

## 🔹 目標與進度

- ✅ **GEM5 + NVMAIN 環境建置** （40%）
- ✅ **啟用 L3 最後一層快取於 GEM5 + NVMAIN** （15%）
- ✅ **設定 LLC 為 2-way 及 full-way 連結快取，並測試效能** （15%）
- ✅ **修改 LLC 置換策略為 RRIP（Re-Reference Interval Prediction）** （15%）
- ✅ **測試 Write-Back 和 Write-Through 策略在 4-way 連結快取（associative cache）與 `isscc_pcm` 上的效能** （15%）

---

## 🎯 **（Bonus 20%）**
- 🎯 **設計新的 LLC 置換策略，以降低 PCM 為主記憶體的能耗**
- 🎯 **Baseline: LRU（最近最少使用策略）**


