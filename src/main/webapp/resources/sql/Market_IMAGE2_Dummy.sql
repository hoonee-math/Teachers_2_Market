DECLARE
    v_product_type NUMBER;
BEGIN
    FOR i IN 1..500 LOOP
        -- POST_TYPE 조회
        BEGIN
            SELECT PRODUCT_TYPE INTO v_product_type
            FROM POST2 
            WHERE POST_NO = i;
            
            -- PRODUCT_TYPE이 1인 경우
            IF v_product_type = 1 THEN
                FOR j IN 1..3 LOOP
                    INSERT INTO IMAGE2 (IMG_NO, IMG_SEQ, POST_NO, ORINAME, RENAMED)
                    VALUES (
                        SEQ_IMAGE2_NO.NEXTVAL,
                        j,
                        i,
                        'REAL' || j || '.jpg',
                        'REAL' || j || '.jpg'
                    );
                END LOOP;
            -- PRODUCT_TYPE이 2인 경우
            ELSIF v_product_type = 2 THEN
                FOR j IN 1..3 LOOP
                    INSERT INTO IMAGE2 (IMG_NO, IMG_SEQ, POST_NO, ORINAME, RENAMED)
                    VALUES (
                        SEQ_IMAGE2_NO.NEXTVAL,
                        j,
                        i,
                        'FILE' || j || '.jpg',
                        'FILE' || j || '.jpg'
                    );
                END LOOP;
            END IF;
            
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                CONTINUE;
        END;
    END LOOP;
    COMMIT;
END;
/

select * from image2;
