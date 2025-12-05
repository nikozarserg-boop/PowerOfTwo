program PowerOfTwo
    implicit none
    
    integer :: power, log_unit, ios
    character(len=512) :: log_file, exe_path
    integer, allocatable :: digits(:)
    integer :: max_digits, num_digits, i, digit, last_slash
    logical :: file_exists
    
    call get_command_argument(0, exe_path)
    last_slash = index(exe_path, '\', back=.true.)
    if (last_slash > 0) then
        log_file = exe_path(1:last_slash) // "PowerOfTwo.log"
    else
        log_file = "PowerOfTwo.log"
    end if
    
    open(newunit=log_unit, file=log_file, status='replace', action='write', iostat=ios)
    if (ios /= 0) then
        print *, "Ошибка: не удалось открыть файл для записи"
        stop 1
    end if
    
    write(log_unit, '(A)') "Вычисление степеней двойки (Big Integer на Fortran)"
    write(log_unit, '(A)') "======================================================"
    write(log_unit, '(A)') ""
    flush(log_unit)
    
    print *, "Вычисление степеней двойки (Big Integer)"
    print *, "========================================"
    print *, ""
    
    max_digits = 10000
    allocate(digits(max_digits), stat=ios)
    if (ios /= 0) then
        write(log_unit, '(A)') "Ошибка: не удалось выделить память для массива"
        print *, "Ошибка: не удалось выделить память"
        close(log_unit)
        stop 1
    end if
    
    digits = 0
    digits(1) = 1
    num_digits = 1
    
    power = 0
    do while (.true.)
        call print_number(log_unit, power, digits, num_digits)
        
        call multiply_by_2(digits, num_digits, max_digits)
        
        if (num_digits > max_digits) then
            write(log_unit, '(A,I0,A)') new_line('A'), "Ошибка: недостаточно памяти на степени 2^", power+1
            print *, ""
            print *, "Ошибка: недостаточно памяти на степени 2^", power+1
            exit
        end if
        
        power = power + 1
    end do
    
    deallocate(digits)
    close(log_unit)
    
contains

    subroutine multiply_by_2(digits, num_digits, max_digits)
        integer, intent(inout) :: digits(:), num_digits
        integer, intent(in) :: max_digits
        integer :: i, carry, product
        
        carry = 0
        do i = 1, num_digits
            product = digits(i) * 2 + carry
            digits(i) = mod(product, 10)
            carry = product / 10
        end do
        
        do while (carry > 0)
            num_digits = num_digits + 1
            if (num_digits > max_digits) return
            digits(num_digits) = mod(carry, 10)
            carry = carry / 10
        end do
    end subroutine multiply_by_2
    
    subroutine print_number(unit, power, digits, num_digits)
        integer, intent(in) :: unit, power, num_digits, digits(:)
        integer :: i
        character(len=20) :: power_str
        character(len=20000) :: num_str
        
        write(power_str, '(I0)') power
        
        do i = num_digits, 1, -1
            write(num_str(num_digits-i+1:num_digits-i+1), '(I1)') digits(i)
        end do
        
        write(unit, '(A,A,A,A)') "2^", trim(power_str), " = ", trim(adjustl(num_str(:num_digits)))
        flush(unit)
        
        print '(A,A,A,A)', "2^", trim(power_str), " = ", trim(adjustl(num_str(:num_digits)))
    end subroutine print_number

end program PowerOfTwo
