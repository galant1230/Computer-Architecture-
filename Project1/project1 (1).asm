.data                                                    #�ƾڬq�A��@�������ܼ�(global variables)
    inputStr: .asciiz "Give two numbers: "                  #�O�ϥ�ascii�X
    outputStr: .asciiz "The GCD of two numbers: "
    endline: .asciiz "\n"
.text                                                    #�{�����O�϶�
main:
    # Give Input message and store input numbers to $a0 and $a1�A���B�Y�O�L�XGive two numbers�A�����ϥΪ̿�J��Ӽƭ�
                                                        #li $v0, NUMBER�Av0-v1�ݩ�^�ǭȼȦs��
                                                        #li=Load Immediately�A�NNUMBER�s�J$v0�ح��A�o�ӵ{�ǬO?�F���U��system call�Ұ��A$v0�����ƭȤ��P�A�I�ssystem call�ɷ|�����P����?
                                                        #�BSyscall�Pv0�Ȳ߲߬����A��Syscall��ϥΪ��Ʀr�|�b$a0
                                                        
    li $v0, 4                                           #v0-4����syscall�A�|print�X�s�b$a0���ؼЦa�}���r��(string)
    la $a0, inputStr                                    # la=Load Address�A��input���a�}Ū�J$a0���A$a0-$a3�ݩ�ѼƼȦs���A�åB�O���F����Syscall�ϥ�
    syscall                                          
   
    li $v0, 5                                           #����syscall�A�|Ū�J�ϥΪ̿�J���ƭȡA�åB�N�ƭȦs��$v0�A�|���N�쥻���ƭ� -------->(li $v0,5)�o�ӫ��O
    syscall                                         
    add $a0, $v0, $zero                                 # �Q�Υ[�k�h�i���v0(�Y�ڭ̭n��number1)�[����a0���ʧ@                      
    li $v0, 5                                           
    syscall
    add $a1, $v0, $zero                                  # �Q�Υ[�k�h�i���v0(�Y�ڭ̭n��number2)�[����a1���ʧ@
    # TODO: The condition of the process terminated
    beq $a0 , $0 , else                                 #�bMips�����S��if�y�k�A�]���i�H�z�Lbeq�h��{�P�_�A�Y�Oa0(�ϥΪ̿�J���Ĥ@�ӭ�)
                                                        #�ä���0�A�h��z�LGCD�i������۰��k
    j Euclidean
       else:                                                #�Ya0�O0�A�Ӷi��a1���P�_�A�Ya1�]�O0�A�h���������{��
    beq $a1 , $0 , exit  
    
Euclidean:
    # call GCD function recursively
    jal GCD                                               # �h����GCD
    add $t0, $v0, $zero                                      

    # print the answer
    li $v0, 4                                             # ��XThe GCD of two numbers���r��
    la $a0, outputStr                                    
    syscall                                            
    
    add $a0, $t0, $zero                                  # $a0 = $t0; put gcd result in $a0 for output
    li $v0, 1                                            #����syscall�A�|print�X�s�b$a0�����ƭ�(integer)
    syscall                                              # output result from gcd
    
    li $v0, 4                                            #����
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
    div $t0, $a1, $a0                   #���B�Y������۰��k���B�J
    mul $t1, $a0, $t0		
    sub $t2, $a1, $t1
    add $a1, $zero, $a0
    add $a0, $zero, $t2
    bne $a0, $0, GCD
    j retGCD




return:
    lw $ra, 0($sp)                       #�e��store�����A��pointer��^�h�쥻����m
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra

retGCD:
    # TODO: What do you need to return?
    li $v0, 1                      #�^�ǭȦ^�h
    addi $v0, $a1,0
    j return
# END GCD

exit:
    # The program is finished running
    li $v0, 10                   #�N���������{��
    syscall
