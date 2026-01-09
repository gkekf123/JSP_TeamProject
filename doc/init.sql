USE foodroad;

-- 1. 회원 테이블
CREATE TABLE member (
    member_idx      BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '회원 고유 번호',
    member_id       VARCHAR(50) NOT NULL UNIQUE COMMENT '회원 ID',
    member_pw       VARCHAR(255) NOT NULL COMMENT '비밀번호',
    member_name     VARCHAR(30) NOT NULL COMMENT '이름/닉네임',
    member_role     VARCHAR(20) DEFAULT 'USER' COMMENT '권한 (USER, ADMIN)',
    member_email    VARCHAR(100) COMMENT '연락용 이메일',
    member_hp       VARCHAR(20) COMMENT '전화번호',
    member_addr     VARCHAR(200) COMMENT '주소',
    member_img      VARCHAR(500) DEFAULT 'default.png' COMMENT '프로필 사진',
    member_joinday  TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '가입일'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='회원 정보';

-- 2. 가게 테이블
CREATE TABLE store (
    store_idx           BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '가게 고유 번호',
    store_name          VARCHAR(100) NOT NULL COMMENT '가게 이름',
    store_category      VARCHAR(100) COMMENT '카테고리',
    store_addr          VARCHAR(255) NOT NULL COMMENT '도로명 주소',
    store_img           VARCHAR(500) DEFAULT 'no_image.png' COMMENT '썸네일 이미지',
    store_intro         TEXT COMMENT '가게 한줄 소개',
    store_tel           VARCHAR(30) COMMENT '전화번호',
    store_rating_count  INT DEFAULT 0 COMMENT '리뷰 갯수 (리뷰순 정렬용)',
    store_rating_avg    DECIMAL(2, 1) DEFAULT 0.0 COMMENT '평균 별점 (별점순 정렬용)',
    store_view_count    INT DEFAULT 0 COMMENT '조회수 (인기순 정렬용)',
    latitude            DECIMAL(10, 8) COMMENT '위도 (y좌표)',
    longitude           DECIMAL(11, 8) COMMENT '경도 (x좌표)',
    store_created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
    store_update_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
    INDEX idx_store_category (store_category),
    INDEX idx_store_rating (store_rating_avg DESC),
    INDEX idx_store_view (store_view_count DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='가게 정보';

-- 3. 메뉴 테이블
CREATE TABLE menu (
    menu_idx    BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '메뉴 고유 번호',
    store_idx   BIGINT NOT NULL COMMENT '가게 고유 번호',
    menu_name   VARCHAR(100) NOT NULL COMMENT '메뉴 이름',
    menu_price  INT NOT NULL COMMENT '가격',
    menu_img    VARCHAR(500) COMMENT '메뉴 사진 경로',
    CONSTRAINT fk_menu_store FOREIGN KEY (store_idx) REFERENCES store(store_idx) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='가게 메뉴';

-- 4. 리뷰 테이블
CREATE TABLE review (
    review_idx          BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '리뷰 고유 번호',
    store_idx           BIGINT NOT NULL COMMENT '가게 고유 번호',
    member_id           VARCHAR(50) NOT NULL COMMENT '회원 ID (작성자)',
    review_rating       INT NOT NULL CHECK (review_rating BETWEEN 1 AND 5) COMMENT '별점(1~5)',
    review_content      TEXT NOT NULL COMMENT '리뷰 내용',
    review_img          VARCHAR(500) COMMENT '리뷰 사진',
    review_created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
    review_update_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
    CONSTRAINT fk_review_store FOREIGN KEY (store_idx) REFERENCES store(store_idx) ON DELETE CASCADE,
    CONSTRAINT fk_review_member FOREIGN KEY (member_id) REFERENCES member(member_id) ON DELETE CASCADE,
    INDEX idx_review_store (store_idx)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='리뷰';

-- 5. 찜(즐겨찾기) 테이블
CREATE TABLE bookmark (
    like_idx    BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '찜 고유 번호',
    member_id   VARCHAR(50) NOT NULL COMMENT '회원 ID',
    store_idx   BIGINT NOT NULL COMMENT '가게 고유 번호',
    like_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '찜한 날짜',
    UNIQUE KEY uk_bookmark (member_id, store_idx),
    CONSTRAINT fk_bookmark_member FOREIGN KEY (member_id) REFERENCES member(member_id) ON DELETE CASCADE,
    CONSTRAINT fk_bookmark_store FOREIGN KEY (store_idx) REFERENCES store(store_idx) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='찜 목록';

-- 6. 제미나이 검색 기록 로그
CREATE TABLE search_log (
    log_idx       BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '로그 고유 번호',
    search_query  TEXT COMMENT '검색어',
    ai_response   TEXT COMMENT 'AI 응답',
    search_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '검색 일시'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI 검색 로그';

-- 7. 뉴스 테이블
CREATE TABLE news (
    news_idx      BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '뉴스 고유 번호',
    news_title    VARCHAR(200) NOT NULL COMMENT '기사 제목',
    news_url      VARCHAR(1000) NOT NULL COMMENT '기사 URL',
    news_img      VARCHAR(500) COMMENT '썸네일 이미지',
    news_source   VARCHAR(50) COMMENT '출처',
    news_regdate  TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '등록일'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='뉴스 기사';

-- 테스트 데이터 입력 (이미지 파일명: test1.jpg, test2.jpg)
INSERT INTO store (store_name, store_category, store_addr, store_img, store_rating_avg, store_rating_count, store_view_count)
VALUES 
('맛집', '한식', '서울시 강남구 역삼동 123', 'test1.jpg', 4.8, 120, 500),
('강남 파스타', '양식', '서울시 강남구 삼성동 456', 'test2.jpg', 4.2, 55, 300);

SELECT *
FROM store
;