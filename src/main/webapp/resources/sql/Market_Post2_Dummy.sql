DECLARE
    v_category NUMBER;
BEGIN
    FOR i IN 1..498 LOOP
        v_category := FLOOR(DBMS_RANDOM.VALUE(1,7)); -- Changed to 11 to match CASE statement
        INSERT INTO POST2 (
            POST_NO,
            POST_TITLE,
            POST_CONTENT,
            VIEW_COUNT,
            IS_TEMP,
            POST_DATE,
            IS_DELETED,
            PRODUCT_TYPE,
            SUBJECT_NO,
            MEMBER_NO,
            IS_FIX,
            CATEGORY_NO 
        ) VALUES (
            SEQ_POST2_NO.NEXTVAL,       --POST_NO
            CASE v_category            
                WHEN 1 THEN '[미취학] '
                WHEN 2 THEN '[초등] '
                WHEN 3 THEN '[중등] '
                WHEN 4 THEN '[고등] '
                WHEN 5 THEN '[수업생] '
                WHEN 6 THEN '[인기글] '
                ELSE '[기타] '
            END || '게시글 ' || SEQ_POST2_NO.CURRVAL || '번입니다',  --POST_TITLE
            '게시글 내용입니다', --POST_CONTENT
            FLOOR(DBMS_RANDOM.VALUE(1,200)), --VIEW_COUNT
            0,--IS_TEMP
            ADD_MONTHS(TRUNC(SYSDATE), -5) + (i-1) * INTERVAL '10' HOUR,  -- Modified POST_DATE calculation
            0,--IS_DELETED
            FLOOR(DBMS_RANDOM.VALUE(1,3)), --PRODUCT_TYPE
            FLOOR(DBMS_RANDOM.VALUE(1,8)), --SUBJECT_NO
            FLOOR(DBMS_RANDOM.VALUE(1,10)), --MEMBER_NO
            0,--IS_FIX
            v_category --CATEGORY_NO
        );
    END LOOP;
    COMMIT;
END;
/

SELECT * FROM POST2;

SELECT FLOOR(DBMS_RANDOM.VALUE(0,3)) FROM DUAL;

COMMIT;