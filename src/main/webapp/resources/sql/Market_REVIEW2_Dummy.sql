-- 후기 더미데이터 생성을 위한 PL/SQL 블록
DECLARE
    -- 리뷰 내용 배열 선언 (다양한 리뷰 내용을 위해)
    TYPE review_array IS TABLE OF VARCHAR2(1000) INDEX BY BINARY_INTEGER;
    v_reviews review_array;
    
    -- 변수 선언
    v_post_no NUMBER;
    v_member_no NUMBER;
    v_rating NUMBER;
    v_review_content VARCHAR2(1000);
    v_like_count NUMBER;
BEGIN
    -- 리뷰 내용 샘플 초기화
    v_reviews(1) := '매우 만족스러운 구매였습니다. 자료가 정말 유용해요!';
    v_reviews(2) := '생각보다 좋았어요. 다음에도 구매할 것 같아요.';
    v_reviews(3) := '자료의 퀄리티가 높아서 좋았습니다.';
    v_reviews(4) := '설명이 자세해서 이해하기 쉬웠어요.';
    v_reviews(5) := '가격 대비 만족스러운 자료였습니다.';
    
    -- 500번부터 1번 게시글까지 역순으로 리뷰 생성
    FOR i IN REVERSE 1..500 LOOP
        -- 랜덤값 생성
        v_member_no := TRUNC(DBMS_RANDOM.VALUE(1, 11)); -- 1~10 랜덤
        v_rating := TRUNC(DBMS_RANDOM.VALUE(1, 6)); -- 1~5 랜덤
        v_like_count := TRUNC(DBMS_RANDOM.VALUE(0, 101)); -- 0~100 랜덤
        
        -- 랜덤 리뷰 내용 선택
        v_review_content := v_reviews(TRUNC(DBMS_RANDOM.VALUE(1, 6)));
        
        -- 리뷰 데이터 INSERT (약 20% 확률로 리뷰 생성)
        IF DBMS_RANDOM.VALUE(0, 1) < 0.2 THEN
            INSERT INTO REVIEW2 (
                REVIEW_NO,
                REVIEW_CONTENT,
                REVIEW_RATING,
                POST_NO,
                REVIEW_DATE,
                REVIEW_LIKE_COUNT,
                MEMBER_NO
            ) VALUES (
                seq_review2_no.NEXTVAL,
                v_review_content,
                v_rating,
                i, -- POST_NO를 역순으로 입력
                SYSDATE - TRUNC(DBMS_RANDOM.VALUE(0, 31)), -- 최근 30일 내 랜덤 날짜
                v_like_count,
                v_member_no
            );
        END IF;
    END LOOP;
    
    COMMIT;
END;
/

select * from review2;






-- 후기 더미데이터 생성을 위한 PL/SQL 블록
DECLARE
    -- 리뷰 내용 배열 선언 (다양한 리뷰 내용을 위해)
    TYPE review_array IS TABLE OF VARCHAR2(1000) INDEX BY BINARY_INTEGER;
    v_reviews review_array;
    
    -- 변수 선언
    v_post_no NUMBER;
    v_member_no NUMBER;
    v_rating NUMBER;
    v_review_content VARCHAR2(1000);
    v_like_count NUMBER;
BEGIN
    -- 리뷰 내용 샘플 초기화
    v_reviews(1) := '매우 만족스러운 구매였습니다. 자료가 정말 유용해요!';
    v_reviews(2) := '생각보다 좋았어요. 다음에도 구매할 것 같아요.';
    v_reviews(3) := '자료의 퀄리티가 높아서 좋았습니다.';
    v_reviews(4) := '설명이 자세해서 이해하기 쉬웠어요.';
    v_reviews(5) := '가격 대비 만족스러운 자료였습니다.';
    
    -- 500번부터 1번 게시글까지 역순으로 리뷰 생성
    FOR i IN REVERSE 1..500 LOOP
        -- 랜덤값 생성
        v_member_no := TRUNC(DBMS_RANDOM.VALUE(1, 11)); -- 1~10 랜덤
        v_rating := TRUNC(DBMS_RANDOM.VALUE(1, 6)); -- 1~5 랜덤
        v_like_count := TRUNC(DBMS_RANDOM.VALUE(0, 101)); -- 0~100 랜덤
        
        -- 랜덤 리뷰 내용 선택
        v_review_content := v_reviews(TRUNC(DBMS_RANDOM.VALUE(1, 6)));
        
        -- 리뷰 데이터 INSERT
        INSERT INTO REVIEW2 (
            REVIEW_NO,
            REVIEW_CONTENT,
            REVIEW_RATING,
            POST_NO,
            REVIEW_DATE,
            REVIEW_LIKE_COUNT,
            MEMBER_NO
        ) VALUES (
            seq_review2_no.NEXTVAL,
            v_review_content,
            v_rating,
            i, -- POST_NO를 역순으로 입력
            SYSDATE - TRUNC(DBMS_RANDOM.VALUE(0, 31)), -- 최근 30일 내 랜덤 날짜
            v_like_count,
            v_member_no
        );
    END LOOP;
    
    COMMIT;
END;
/



-- 리뷰에 연결된 이미지 더미데이터 
-- 이미지 추가를 위한 PL/SQL 블록
DECLARE
    -- 변수 선언
    v_review_count NUMBER;
    v_random_num NUMBER;
    v_image_name VARCHAR2(100);
BEGIN
    -- 전체 리뷰 개수 조회
    SELECT COUNT(*) INTO v_review_count FROM REVIEW2;
    
    -- 각 리뷰에 대해 50% 확률로 이미지 추가
    FOR r IN (SELECT REVIEW_NO FROM REVIEW2) LOOP
        -- 0 또는 1 랜덤 생성 (50% 확률)
        v_random_num := ROUND(DBMS_RANDOM.VALUE(0, 1));
        
        -- 50% 확률로 이미지 추가
        IF v_random_num = 1 THEN
            -- review1.jpg 또는 review2.jpg 랜덤 선택
            v_image_name := 'review' || ROUND(DBMS_RANDOM.VALUE(1, 2)) || '.jpg';
            
            -- 이미지 데이터 INSERT
            INSERT INTO IMAGE2 (
                IMG_NO,        -- 이미지 고유번호
                IMG_SEQ,       -- 기본값 1 사용
                POST_NO,       -- NULL
                REVIEW_NO,     -- 현재 순회중인 리뷰 번호
                ORINAME,       -- 원본 파일명
                RENAMED        -- 저장된 파일명 (여기서는 원본과 동일하게 설정)
            ) VALUES (
                seq_image2_no.NEXTVAL,
                1,            
                NULL,         
                r.REVIEW_NO,   
                v_image_name,  
                v_image_name   
            );
        END IF;
    END LOOP;
    
    COMMIT;
END;
/

commit;