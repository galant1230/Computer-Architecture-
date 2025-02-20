.data                                                    #數據段，能作為全區變數(global variables)
    inputStr: .asciiz "Give two numbers: "                  #是使用ascii碼
    outputStr: .asciiz "The GCD of two numbers: "
    endline: .asciiz "\n"
.text                                                    #程式指令區塊
main:
    # Give Input message and store input numbers to $a0 and $a1，此處即是印出Give two numbers，並讓使用者輸入兩個數值
                                                        #li $v0, NUMBER，v0-v1屬於回傳值暫存器
                                                        #li=Load Immediately，將NUMBER存入$v0裏面，這個程序是?了接下來system call所做，$v0內的數值不同，呼叫system call時會有不同的行?
                                                        #且Syscall與v0值習習相關，而Syscall能使用的數字會在$a0
                                                        
    li $v0, 4                                           #v0-4此時syscall，會print出存在$a0內目標地址的字串(string)
    la $a0, inputStr                                    # la=Load Address，把input的地址讀入$a0中，$a0-$a3屬於參數暫存器，並且是為了能讓Syscall使用
    syscall                                          
   
    li $v0, 5                                           #此時syscall，會讀入使用者輸入的數值，並且將數值存到$v0，會取代原本的數值 -------->(li $v0,5)這個指令
    syscall                                         
    add $a0, $v0, $zero                                 # 利用加法去進行把v0(即我們要的number1)加載到a0的動作                      
    li $v0, 5                                           
    syscall
    add $a1, $v0, $zero                                  # 利用加法去進行把v0(即我們要的number2)加載到a1的動作
    # TODO: The condition of the process terminated
    beq $a0 , $0 , else                                 #在Mips之中沒有if語法，因此可以透過beq去實現判斷，若是a0(使用者輸入的第一個值)
                                                        #並不為0，則能透過GCD進行輾轉相除法
    j Euclidean
       else:                                                #若a0是0再來進行a1的判斷，若a1也是0，則直接結束程式
    beq $a1 , $0 , exit  
    
Euclidean:
    # call GCD function recursively
    jal GCD                                               # 去執行GCD
    add $t0, $v0, $zero                                      

    # print the answer
    li $v0, 4                                             # 輸出The GCD of two numbers此字串
    la $a0, outputStr                                    
    syscall                                            
    
    add $a0, $t0, $zero                                  # $a0 = $t0; put gcd result in $a0 for output
    li $v0, 1                                            #此時syscall，會print出存在$a0內的數值(integer)
    syscall                                              # output result from gcd
    
    li $v0, 4                                            #換行
    la $a0, endline                                     
    syscall                                             
    j main
# END Main

GCD:
    #GCD(n1, n2)
    # n1 = $a0
    # n2 = $a1
    # save in the stack
    addi $sp, $sp, -12                  # adjust stack for 3 items
    sw $ra, 0($sp)                      # save function into stack
    sw $s0, 4($sp)                      # save value $s0 into stack 
    sw $s1, 8($sp)                      # save value $s1 into stack 

    add $s0, $a0, $zero                 # s0 = a0 ( value n1 ) 
    add $s1, $a1, $zero                 # s1 = a1 ( value n2 ) 

    beq $s0, $zero, retGCD        

    # TODO: Do Euclidean Algorithm
    div $t0, $a1, $a0                   #此處即為輾轉相除法的步驟
    mul $t1, $a0, $t0		
    sub $t2, $a1, $t1
    add $a1, $zero, $a0
    add $a0, $zero, $t2
    bne $a0, $0, GCD
    j retGCD




return:
    lw $ra, 0($sp)                       #前面store做完再把pointer放回去原本的位置
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra

retGCD:
    # TODO: What do you need to return?
    li $v0, 1                      #回傳值回去
    addi $v0, $a1,0
    j return
# END GCD

exit:
    # The program is finished running
    li $v0, 10                   #代表直接結束程式
    syscall
