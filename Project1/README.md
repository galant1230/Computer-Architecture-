# 🏆 MIPS 最大公因數（GCD）計算程式

本程式使用 **MIPS Assembly** **實作歐幾里得演算法（Euclidean Algorithm）**，計算兩個數的 **最大公因數（GCD）**。

## 📌 **程式功能**
1️⃣ **提示使用者輸入兩個整數**  
2️⃣ **使用歐幾里得演算法計算 GCD**  
3️⃣ **輸出 GCD 結果**  
4️⃣ **重複執行，直到輸入 `0` 終止程式**  

---

## 📜 **歐幾里得演算法**
GCD 計算公式：
GCD(a, b) = GCD(b, a % b)
直到其中一個數為 `0`，則：
GCD(a, 0) = a

MIPS 計算：
1. `div t0,t0, a1, $a0` → 計算 `a1/a1 / a0`
2. `mul t1,t1, a0, $t0` → 計算 `a0∗(a0 * (a1 / $a0)`
3. `sub t2,t2, a1, $t1` → 計算 `$a1 % a0`
4. **遞迴呼叫** `GCD(a0, a1 % a0)`

---

## 🚀 **程式流程**
1. **輸出** `"Give two numbers:"`
2. **讀取兩個輸入值**（存入 `a0,a0, a1`）
3. **檢查是否輸入 `0`**（結束或繼續）
4. **執行 GCD 遞迴計算**
5. **輸出 `"The GCD of two numbers: X"`**
6. **程式重新開始，直到輸入 `0` 終止**

---

## 📝 **MIPS Assembly Code**
```assembly
.data 
    inputStr: .asciiz "Give two numbers: "
    outputStr: .asciiz "The GCD of two numbers: "
    endline: .asciiz "\n"

.text
main:
    # 顯示輸入提示
    li $v0, 4
    la $a0, inputStr
    syscall

    # 讀取第一個數字
    li $v0, 5
    syscall
    move a0,a0, v0

    # 讀取第二個數字
    li $v0, 5
    syscall
    move a1,a1, v0

    # TODO: 檢查是否輸入 0，若為 0 則結束程式
    beq a0,a0, 0, else
    j con

else:
    beq a1,a1, 0, exit  

con:
    # TODO: 遞迴呼叫 GCD 計算
    jal GCD
    move t0,t0, v0

    # 輸出 GCD 結果
    li $v0, 4
    la $a0, outputStr
    syscall
    move a0,a0, t0
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, endline
    syscall
    j main

# GCD 遞迴函數
GCD:
    # TODO: 保存暫存值到 Stack
    addi sp,sp, sp, -12
    sw ra,0(ra, 0(sp)
    sw s0,4(s0, 4(sp)
    sw s1,8(s1, 8(sp)

    move s0,s0, a0
    move s1,s1, a1

    # TODO: 檢查基礎條件，若 $a0 為 0 則返回
    beq s0,s0, zero, retGCD

    # TODO: 執行歐幾里得演算法
    div t0,t0, a1, $a0
    mul t1,t1, a0, $t0		
    sub t2,t2, a1, $t1
    move a1,a1, a0
    move a0,a0, t2
    bne a0,a0, 0, GCD
    j retGCD
    
return:
    # TODO: 恢復 Stack，返回主程式
    lw ra,0(ra, 0(sp)
    lw s0,4(s0, 4(sp)
    lw s1,8(s1, 8(sp)
    addi sp,sp, sp, 12
    jr $ra

retGCD:
    # TODO: 返回計算結果
    move v0,v0, a1  
    j return

exit:
    # TODO: 結束程式
    li $v0, 10
    syscall
```
