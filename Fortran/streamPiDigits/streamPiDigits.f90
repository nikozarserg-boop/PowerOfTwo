program StreamPiDigits
    implicit none
    
    integer :: MAX_DIGITS = 100000
    integer :: LEN_ARRAY
    integer, allocatable :: a(:)
    integer :: j, i, q, x, nines, predigit
    integer :: unit_number = 10
    character(len=256) :: log_file = "pi_digits_fortran.log"
    
    print *, 'Computing Pi Decimal Digits (Spigot Algorithm - Infinite)'
    print *, '========================================================='
    
    LEN_ARRAY = (10 * MAX_DIGITS) / 3
    
    allocate(a(LEN_ARRAY))
    
    a = 2
    
    open(unit=unit_number, file=trim(log_file), status='replace', action='write')
    
    print *, 'Logging to: ', trim(log_file)
    print *
    
    nines = 0
    predigit = 0
    
    write(*, '(A)', advance='no') '3.'
    write(unit_number, '(A)', advance='no') '3.'
    
    do j = 1, MAX_DIGITS
        q = 0
        
        do i = LEN_ARRAY, 1, -1
            x = 10 * a(i) + q * i
            a(i) = mod(x, 2 * i - 1)
            q = x / (2 * i - 1)
        end do
        
        a(1) = mod(q, 10)
        q = q / 10
        
        if (q == 9) then
            nines = nines + 1
        else if (q == 10) then
            write(*, '(I0)', advance='no') predigit + 1
            write(unit_number, '(I0)', advance='no') predigit + 1
            do i = 1, nines
                write(*, '(A)', advance='no') '0'
                write(unit_number, '(A)', advance='no') '0'
            end do
            predigit = 0
            nines = 0
        else
            write(*, '(I0)', advance='no') predigit
            write(unit_number, '(I0)', advance='no') predigit
            predigit = q
            if (nines /= 0) then
                do i = 1, nines
                    write(*, '(A)', advance='no') '9'
                    write(unit_number, '(A)', advance='no') '9'
                end do
                nines = 0
            end if
        end if
        
        if (mod(j, 50) == 0) then
            write(*, *)
            write(unit_number, *)
        end if
        
        if (mod(j, 500) == 0) then
            write(*, '(A, I0, A)') 'Progress: ', j, ' digits...'
        end if
        
        flush(unit_number)
    end do
    
    print *
    write(unit_number, *)
    
    write(*, '(I0)') predigit
    write(unit_number, '(I0)') predigit
    
    write(*, '(A, I0, A)') 'Finished. Generated ', MAX_DIGITS, ' digits.'
    write(unit_number, '(A, I0, A)') 'Finished. Generated ', MAX_DIGITS, ' digits.'
    
    close(unit_number)
    deallocate(a)
    
end program StreamPiDigits
