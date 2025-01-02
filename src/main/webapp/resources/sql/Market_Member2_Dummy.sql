DECLARE
BEGIN
   FOR i IN 1..10 LOOP
       INSERT INTO MEMBER2 (
           MEMBER_NO,
           MEMBER_NAME,
           MEMBER_ID,
           MEMBER_PW,
           EMAIL,
           PHONE,
           IS_DELETED,
           ADDRESS,
           BIRTHDAY,
           EDU_TYPE,
           SUBJECT_NO
       ) VALUES (
           SEQ_MEMBER2_NO.NEXTVAL,
           '회원' || SEQ_MEMBER2_NO.CURRVAL,
           'user' || SEQ_MEMBER2_NO.CURRVAL,
           'pass' || SEQ_MEMBER2_NO.CURRVAL,
           'user' || SEQ_MEMBER2_NO.CURRVAL || '@email.com',
           '010' || LPAD(FLOOR(DBMS_RANDOM.VALUE(10000000, 99999999)), 8, '0'),
           0,
           '서울시 강남구 테헤란로 ' || FLOOR(DBMS_RANDOM.VALUE(1, 100)) || '길',
           TO_CHAR(ADD_MONTHS(TO_DATE('1980-01-01', 'YYYY-MM-DD'), FLOOR(DBMS_RANDOM.VALUE(0, 240))), 'YYYYMMDD'),
           FLOOR(DBMS_RANDOM.VALUE(1, 4)),
           FLOOR(DBMS_RANDOM.VALUE(1, 7))
       );
   END LOOP;
   COMMIT;
END;/

SELECT * FROM MEMBER2;

UPDATE MEMBER2 
SET ADDRESS = '서울시 금천구 벚꽃로 266'
WHERE MEMBER_NO <= 10;