-- Выводит кол-во бронирований каждого объекта клуба в месяц за 2012 год с суммарным доходом за все месяцы
-- и отдельной записью с общим доходом ВСЕХ объектов за все месяцы.
WITH incomes AS (
    SELECT
        fac.facid,
        SUM(
            IF(
                mem.surname LIKE 'GUEST',
                fac.guestcost * book.slots,
                fac.membercost * book.slots
                )
            ) - COUNT(DISTINCT MONTH(book.starttime)) * fac.monthlymaintenance AS income
    FROM cd.facilities AS fac
        LEFT JOIN cd.bookings AS book ON book.facid = fac.facid
        LEFT JOIN cd.members AS mem ON book.memid = mem.memid
    GROUP BY fac.facid
    ORDER BY income
)

SELECT
    fac.facid,
    facility,
    MONTH(book.starttime) AS month,
    COUNT(book.bookid) as rent_month,
    incomes.income AS total_income
FROM cd.facilities AS fac
    LEFT JOIN cd.bookings AS book ON book.facid = fac.facid
    LEFT JOIN incomes ON incomes.facid = fac.facid
WHERE YEAR(book.starttime) = '2012'
GROUP BY fac.facid, MONTH(book.starttime)
UNION
SELECT
    0 AS facid,
    'Общая сумма всех объектов' AS facility,
    0 AS month,
    0 AS avg_rent_month,
    SUM(income) AS total_income FROM incomes
ORDER BY total_income;